using System;
using System.Collections.Generic;
using AudioPooling;
using CustomPlayerEffects;
using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509Item : MeleeAutoSync, IItemDescription, IItemNametag, IItemAlertDrawer, IItemDrawer, IHumeShieldProvider, IItemNickname
	{
		private class HumeShieldSession
		{
			public readonly HumeShieldStat Stat;

			public readonly ReferenceHub Hub;

			private double _lastDamage;

			private double _lastUnequip;

			private Scp1509Item _lastItem;

			public float LastUnequipElapsed
			{
				get
				{
					return (float)(_lastUnequip - NetworkTime.time);
				}
				set
				{
					_lastUnequip = NetworkTime.time + (double)value;
				}
			}

			public float LastDamageElapsed => (float)(NetworkTime.time - _lastDamage);

			public Scp1509Item EquippedItem
			{
				get
				{
					if (_lastItem != null)
					{
						if (!_lastItem.IsEquipped)
						{
							return null;
						}
						return _lastItem;
					}
					if (!(Hub.inventory.CurInstance is Scp1509Item lastItem))
					{
						return null;
					}
					_lastItem = lastItem;
					return _lastItem;
				}
			}

			public void RegisterDamage()
			{
				_lastDamage = NetworkTime.time;
			}

			public HumeShieldSession(Scp1509Item hs)
			{
				Hub = hs.Owner;
				Stat = Hub.playerStats.GetModule<HumeShieldStat>();
				_lastItem = hs;
			}
		}

		public static Dictionary<ushort, bool> ResurrectStatuses = new Dictionary<ushort, bool>();

		public const float RevivedPlayerMaxHP = 75f;

		public const float RevivedPlayerMaxAHP = 25f;

		private const ActionName TriggerMelee = ActionName.Shoot;

		private const ActionName InspectKey = ActionName.InspectItem;

		private static readonly CachedLayerMask ValidGroundLinecast = new CachedLayerMask("Default");

		private static readonly List<HumeShieldSession> ServerActiveSessions = new List<HumeShieldSession>();

		public readonly List<ReferenceHub> RevivedPlayers = new List<ReferenceHub>();

		private bool _attackTriggered;

		private bool _lastCanResurrect;

		private readonly TolerantAbilityCooldown _serverAttackCooldown = new TolerantAbilityCooldown();

		private readonly AbilityCooldown _clientAttackCooldown = new AbilityCooldown();

		private readonly AbilityCooldown _clientDelayCooldown = new AbilityCooldown();

		private readonly ItemHintAlertHelper _hintHelper = new ItemHintAlertHelper(InventoryGuiTranslation.JailbirdAttackHint, ActionName.Shoot);

		[SerializeField]
		private AudioClip[] _hitPlayerClips;

		[SerializeField]
		private float _meleeDelay;

		[SerializeField]
		private float _meleeCooldown;

		[SerializeField]
		private GameObject _resurrectParticlesPrefab;

		public override float Weight => 1.7f;

		public override bool AllowHolster => true;

		public string Description => ItemTypeId.GetDescription();

		public string Name => ItemTypeId.GetName();

		public string Nickname => ItemTypeId.GetNickname();

		public AlertContent Alert => _hintHelper.Alert;

		public bool ForceBarVisible => false;

		public float HsMax
		{
			get
			{
				AhpStat module = base.Owner.playerStats.GetModule<AhpStat>();
				return Mathf.Max(0f, EquippedHS - module.CurValue);
			}
		}

		public float HsRegeneration { get; private set; }

		public Color? HsWarningColor => null;

		[field: SerializeField]
		public float ShieldRegenRate { get; set; }

		[field: SerializeField]
		public float ShieldDecayRate { get; set; }

		[field: SerializeField]
		public float ShieldOnDamagePause { get; set; }

		[field: SerializeField]
		public float UnequipDecayDelay { get; set; }

		[field: SerializeField]
		public double NextResurrectTime { get; set; }

		[field: SerializeField]
		public double ReviveCooldown { get; set; }

		[field: SerializeField]
		public float EquippedHS { get; set; }

		[field: SerializeField]
		public float RevivedPlayerBlurTime { get; set; }

		[field: SerializeField]
		public float RevivedPlayerAOEBonusAHP { get; set; }

		[field: SerializeField]
		public float RevivedPlayerAOEBonusAHPDistance { get; set; }

		public bool CanResurrect
		{
			get
			{
				if (NextResurrectTime < NetworkTime.time)
				{
					return Scp1509RespawnEligibility.IsAnyEligibleSpectators();
				}
				return false;
			}
		}

		public Scp1509RespawnCriteriaManager RespawnCriteriaManager { get; } = new Scp1509RespawnCriteriaManager();

		public override byte AttackPreformedByte => 6;

		public static event Action<ushort, Scp1509MessageType> OnRpcReceived;

		public event Action<Scp1509MessageType> OnCmdSent;

		public override bool ApplyDamage(ReferenceHub attacker, IDestructible victim, float damage, Vector3 direction, bool isPrimaryTarget)
		{
			float damage2 = (isPrimaryTarget ? damage : (damage / 2f));
			Scp1509DamageHandler handler = new Scp1509DamageHandler(attacker, damage2, direction);
			return victim.Damage(damage2, handler, direction);
		}

		public void ServerProcessKill(ReferenceHub victim)
		{
			SendRpc(Scp1509MessageType.KilledPlayer);
			if (NextResurrectTime > NetworkTime.time)
			{
				return;
			}
			Team team = victim.GetTeam();
			RoleTypeId roleId = victim.GetRoleId();
			Scp1509RespawnEligibility.OnServer1509Kill(victim);
			RoleTypeId roleTypeId = RespawnCriteriaManager.ServerGetRespawnRole(base.Owner, victim);
			ReferenceHub player = Scp1509RespawnEligibility.GetEligibleSpectator(roleTypeId);
			if (team == Team.Flamingos || roleId == RoleTypeId.ZombieFlamingo)
			{
				roleTypeId = GetScp1507RespawnRole(base.Owner);
			}
			PlayerScp1509ResurrectingEventArgs e = new PlayerScp1509ResurrectingEventArgs(base.Owner, this, victim, player, roleTypeId);
			PlayerEvents.OnScp1509Resurrecting(e);
			if (!e.IsAllowed)
			{
				return;
			}
			roleTypeId = e.RespawnRole;
			player = e.RevivedPlayer?.ReferenceHub;
			if (roleTypeId != RoleTypeId.None && !(player == null))
			{
				NextResurrectTime = NetworkTime.time + ReviveCooldown;
				ServerApplyResurrectEffects(victim, player, roleTypeId);
				SendRpc(Scp1509MessageType.SpawnResurrectParticles, (NetworkWriter writer) =>
				{
					writer.WriteVector3(player.GetPosition());
				});
				PlayerEvents.OnScp1509Resurrected(new PlayerScp1509ResurrectedEventArgs(base.Owner, this, victim, player, roleTypeId));
			}
		}

		private void ServerApplyResurrectEffects(ReferenceHub victim, ReferenceHub resurrectedPlayer, RoleTypeId respawnRole)
		{
			PocketCorroding effect = victim.playerEffectsController.GetEffect<PocketCorroding>();
			bool isEnabled = effect.IsEnabled;
			RelativePosition capturePosition = effect.CapturePosition;
			resurrectedPlayer.roleManager.ServerSetRole(respawnRole, RoleChangeReason.Resurrected, RoleSpawnFlags.None);
			Vector3 position = victim.GetPosition();
			if (!Physics.Raycast(victim.GetPosition(), Vector3.down, 1f, ValidGroundLinecast))
			{
				position = base.Owner.GetPosition();
			}
			resurrectedPlayer.TryOverridePosition(position);
			resurrectedPlayer.playerEffectsController.EnableEffect<Blurred>(RevivedPlayerBlurTime);
			if (victim.GetTeam() != Team.Flamingos && victim.GetRoleId() != RoleTypeId.ZombieFlamingo)
			{
				resurrectedPlayer.playerEffectsController.EnableEffect<Scp1509Resurrected>();
			}
			if (isEnabled)
			{
				resurrectedPlayer.playerEffectsController.EnableEffect<PocketCorroding>().ServerOverrideCapturePosition(capturePosition);
			}
			base.Owner.playerStats.GetModule<HumeShieldStat>().CurValue = HsMax;
			foreach (ReferenceHub revivedPlayer in RevivedPlayers)
			{
				if (!(revivedPlayer == null) && !(Vector3.Distance(revivedPlayer.GetPosition(), base.Owner.GetPosition()) > RevivedPlayerAOEBonusAHPDistance))
				{
					revivedPlayer.playerStats.GetModule<AhpStat>().ServerAddProcess(RevivedPlayerAOEBonusAHP, RevivedPlayerAOEBonusAHP, 0f, 0.7f, 0f, persistant: false);
				}
			}
			RevivedPlayers.Add(resurrectedPlayer);
		}

		private RoleTypeId GetScp1507RespawnRole(ReferenceHub killer)
		{
			switch (killer.GetTeam())
			{
			case Team.FoundationForces:
			case Team.Scientists:
				return RoleTypeId.NtfFlamingo;
			case Team.ChaosInsurgency:
			case Team.ClassD:
				return RoleTypeId.ChaosFlamingo;
			default:
				return RoleTypeId.None;
			}
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			if (NetworkServer.active && pickup is Scp1509Pickup scp1509Pickup)
			{
				NextResurrectTime = scp1509Pickup.NextReviveTime;
				if (scp1509Pickup.ResurrectDirty && ResurrectStatuses.TryGetValue(base.ItemId.SerialNumber, out var value))
				{
					SendRpc(value ? Scp1509MessageType.CanResurrect : Scp1509MessageType.CanNotResurrect);
				}
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (NetworkServer.active && pickup is Scp1509Pickup scp1509Pickup)
			{
				scp1509Pickup.Setup(NextResurrectTime);
			}
		}

		public override void OnEquipped()
		{
			if (NetworkServer.active && base.Owner.IsHuman() && !ServerActiveSessions.Any((HumeShieldSession x) => x.Hub == base.Owner))
			{
				ServerActiveSessions.Add(new HumeShieldSession(this));
			}
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			_hintHelper.Hide();
			_attackTriggered = false;
			if (!NetworkServer.active)
			{
				return;
			}
			SendRpc(Scp1509MessageType.Holstered);
			HsRegeneration = 0f;
			foreach (HumeShieldSession serverActiveSession in ServerActiveSessions)
			{
				if (!(serverActiveSession.Hub != base.Owner))
				{
					serverActiveSession.LastUnequipElapsed = UnequipDecayDelay;
				}
			}
		}

		public override void AlwaysUpdate()
		{
			if (NetworkServer.active)
			{
				bool canResurrect = CanResurrect;
				if (canResurrect != _lastCanResurrect)
				{
					_lastCanResurrect = canResurrect;
					ResurrectStatuses[base.ItemSerial] = canResurrect;
					SendRpc(canResurrect ? Scp1509MessageType.CanResurrect : Scp1509MessageType.CanNotResurrect);
				}
			}
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			_hintHelper.Update(base.Owner);
			if (!base.IsControllable)
			{
				return;
			}
			if (_attackTriggered)
			{
				if (_clientDelayCooldown.IsReady)
				{
					ClientAttack();
					_attackTriggered = false;
				}
				return;
			}
			bool flag = !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction);
			bool flag2 = !base.Owner.HasBlock(BlockedInteraction.ItemUsage);
			if (_clientAttackCooldown.IsReady)
			{
				if (GetActionDown(ActionName.InspectItem) & flag2)
				{
					SendCmd(Scp1509MessageType.Inspect);
				}
				if (GetAction(ActionName.Shoot) && flag)
				{
					_attackTriggered = true;
					SendCmd(Scp1509MessageType.AttackTriggered);
					_clientDelayCooldown.Trigger(_meleeDelay);
					_clientAttackCooldown.Trigger(_meleeCooldown);
				}
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			Scp1509MessageType scp1509MessageType = (Scp1509MessageType)reader.ReadByte();
			OnRpcReceived?.Invoke(serial, scp1509MessageType);
			switch (scp1509MessageType)
			{
			case Scp1509MessageType.SpawnResurrectParticles:
			{
				Vector3 position = reader.ReadVector3();
				UnityEngine.Object.Instantiate(_resurrectParticlesPrefab, position, default);
				break;
			}
			case Scp1509MessageType.AttackPerformed:
			{
				if (!base.Owner.isLocalPlayer && !base.Owner.IsLocallySpectated() && reader.ReadBool() && InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
				{
					AudioSourcePoolManager.PlayOnTransform(_hitPlayerClips[UnityEngine.Random.Range(0, _hitPlayerClips.Length)], hub.transform, 15f);
				}
				break;
			}
			case Scp1509MessageType.NewPlayerFullResync:
				ResurrectStatuses.Clear();
				while (reader.Remaining > 0)
				{
					ushort key = reader.ReadUShort();
					bool value = reader.ReadBool();
					ResurrectStatuses[key] = value;
				}
				break;
			case Scp1509MessageType.CanResurrect:
				ResurrectStatuses[serial] = true;
				break;
			case Scp1509MessageType.CanNotResurrect:
				ResurrectStatuses[serial] = false;
				break;
			case Scp1509MessageType.Inspect:
			case Scp1509MessageType.KilledPlayer:
				break;
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (!base.IsEquipped)
			{
				return;
			}
			Scp1509MessageType msg = (Scp1509MessageType)reader.ReadByte();
			bool allowAttack = !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction);
			bool allowInspect = !base.Owner.HasBlock(BlockedInteraction.ItemUsage);
			PlayerProcessingScp1509MessageEventArgs e = new PlayerProcessingScp1509MessageEventArgs(base.Owner, this, msg, allowAttack, allowInspect);
			PlayerEvents.OnProcessingScp1509Message(e);
			if (!e.IsAllowed)
			{
				return;
			}
			msg = e.Message;
			allowAttack = e.AllowAttack;
			allowInspect = e.AllowInspect;
			switch (msg)
			{
			case Scp1509MessageType.AttackTriggered:
				if (!allowAttack || (!base.IsControllable && _attackTriggered) || !_serverAttackCooldown.TolerantIsReady)
				{
					return;
				}
				_attackTriggered = true;
				_serverAttackCooldown.Trigger(_meleeCooldown);
				SendRpc(Scp1509MessageType.AttackTriggered);
				break;
			case Scp1509MessageType.AttackPerformed:
				if (!_attackTriggered)
				{
					return;
				}
				if (!allowAttack)
				{
					Hitmarker.SendHitmarkerDirectly(base.Owner, 1f, playAudio: true, HitmarkerType.Blocked);
					return;
				}
				_attackTriggered = false;
				Scp1509ServerAttack(reader);
				break;
			case Scp1509MessageType.Inspect:
				if (allowInspect)
				{
					PlayerInspectingItemEventArgs e2 = new PlayerInspectingItemEventArgs(base.Owner, this);
					PlayerEvents.OnInspectingItem(e2);
					if (!e2.IsAllowed)
					{
						return;
					}
					SendRpc(msg);
					PlayerEvents.OnInspectedItem(new PlayerInspectedItemEventArgs(base.Owner, this));
				}
				break;
			}
			PlayerEvents.OnProcessedScp1509Message(new PlayerProcessedScp1509MessageEventArgs(base.Owner, this, msg));
		}

		private void Scp1509ServerAttack(NetworkReader reader)
		{
			HitResult result = ServerAttack(reader);
			if (result == HitResult.HitPlayer)
			{
				Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
			}
			Scp1509MessageType header = Scp1509MessageType.AttackPreformedHitMissed;
			switch (result)
			{
			case HitResult.HitPlayer:
				header = Scp1509MessageType.AttackPreformedHitFlesh;
				break;
			case HitResult.HitWall:
				header = Scp1509MessageType.AttackPreformedHitWall;
				break;
			}
			SendRpc(header, (NetworkWriter wr) =>
			{
				wr.WriteBool(result == HitResult.HitPlayer);
			});
		}

		private void ClientAttack()
		{
			if (ClientTryAttack())
			{
				OnCmdSent?.Invoke(Scp1509MessageType.AttackPerformed);
			}
		}

		private void SendRpc(Scp1509MessageType header, Action<NetworkWriter> extraData = null)
		{
			NetworkWriter writer;
			using (new AutosyncRpc(base.ItemId, out writer))
			{
				writer.WriteByte((byte)header);
				extraData?.Invoke(writer);
			}
		}

		private void SendCmd(Scp1509MessageType msg)
		{
			NetworkWriter writer;
			using (new AutosyncCmd(base.ItemId, out writer))
			{
				writer.WriteByte((byte)msg);
			}
			OnCmdSent?.Invoke(msg);
		}

		private void OnClientReady()
		{
			ServerActiveSessions.Clear();
			RevivedPlayers.Clear();
			ResurrectStatuses.Clear();
		}

		private void ServerUpdateSessions()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			for (int num = ServerActiveSessions.Count - 1; num >= 0; num--)
			{
				HumeShieldSession humeShieldSession = ServerActiveSessions[num];
				Scp1509Item equippedItem = humeShieldSession.EquippedItem;
				HumeShieldStat stat = humeShieldSession.Stat;
				if (equippedItem != null)
				{
					if (stat.CurValue <= equippedItem.HsMax)
					{
						bool flag = humeShieldSession.LastDamageElapsed > ShieldOnDamagePause;
						equippedItem.HsRegeneration = (flag ? ShieldRegenRate : 0f);
					}
					else
					{
						equippedItem.HsRegeneration = 0f;
						stat.CurValue = equippedItem.HsMax;
					}
				}
				else if (!(humeShieldSession.LastUnequipElapsed > 0f))
				{
					stat.CurValue -= Time.deltaTime * ShieldDecayRate;
					if (!(stat.CurValue > 0f))
					{
						ServerActiveSessions.RemoveAt(num);
					}
				}
			}
		}

		internal override void OnTemplateReloaded(bool wasEverLoaded)
		{
			base.OnTemplateReloaded(wasEverLoaded);
			if (!wasEverLoaded)
			{
				CustomNetworkManager.OnClientReady += OnClientReady;
				ReferenceHub.OnPlayerRemoved += RemoveSession;
				PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
				PlayerStats.OnAnyPlayerDamaged += OnAnyPlayerDamaged;
				ReferenceHub.OnPlayerAdded += OnPlayerAdded;
				StaticUnityMethods.OnUpdate += ServerUpdateSessions;
			}
		}

		private void OnPlayerAdded(ReferenceHub hub)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			ServerSendTargetRpc(hub, (NetworkWriter writer) =>
			{
				writer.WriteSubheader(Scp1509MessageType.NewPlayerFullResync);
				foreach (KeyValuePair<ushort, bool> resurrectStatus in ResurrectStatuses)
				{
					writer.WriteUShort(resurrectStatus.Key);
					writer.WriteBool(resurrectStatus.Value);
				}
			});
		}

		private void OnServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
		{
			if (NetworkServer.active)
			{
				RemoveSession(userHub);
				RevivedPlayers.RemoveAll((ReferenceHub x) => x == userHub);
			}
		}

		private void OnAnyPlayerDamaged(ReferenceHub hub, DamageHandlerBase handler)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			foreach (HumeShieldSession serverActiveSession in ServerActiveSessions)
			{
				if (!(serverActiveSession.Hub != hub))
				{
					serverActiveSession.RegisterDamage();
				}
			}
		}

		private void RemoveSession(ReferenceHub hub)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			for (int num = ServerActiveSessions.Count - 1; num >= 0; num--)
			{
				if (!(ServerActiveSessions[num].Hub != hub))
				{
					ServerActiveSessions.RemoveAt(num);
				}
			}
		}
	}
}
