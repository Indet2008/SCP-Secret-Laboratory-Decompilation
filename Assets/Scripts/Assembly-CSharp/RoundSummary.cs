using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using CentralAuth;
using GameCore;
using InventorySystem.Disarming;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MEC;
using MapGeneration.Holidays;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using PlayerStatsSystem;
using RoundRestarting;
using UnityEngine;
using Utils.NonAllocLINQ;

public class RoundSummary : NetworkBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.Image fadeOutImage;

	public global::TMPro.TextMeshProUGUI ui_text_header;

	public global::TMPro.TextMeshProUGUI ui_text_who_won;

	public global::TMPro.TextMeshProUGUI ui_text_info;


	public delegate void RoundEnded(LeadingTeam leadingTeam, SumInfo_ClassList sumInfo);

	public enum LeadingTeam : byte
	{
		FacilityForces = 0,
		ChaosInsurgency = 1,
		Anomalies = 2,
		Flamingos = 3,
		Draw = 4
	}

	[Serializable]
	public struct SumInfo_ClassList : IEquatable<SumInfo_ClassList>
	{
		public int class_ds;

		public int scientists;

		public int chaos_insurgents;

		public int mtf_and_guards;

		public int scps_except_zombies;

		public int zombies;

		public int warhead_kills;

		public int flamingos;

		public bool Equals(SumInfo_ClassList other)
		{
			if (class_ds == other.class_ds && scientists == other.scientists && chaos_insurgents == other.chaos_insurgents && mtf_and_guards == other.mtf_and_guards && scps_except_zombies == other.scps_except_zombies && zombies == other.zombies && warhead_kills == other.warhead_kills)
			{
				return flamingos == other.flamingos;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is SumInfo_ClassList other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (((((((((((((class_ds * 397) ^ scientists) * 397) ^ chaos_insurgents) * 397) ^ mtf_and_guards) * 397) ^ scps_except_zombies) * 397) ^ zombies) * 397) ^ warhead_kills) * 397) ^ flamingos;
		}

		public static bool operator ==(SumInfo_ClassList left, SumInfo_ClassList right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(SumInfo_ClassList left, SumInfo_ClassList right)
		{
			return !left.Equals(right);
		}
	}

	[SyncVar]
	private int _extraTargets;

	[SyncVar]
	private int _targetCount;

	private bool _summaryActive;

	private CoroutineHandle _roundEndCoroutine;

	public bool KeepRoundOnOne;

	public bool IsRoundEnded;

	public SumInfo_ClassList classlistStart;

	public GameObject ui_root;

	public HolidayAudioClip RoundEndSfx;

	public static bool RoundLock;

	public static RoundSummary singleton;

	private static bool _singletonSet;

	public static int roundTime;

	public static bool SummaryActive
	{
		get
		{
			if (_singletonSet)
			{
				return singleton._summaryActive;
			}
			return false;
		}
	}

	public int ExtraTargets
	{
		get
		{
			return _extraTargets;
		}
		set
		{
			if (NetworkServer.active)
			{
				Network_extraTargets = value;
			}
		}
	}

	public int TargetCount
	{
		get
		{
			return _targetCount;
		}
		set
		{
			if (NetworkServer.active)
			{
				Network_targetCount = value;
			}
		}
	}

	public static int Kills { get; private set; }

	public static int EscapedClassD { get; private set; }

	public static int EscapedScientists { get; private set; }

	public static int SurvivingSCPs { get; private set; }

	public static int KilledBySCPs { get; private set; }

	public static int ChangedIntoZombies { get; private set; }

	public int Network_extraTargets
	{
		get
		{
			return _extraTargets;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _extraTargets, 1uL, null);
		}
	}

	public int Network_targetCount
	{
		get
		{
			return _targetCount;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref _targetCount, 2uL, null);
		}
	}

	public static event RoundEnded OnRoundEnded;

	private void Start()
	{
		singleton = this;
		_singletonSet = true;
		IsRoundEnded = false;
		if (NetworkServer.active)
		{
			roundTime = 0;
			KeepRoundOnOne = !ConfigFile.ServerConfig.GetBool("end_round_on_one_player");
			Timing.RunCoroutine(_ProcessServerSideCode().CancelWith(base.gameObject), Segment.FixedUpdate);
			KilledBySCPs = 0;
			EscapedClassD = 0;
			EscapedScientists = 0;
			ChangedIntoZombies = 0;
			Kills = 0;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
			UpdateTargetCount();
		}
	}

	private void OnDestroy()
	{
		_singletonSet = false;
		PlayerRoleManager.OnServerRoleSet -= OnServerRoleSet;
		PlayerStats.OnAnyPlayerDied -= OnAnyPlayerDied;
	}

	private void OnAnyPlayerDied(ReferenceHub ply, DamageHandlerBase handler)
	{
		Kills++;
		PlayerRoleBase result;
		if (handler is UniversalDamageHandler universalDamageHandler)
		{
			if (universalDamageHandler.TranslationId != DeathTranslations.PocketDecay.Id)
			{
				return;
			}
		}
		else if (!(handler is AttackerDamageHandler attackerDamageHandler) || !attackerDamageHandler.Attacker.Role.TryGetRoleTemplate<PlayerRoleBase>(out result) || result.Team != Team.SCPs)
		{
			return;
		}
		KilledBySCPs++;
	}

	private void OnServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
	{
		switch (reason)
		{
		case RoleChangeReason.RoundStart:
		case RoleChangeReason.LateJoin:
			ModifySpawnedTeam(userHub.GetTeam(), -1);
			ModifySpawnedTeam(newRole.GetTeam(), 1);
			break;
		case RoleChangeReason.Escaped:
			if (!userHub.inventory.IsDisarmed())
			{
				switch (newRole.GetTeam())
				{
				case Team.FoundationForces:
					EscapedScientists++;
					break;
				case Team.ChaosInsurgency:
					EscapedClassD++;
					break;
				}
			}
			break;
		case RoleChangeReason.Revived:
			if (newRole != RoleTypeId.Flamingo)
			{
				ChangedIntoZombies++;
				classlistStart.zombies++;
			}
			break;
		}
		UpdateTargetCount();
	}

	private void UpdateTargetCount()
	{
		if (NetworkServer.active)
		{
			TargetCount = ReferenceHub.AllHubs.Count((ReferenceHub hub) =>
			{
				Faction faction = hub.GetFaction();
				return faction == Faction.FoundationStaff || faction == Faction.FoundationEnemy || faction == Faction.Flamingos;
			});
		}
	}

	private void ModifySpawnedTeam(Team t, int modifyAmount)
	{
		switch (t)
		{
		case Team.ChaosInsurgency:
			classlistStart.chaos_insurgents += modifyAmount;
			break;
		case Team.ClassD:
			classlistStart.class_ds += modifyAmount;
			break;
		case Team.FoundationForces:
			classlistStart.mtf_and_guards += modifyAmount;
			break;
		case Team.Scientists:
			classlistStart.scientists += modifyAmount;
			break;
		case Team.SCPs:
			classlistStart.scps_except_zombies += modifyAmount;
			break;
		}
	}

	public void ForceEnd()
	{
		IsRoundEnded = true;
	}

	public void CancelRoundEnding()
	{
		if (NetworkServer.active && IsRoundEnded)
		{
			IsRoundEnded = false;
			Timing.KillCoroutines(_roundEndCoroutine);
			RpcHideRoundSummary();
			RpcUndimScreen();
		}
	}

	public int CountRole(RoleTypeId role)
	{
		return ReferenceHub.AllHubs.Count((ReferenceHub x) => x.GetRoleId() == role);
	}

	public int CountTeam(Team team)
	{
		return ReferenceHub.AllHubs.Count((ReferenceHub x) => x.GetTeam() == team);
	}

	private IEnumerator<float> _ProcessServerSideCode()
	{
		float time = Time.unscaledTime;
		while (this != null)
		{
			yield return Timing.WaitForSeconds(2.5f);
			if (NetworkServer.active)
			{
				UpdateTargetCount();
			}
			if (!IsRoundEnded && (RoundLock || (KeepRoundOnOne && ReferenceHub.AllHubs.Count((ReferenceHub x) => x.authManager.InstanceMode != ClientInstanceMode.DedicatedServer) < 2) || !RoundInProgress() || Time.unscaledTime - time < 15f))
			{
				continue;
			}
			SumInfo_ClassList newList = default;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				switch (allHub.GetTeam())
				{
				case Team.ClassD:
					newList.class_ds++;
					break;
				case Team.ChaosInsurgency:
					newList.chaos_insurgents++;
					break;
				case Team.FoundationForces:
					newList.mtf_and_guards++;
					break;
				case Team.Scientists:
					newList.scientists++;
					break;
				case Team.Flamingos:
					newList.flamingos++;
					break;
				case Team.SCPs:
					if (allHub.GetRoleId() == RoleTypeId.Scp0492)
					{
						newList.zombies++;
					}
					else
					{
						newList.scps_except_zombies++;
					}
					break;
				}
			}
			yield return float.NegativeInfinity;
			newList.warhead_kills = (AlphaWarheadController.Detonated ? AlphaWarheadController.Singleton.WarheadKills : (-1));
			yield return float.NegativeInfinity;
			int num = newList.mtf_and_guards + newList.scientists;
			int num2 = newList.chaos_insurgents + newList.class_ds;
			int num3 = newList.scps_except_zombies + newList.zombies;
			int num4 = newList.class_ds + EscapedClassD;
			int num5 = newList.scientists + EscapedScientists;
			int flamingos = newList.flamingos;
			SurvivingSCPs = newList.scps_except_zombies;
			float num6 = ((classlistStart.class_ds != 0) ? (num4 / classlistStart.class_ds) : 0);
			float num7 = ((classlistStart.scientists == 0) ? 1 : (num5 / classlistStart.scientists));
			int num8 = 0;
			if (num > 0)
			{
				num8++;
			}
			if (num2 > 0)
			{
				num8++;
			}
			if (num3 > 0)
			{
				num8++;
			}
			if (flamingos > 0)
			{
				num8++;
			}
			if (ExtraTargets > 0)
			{
				num8++;
			}
			IsRoundEnded = num8 <= 1;
			RoundEndingConditionsCheckEventArgs e = new RoundEndingConditionsCheckEventArgs(IsRoundEnded);
			ServerEvents.OnRoundEndingConditionsCheck(e);
			IsRoundEnded = e.CanEnd;
			if (!IsRoundEnded)
			{
				continue;
			}
			bool num9 = num > 0;
			bool flag = num2 > 0;
			bool flag2 = num3 > 0;
			bool flag3 = flamingos > 0;
			LeadingTeam leadingTeam = LeadingTeam.Draw;
			if (num9)
			{
				leadingTeam = ((EscapedScientists < EscapedClassD) ? LeadingTeam.Draw : LeadingTeam.FacilityForces);
			}
			else if (flag2 || (flag2 & flag))
			{
				leadingTeam = ((EscapedClassD > SurvivingSCPs) ? LeadingTeam.ChaosInsurgency : ((SurvivingSCPs > EscapedScientists) ? LeadingTeam.Anomalies : LeadingTeam.Draw));
			}
			else if (flag)
			{
				leadingTeam = ((EscapedClassD >= EscapedScientists) ? LeadingTeam.ChaosInsurgency : LeadingTeam.Draw);
			}
			else if (flag3)
			{
				leadingTeam = LeadingTeam.Flamingos;
			}
			RoundEndingEventArgs e2 = new RoundEndingEventArgs(leadingTeam);
			ServerEvents.OnRoundEnding(e2);
			if (e2.IsAllowed)
			{
				leadingTeam = e2.LeadingTeam;
				OnRoundEnded?.Invoke(leadingTeam, newList);
				FriendlyFireConfig.PauseDetector = true;
				string text = "Round finished! Anomalies: " + num3 + " | Chaos: " + num2 + " | Facility Forces: " + num + " | D escaped percentage: " + num6 + " | S escaped percentage: " + num7 + ".";
				GameCore.Console.AddLog(text, Color.gray);
				ServerLogs.AddLog(ServerLogs.Modules.GameLogic, text, ServerLogs.ServerLogType.GameEvent);
				yield return Timing.WaitForSeconds(1.5f);
				RoundEndedEventArgs e3 = new RoundEndedEventArgs(leadingTeam);
				ServerEvents.OnRoundEnded(e3);
				bool showSummary = e3.ShowSummary;
				int num10 = Mathf.Clamp(ConfigFile.ServerConfig.GetInt("auto_round_restart_time", 10), 5, 1000);
				if ((this != null) & showSummary)
				{
					RpcShowRoundSummary(classlistStart, newList, leadingTeam, EscapedClassD, EscapedScientists, KilledBySCPs, num10, (int)RoundStart.RoundLength.TotalSeconds);
				}
				_roundEndCoroutine = Timing.RunCoroutine(InitiateRoundEnd(num10), Segment.FixedUpdate);
				yield return Timing.WaitUntilDone(_roundEndCoroutine);
			}
		}
	}

	private IEnumerator<float> InitiateRoundEnd(int timeToRoundRestart)
	{
		yield return Timing.WaitForSeconds(timeToRoundRestart - 1);
		if (IsRoundEnded)
		{
			RpcDimScreen();
			yield return Timing.WaitForSeconds(1f);
			RoundRestart.InitiateRoundRestart();
		}
	}

	[ClientRpc]
	private void RpcShowRoundSummary(SumInfo_ClassList listStart, SumInfo_ClassList listFinish, LeadingTeam leadingTeam, int eDS, int eSc, int scpKills, int roundCd, int seconds)
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		GeneratedNetworkCode._Write_RoundSummary_002FSumInfo_ClassList(writer, listStart);
		GeneratedNetworkCode._Write_RoundSummary_002FSumInfo_ClassList(writer, listFinish);
		GeneratedNetworkCode._Write_RoundSummary_002FLeadingTeam(writer, leadingTeam);
		writer.WriteInt(eDS);
		writer.WriteInt(eSc);
		writer.WriteInt(scpKills);
		writer.WriteInt(roundCd);
		writer.WriteInt(seconds);
		SendRPCInternal("System.Void RoundSummary::RpcShowRoundSummary(RoundSummary/SumInfo_ClassList,RoundSummary/SumInfo_ClassList,RoundSummary/LeadingTeam,System.Int32,System.Int32,System.Int32,System.Int32,System.Int32)", -173396156, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	[ClientRpc]
	private void RpcHideRoundSummary()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void RoundSummary::RpcHideRoundSummary()", 593541252, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	[ClientRpc]
	private void RpcDimScreen()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void RoundSummary::RpcDimScreen()", -1745793588, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	[ClientRpc]
	private void RpcUndimScreen()
	{
		NetworkWriterPooled writer = NetworkWriterPool.Get();
		SendRPCInternal("System.Void RoundSummary::RpcUndimScreen()", 44991443, writer, 0, includeOwner: true);
		NetworkWriterPool.Return(writer);
	}

	public static bool RoundInProgress()
	{
		if (!_singletonSet)
		{
			return false;
		}
		if (!ReferenceHub.TryGetHostHub(out var hub))
		{
			return false;
		}
		return hub.characterClassManager.RoundStarted;
	}

	public override bool Weaved()
	{
		return true;
	}

	protected void UserCode_RpcShowRoundSummary__SumInfo_ClassList__SumInfo_ClassList__LeadingTeam__Int32__Int32__Int32__Int32__Int32(SumInfo_ClassList listStart, SumInfo_ClassList listFinish, LeadingTeam leadingTeam, int eDS, int eSc, int scpKills, int roundCd, int seconds)
	{
		_summaryActive = true;
	}

	protected static void InvokeUserCode_RpcShowRoundSummary__SumInfo_ClassList__SumInfo_ClassList__LeadingTeam__Int32__Int32__Int32__Int32__Int32(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcShowRoundSummary called on server.");
		}
		else
		{
			((RoundSummary)obj).UserCode_RpcShowRoundSummary__SumInfo_ClassList__SumInfo_ClassList__LeadingTeam__Int32__Int32__Int32__Int32__Int32(GeneratedNetworkCode._Read_RoundSummary_002FSumInfo_ClassList(reader), GeneratedNetworkCode._Read_RoundSummary_002FSumInfo_ClassList(reader), GeneratedNetworkCode._Read_RoundSummary_002FLeadingTeam(reader), reader.ReadInt(), reader.ReadInt(), reader.ReadInt(), reader.ReadInt(), reader.ReadInt());
		}
	}

	protected void UserCode_RpcHideRoundSummary()
	{
		_summaryActive = false;
	}

	protected static void InvokeUserCode_RpcHideRoundSummary(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcHideRoundSummary called on server.");
		}
		else
		{
			((RoundSummary)obj).UserCode_RpcHideRoundSummary();
		}
	}

	protected void UserCode_RpcDimScreen()
	{
	}

	protected static void InvokeUserCode_RpcDimScreen(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcDimScreen called on server.");
		}
		else
		{
			((RoundSummary)obj).UserCode_RpcDimScreen();
		}
	}

	protected void UserCode_RpcUndimScreen()
	{
	}

	protected static void InvokeUserCode_RpcUndimScreen(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
	{
		if (!NetworkClient.active)
		{
			Debug.LogError("RPC RpcUndimScreen called on server.");
		}
		else
		{
			((RoundSummary)obj).UserCode_RpcUndimScreen();
		}
	}

	static RoundSummary()
	{
		RemoteProcedureCalls.RegisterRpc(typeof(RoundSummary), "System.Void RoundSummary::RpcShowRoundSummary(RoundSummary/SumInfo_ClassList,RoundSummary/SumInfo_ClassList,RoundSummary/LeadingTeam,System.Int32,System.Int32,System.Int32,System.Int32,System.Int32)", InvokeUserCode_RpcShowRoundSummary__SumInfo_ClassList__SumInfo_ClassList__LeadingTeam__Int32__Int32__Int32__Int32__Int32);
		RemoteProcedureCalls.RegisterRpc(typeof(RoundSummary), "System.Void RoundSummary::RpcHideRoundSummary()", InvokeUserCode_RpcHideRoundSummary);
		RemoteProcedureCalls.RegisterRpc(typeof(RoundSummary), "System.Void RoundSummary::RpcDimScreen()", InvokeUserCode_RpcDimScreen);
		RemoteProcedureCalls.RegisterRpc(typeof(RoundSummary), "System.Void RoundSummary::RpcUndimScreen()", InvokeUserCode_RpcUndimScreen);
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			writer.WriteInt(_extraTargets);
			writer.WriteInt(_targetCount);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			writer.WriteInt(_extraTargets);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteInt(_targetCount);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref _extraTargets, null, reader.ReadInt());
			GeneratedSyncVarDeserialize(ref _targetCount, null, reader.ReadInt());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _extraTargets, null, reader.ReadInt());
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref _targetCount, null, reader.ReadInt());
		}
	}
}
