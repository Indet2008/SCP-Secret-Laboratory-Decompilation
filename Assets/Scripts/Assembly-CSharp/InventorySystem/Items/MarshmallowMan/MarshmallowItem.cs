using System;
using System.Collections.Generic;
using AudioPooling;
using CustomPlayerEffects;
using Footprinting;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Pickups;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Subroutines;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.MarshmallowMan
{
	public class MarshmallowItem : AutosyncItem, IInteractionBlocker, IItemAlertDrawer, IItemDrawer, IDoorPermissionProvider, IHolidayItem
	{
		private enum RpcType
		{
			AttackStart = 0,
			Hit = 1,
			Holster = 2,
			Evil = 3,
			Cackle = 4
		}

		public const float HolsterAnimTime = 1.1f;

		public const float EvilAHPOnKill = 100f;

		public static readonly HashSet<ushort> EvilInstances = new HashSet<ushort>();

		[SerializeField]
		private float _detectionRadius;

		[SerializeField]
		private float _detectionOffset;

		[SerializeField]
		private float _attackCooldown;

		[SerializeField]
		private float _attackDamage;

		[SerializeField]
		private AudioClip[] _cackleClips;

		private bool _markedAsRemoved;

		private bool _preventAttacks;

		private readonly TolerantAbilityCooldown _cooldown = new TolerantAbilityCooldown();

		private readonly HashSet<ReferenceHub> _detectedPlayers = new HashSet<ReferenceHub>();

		private readonly AbilityCooldown _cackleCooldown = new AbilityCooldown();

		public bool EvilMode { get; private set; }

		public AhpProcess EvilAHPProcess { get; private set; }

		public override float Weight => 0f;

		public override bool AllowHolster => false;

		public override bool AllowEquip => true;

		public BlockedInteraction BlockedInteractions => BlockedInteraction.OpenInventory | BlockedInteraction.BeDisarmed | BlockedInteraction.GrabItems;

		public bool CanBeCleared => false;

		public HolidayType[] TargetHolidays => MarshmallowEffect.ActiveHolidays;

		public AlertContent Alert
		{
			get
			{
				if (!EvilMode || !_cackleCooldown.IsReady || !IsLocalPlayer)
				{
					return default;
				}
				return new AlertContent(string.Format(arg0: $"<color=red>{new ReadableKeyCode(ActionName.ToggleFlashlight)}</color>", format: Translations.Get(InventoryGuiTranslation.MarshmallowCackleHint)));
			}
		}

		public PermissionUsed PermissionsUsedCallback => (IDoorPermissionRequester _, bool _) =>
		{
		};

		private MarshmallowDamageHandler NewDamageHandler => new MarshmallowDamageHandler(new Footprint(base.Owner), _attackDamage);

		public static event Action<ushort> OnSwing;

		public static event Action<ushort> OnHit;

		public static event Action<ushort> OnHolsterRequested;

		public DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			if (!EvilMode)
			{
				return DoorPermissionFlags.None;
			}
			return DoorPermissionFlags.ScpOverride;
		}

		public void ServerRequestHolster()
		{
			ServerSendPublicRpc((NetworkWriter writer) =>
			{
				writer.WriteByte(2);
			});
		}

		public override ItemPickupBase ServerDropItem(bool spawn)
		{
			base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
			return null;
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			if (NetworkServer.active)
			{
				base.OwnerInventory.ServerSelectItem(base.ItemSerial);
			}
			base.Owner.interCoordinator.AddBlocker(this);
		}

		public override void AlwaysUpdate()
		{
			base.AlwaysUpdate();
			if (NetworkServer.active)
			{
				if (EvilMode)
				{
					base.Owner.playerStats.GetModule<HealthStat>().ServerHeal(Time.deltaTime * 3f);
				}
				base.OwnerInventory.ServerSelectItem(base.ItemSerial);
			}
		}

		public override void ServerConfirmAcqusition()
		{
			base.ServerConfirmAcqusition();
			if (EvilMode)
			{
				ServerSendPublicRpc((NetworkWriter writer) =>
				{
					writer.WriteByte(3);
				});
			}
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			if (!_markedAsRemoved)
			{
				_markedAsRemoved = true;
				if (NetworkServer.active)
				{
					base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
				}
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			_markedAsRemoved = true;
		}

		public void ReleaseEvil(AhpProcess evilProcess)
		{
			EvilMode = true;
			EvilAHPProcess = evilProcess;
			ServerSendPublicRpc((NetworkWriter writer) =>
			{
				writer.WriteByte(3);
			});
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.Hit:
				OnHit?.Invoke(serial);
				break;
			case RpcType.AttackStart:
				OnSwing?.Invoke(serial);
				break;
			case RpcType.Holster:
				OnHolsterRequested?.Invoke(serial);
				break;
			case RpcType.Evil:
				EvilInstances.Add(serial);
				break;
			case RpcType.Cackle:
			{
				if (InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
				{
					AudioSourcePoolManager.PlayOnTransform(_cackleClips.RandomItem(), hub.transform, 15f, 1f, FalloffType.Exponential, MixerChannel.NoDucking);
				}
				break;
			}
			}
		}

		internal override void OnTemplateReloaded(bool wasEverLoaded)
		{
			base.OnTemplateReloaded(wasEverLoaded);
			if (!wasEverLoaded)
			{
				CustomNetworkManager.OnClientReady += EvilInstances.Clear;
			}
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.Holster:
				_preventAttacks = true;
				break;
			case RpcType.Evil:
				EvilMode = true;
				break;
			case RpcType.Cackle:
				_cackleCooldown.ReadCooldown(reader);
				break;
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (reader.Remaining == 0)
			{
				ServerProcessCackle();
				return;
			}
			if (!IsLocalPlayer)
			{
				if (!_cooldown.TolerantIsReady)
				{
					return;
				}
				_cooldown.Trigger(_attackCooldown);
			}
			RelativePosition relativePosition = reader.ReadRelativePosition();
			Quaternion claimedRot = reader.ReadQuaternion();
			FpcBacktracker fpcBacktracker;
			if (reader.Remaining > 0 && reader.TryReadReferenceHub(out var hub))
			{
				RelativePosition relativePosition2 = reader.ReadRelativePosition();
				fpcBacktracker = new FpcBacktracker(hub, relativePosition2.Position);
			}
			else
			{
				hub = null;
				fpcBacktracker = null;
			}
			using (new FpcBacktracker(base.Owner, relativePosition.Position, claimedRot))
			{
				ServerAttack(hub);
			}
			fpcBacktracker?.RestorePosition();
			ServerSendConditionalRpc((ReferenceHub referenceHub) => referenceHub != base.Owner, (NetworkWriter writer) =>
			{
				writer.WriteByte(0);
			});
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (IsLocalPlayer)
			{
				UpdateClientInput();
			}
		}

		private void ServerProcessCackle()
		{
			if (!EvilMode || !_cackleCooldown.IsReady)
			{
				return;
			}
			_cackleCooldown.Trigger(7.0);
			ServerSendPublicRpc((NetworkWriter writer) =>
			{
				writer.WriteByte(4);
				_cackleCooldown.WriteCooldown(writer);
			});
			if (!(base.Owner.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is IFpcRole fpcRole2 && !(Vector3.Distance(fpcRole2.FpcModule.Position, fpcRole.FpcModule.Position) > 5f) && (!(allHub.inventory.CurInstance is MarshmallowItem marshmallowItem) || !(marshmallowItem != null) || !marshmallowItem.EvilMode))
				{
					allHub.playerEffectsController.EnableEffect<TraumatizedByEvil>(5f);
				}
			}
		}

		private void UpdateClientInput()
		{
			if (!_cooldown.IsReady || _preventAttacks || !InventoryGuiController.ItemsSafeForInteraction)
			{
				return;
			}
			KeyCode key = NewInput.GetKey(ActionName.Shoot);
			KeyCode key2 = NewInput.GetKey(ActionName.ToggleFlashlight);
			if (Input.GetKeyDown(key2))
			{
				ClientSendCmd();
			}
			if (Input.GetKeyDown(key))
			{
				MarshmallowItem.OnSwing?.Invoke(base.ItemSerial);
				_cooldown.Trigger(_attackCooldown);
				ClientSendCmd(ClientWriteAttackResult);
			}
		}

		private void ClientWriteAttackResult(NetworkWriter writer)
		{
			if (!(base.Owner.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			writer.WriteRelativePosition(new RelativePosition(fpcRole.FpcModule.Position));
			writer.WriteQuaternion(base.Owner.PlayerCameraReference.rotation);
			_detectedPlayers.Clear();
			foreach (IDestructible item in DetectDestructibles())
			{
				if (item is HitboxIdentity hitboxIdentity)
				{
					_detectedPlayers.Add(hitboxIdentity.TargetHub);
				}
			}
			ReferenceHub primaryTarget = _detectedPlayers.GetPrimaryTarget(base.Owner.PlayerCameraReference);
			if (!(primaryTarget == null) && primaryTarget.roleManager.CurrentRole is IFpcRole fpcRole2)
			{
				writer.WriteReferenceHub(primaryTarget);
				writer.WriteRelativePosition(new RelativePosition(fpcRole2.FpcModule.Position));
			}
		}

		private void ServerAttack(ReferenceHub syncTarget)
		{
			foreach (IDestructible item in DetectDestructibles())
			{
				if ((item is HitboxIdentity hitboxIdentity && (hitboxIdentity.TargetHub != syncTarget || (!EvilMode && !hitboxIdentity.TargetHub.playerEffectsController.GetEffect<MarshmallowEffect>().IsEnabled && !HitboxIdentity.IsDamageable(base.Owner, hitboxIdentity.TargetHub)))) || !item.Damage(_attackDamage, NewDamageHandler, item.CenterOfMass))
				{
					continue;
				}
				if (item is HitboxIdentity hitboxIdentity2 && !hitboxIdentity2.TargetHub.IsAlive())
				{
					base.Owner.playerEffectsController.GetEffect<SugarCrave>().OnKill();
					if (EvilMode)
					{
						EvilAHPProcess.CurrentAmount += 100f;
					}
				}
				Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
				ServerSendPublicRpc((NetworkWriter writer) =>
				{
					writer.WriteByte(1);
				});
				break;
			}
		}

		private ArraySegment<IDestructible> DetectDestructibles()
		{
			return ScpAttackAbilityBase<HumanRole>.DetectDestructibles(base.Owner, _detectionOffset, _detectionRadius);
		}
	}
}
