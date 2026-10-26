using System;
using System.Collections.Generic;
using CentralAuth;
using InventorySystem;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.Scp079;
using PlayerRoles.Subroutines;
using PlayerRoles.Visibility;
using PlayerRoles.Voice;
using UnityEngine;
using VoiceChat;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public static class FpcServerPositionDistributor
	{
		public const float HumanVisibilityDistance = 50f;

		public const float SCPVisibilityDistance = 110f;

		private const int MinTickrate = 10;

		private const int MaxTickrate = 60;

		private const int ArrayStartSize = 30;

		private const int ArrayAddAmount = 10;

		private const int ArrayAddThreshold = 5;

		private const int OverwatchSpoofActivationPlayersRequirement = 6;

		private static readonly Dictionary<uint, Dictionary<uint, FpcSyncData>> PreviouslySent = new Dictionary<uint, Dictionary<uint, FpcSyncData>>();

		private static Func<ReferenceHub, ReferenceHub, RoleTypeId, NetworkWriter, RoleTypeId> _roleSyncEvent;

		private static int[] _bufferPlayerIDs = new int[30];

		private static FpcSyncData[] _bufferSyncData = new FpcSyncData[30];

		private static float _sendCooldown;

		private static float SendRate => 1f / (float)Mathf.Clamp(ServerStatic.ServerTickrate, 10, 60);

		public static event Func<ReferenceHub, ReferenceHub, RoleTypeId, NetworkWriter, RoleTypeId> RoleSyncEvent
		{
			add
			{
				_roleSyncEvent = (Func<ReferenceHub, ReferenceHub, RoleTypeId, NetworkWriter, RoleTypeId>)Delegate.Combine(_roleSyncEvent, value);
			}
			remove
			{
				_roleSyncEvent = (Func<ReferenceHub, ReferenceHub, RoleTypeId, NetworkWriter, RoleTypeId>)Delegate.Remove(_roleSyncEvent, value);
			}
		}

		public static RoleTypeId GetVisibleRole(ReferenceHub receiver, ReferenceHub target)
		{
			RoleTypeId result = target.GetRoleId();
			if (target.isLocalPlayer || receiver.isLocalPlayer)
			{
				return result;
			}
			if (target.roleManager.CurrentRole is IObfuscatedRole obfuscatedRole)
			{
				result = obfuscatedRole.GetRoleForUser(receiver);
			}
			if (receiver == target)
			{
				return result;
			}
			bool flag = false;
			if (receiver.roleManager.CurrentRole is ICustomVisibilityRole customVisibilityRole)
			{
				flag = !customVisibilityRole.VisibilityController.ValidateVisibility(target);
			}
			float num = Vector3.Distance(receiver.transform.position, target.transform.position);
			if (receiver.roleManager.CurrentRole is Scp079Role scp079Role)
			{
				num = Vector3.Distance(scp079Role.CameraPosition, target.transform.position);
			}
			bool flag2 = PermissionsHandler.IsPermitted(receiver.serverRoles.Permissions, PlayerPermissions.GameplayData);
			bool flag3 = ((receiver.GetTeam() == Team.SCPs) ? (num <= 110f) : (num <= 50f));
			bool flag4 = receiver.GetRoleId() == RoleTypeId.Spectator;
			if (target.GetTeam() == Team.SCPs)
			{
				return result;
			}
			if (target.IsCommunicatingGlobally())
			{
				return result;
			}
			if (flag && !flag3 && !flag2 && !flag4)
			{
				result = RoleTypeId.Spectator;
			}
			return result;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnLateUpdate += LateUpdate;
			PlayerRoleManager.OnRoleChanged += ResetPlayer;
			Inventory.OnServerStarted += PreviouslySent.Clear;
			ReferenceHub.OnPlayerAdded += (ReferenceHub rh) =>
			{
				EnsureArrayCapacity();
			};
		}

		private static void ResetPlayer(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!(prevRole is IFpcRole))
			{
				return;
			}
			uint netId = userHub.netId;
			foreach (KeyValuePair<uint, Dictionary<uint, FpcSyncData>> item in PreviouslySent)
			{
				item.Value.Remove(netId);
			}
		}

		private static void LateUpdate()
		{
			if (!NetworkServer.active || !StaticUnityMethods.IsPlaying)
			{
				return;
			}
			_sendCooldown += Time.deltaTime;
			if (_sendCooldown < SendRate)
			{
				return;
			}
			_sendCooldown -= SendRate;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.Mode != ClientInstanceMode.Unverified && !allHub.isLocalPlayer)
				{
					allHub.connectionToClient.Send(new FpcPositionMessage(allHub));
				}
			}
		}

		private static void EnsureArrayCapacity()
		{
			int num = Mathf.Min(_bufferPlayerIDs.Length, _bufferSyncData.Length);
			int count = ReferenceHub.AllHubs.Count;
			if (count > num - 5)
			{
				_bufferPlayerIDs = new int[count + 10];
				_bufferSyncData = new FpcSyncData[count + 10];
			}
		}

		public static void WriteAll(ReferenceHub receiver, NetworkWriter writer)
		{
			ushort num = 0;
			bool flag;
			VisibilityController visibilityController;
			if (receiver.roleManager.CurrentRole is ICustomVisibilityRole customVisibilityRole)
			{
				flag = true;
				visibilityController = customVisibilityRole.VisibilityController;
			}
			else
			{
				flag = false;
				visibilityController = null;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!allHub.isLocalPlayer && allHub.netId != receiver.netId && allHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					bool flag2 = flag && !visibilityController.ValidateVisibility(allHub);
					PlayerValidatedVisibilityEventArgs e = new PlayerValidatedVisibilityEventArgs(receiver, allHub, !flag2);
					PlayerEvents.OnValidatedVisibility(e);
					flag2 = !e.IsVisible;
					FpcSyncData newSyncData = GetNewSyncData(receiver, allHub, fpcRole.FpcModule, flag2);
					if (!flag2)
					{
						_bufferPlayerIDs[num] = allHub.PlayerId;
						_bufferSyncData[num] = newSyncData;
						num++;
					}
					RoleTypeId roleTypeId = GetVisibleRole(receiver, allHub);
					NetworkWriterPooled networkWriterPooled = NetworkWriterPool.Get();
					RoleTypeId? roleTypeId2 = _roleSyncEvent?.Invoke(allHub, receiver, roleTypeId, networkWriterPooled);
					if (roleTypeId2.HasValue)
					{
						roleTypeId = roleTypeId2.Value;
					}
					if (!allHub.roleManager.PreviouslySentRole.TryGetValue(receiver.netId, out var value) || value != roleTypeId)
					{
						SendRole(receiver, allHub, roleTypeId, networkWriterPooled);
					}
					NetworkWriterPool.Return(networkWriterPooled);
				}
			}
			writer.WriteUShort(num);
			for (int i = 0; i < num; i++)
			{
				writer.WriteRecyclablePlayerId(new RecyclablePlayerId(_bufferPlayerIDs[i]));
				_bufferSyncData[i].Write(writer);
			}
		}

		private static FpcSyncData GetNewSyncData(ReferenceHub receiver, ReferenceHub target, FirstPersonMovementModule fpmm, bool isInvisible)
		{
			FpcSyncData prevSyncData = GetPrevSyncData(receiver, target);
			FpcSyncData fpcSyncData = (isInvisible ? default(FpcSyncData) : new FpcSyncData(prevSyncData, fpmm.SyncMovementState, fpmm.IsGrounded, fpmm.RelativePosition, fpmm.MouseLook));
			PreviouslySent[receiver.netId][target.netId] = fpcSyncData;
			return fpcSyncData;
		}

		private static FpcSyncData GetPrevSyncData(ReferenceHub receiver, ReferenceHub target)
		{
			if (!PreviouslySent.TryGetValue(receiver.netId, out var value))
			{
				PreviouslySent.Add(receiver.netId, new Dictionary<uint, FpcSyncData>());
				return default;
			}
			if (!value.TryGetValue(target.netId, out var value2))
			{
				return default;
			}
			return value2;
		}

		private static bool IsCommunicatingGlobally(this ReferenceHub target)
		{
			if (!(target.roleManager.CurrentRole is IVoiceRole voiceRole))
			{
				return false;
			}
			if (!voiceRole.VoiceModule.ServerIsSending)
			{
				return false;
			}
			if (Intercom.CheckPerms(target))
			{
				return true;
			}
			return voiceRole.VoiceModule.CurrentChannel == VoiceChatChannel.Radio;
		}

		public static void SendRole(ReferenceHub receiver, ReferenceHub hub, RoleTypeId targetRole, NetworkWriter spoofedData)
		{
			if (receiver == hub)
			{
				targetRole = hub.roleManager.CurrentRole.RoleTypeId;
			}
			bool flag = IsDistributionActive(targetRole);
			receiver.connectionToClient.Send(new RoleSyncInfo(hub, flag ? RoleTypeId.Overwatch : targetRole, receiver, spoofedData));
			hub.roleManager.PreviouslySentRole[receiver.netId] = targetRole;
			if (targetRole == hub.roleManager.CurrentRole.RoleTypeId && hub.roleManager.CurrentRole is ISubroutinedRole subroutinedRole)
			{
				SubroutineBase[] allSubroutines = subroutinedRole.SubroutineModule.AllSubroutines;
				foreach (SubroutineBase subroutine in allSubroutines)
				{
					receiver.connectionToClient.Send(new SubroutineMessage(subroutine, isConfirmation: true));
				}
			}
		}

		public static RoleTypeId? InvokeRoleSyncEvent(ReferenceHub hub, ReferenceHub receiver, RoleTypeId supposedRole, NetworkWriter spoofedData)
		{
			return _roleSyncEvent?.Invoke(hub, receiver, supposedRole, spoofedData);
		}

		private static bool IsDistributionActive(RoleTypeId targetRole)
		{
			if (targetRole != RoleTypeId.Spectator)
			{
				return false;
			}
			if (ReferenceHub.AllHubs.Count < 6)
			{
				return false;
			}
			return UnityEngine.Random.Range(0, 500) >= 250;
		}
	}
}
