using System;
using System.Diagnostics;
using AudioPooling;
using CustomPlayerEffects;
using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration.Distributors;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using Scp914;
using UnityEngine;
using Utils;

namespace InventorySystem.Items.Jailbird
{
	public class JailbirdItem : MeleeAutoSync, IItemDescription, IItemNametag, IUpgradeTrigger, IUniqueItem, IMovementInputOverride, IMovementSpeedModifier, IItemAlertDrawer, IItemDrawer
	{
		private const ActionName TriggerMelee = ActionName.Shoot;

		private const ActionName TriggerCharge = ActionName.Zoom;

		private const ActionName InspectKey = ActionName.InspectItem;

		private const float ServerChargeTolerance = 0.4f;

		private double _chargeResetTime;

		private bool _charging;

		private readonly Stopwatch _chargeLoadStopwatch = new Stopwatch();

		private bool _chargeAnyDetected;

		private bool _firstChargeFrame;

		private bool _attackTriggered;

		private readonly TolerantAbilityCooldown _serverAttackCooldown = new TolerantAbilityCooldown();

		private readonly AbilityCooldown _clientAttackCooldown = new AbilityCooldown();

		private readonly AbilityCooldown _clientDelayCooldown = new AbilityCooldown();

		private readonly ItemHintAlertHelper _hintHelper = new ItemHintAlertHelper(InventoryGuiTranslation.JailbirdAttackHint, ActionName.Shoot, InventoryGuiTranslation.JailbirdChargeHint, ActionName.Zoom);

		[SerializeField]
		private AudioClip _hitClip;

		[SerializeField]
		private float _meleeDelay;

		[SerializeField]
		private float _meleeCooldown;

		[SerializeField]
		private float _chargeDuration;

		[SerializeField]
		private float _chargeReadyTime;

		[SerializeField]
		private float _chargeMovementSpeedMultiplier;

		[SerializeField]
		private float _chargeMovementSpeedLimiter;

		[SerializeField]
		private float _chargeCancelVelocitySqr;

		[SerializeField]
		private float _chargeAutoengageTime;

		[SerializeField]
		private float _chargeDetectionDelay;

		[SerializeField]
		private float _brokenRemoveTime;

		[SerializeField]
		private float _hitregOffset;

		[SerializeField]
		private float _hitregRadius;

		[SerializeField]
		private float _chargeDamage;

		[SerializeField]
		[Tooltip("How long in seconds the 'concussed' effect is applied for on attacked targets.")]
		private float _concussionDuration;

		[SerializeField]
		[Tooltip("How long in seconds the 'flashed' effect is applied for on attacked targets.")]
		private float _flashedDuration = 1.5f;

		[SerializeField]
		private JailbirdDeteriorationTracker _deterioration;

		public override float Weight => 1.7f;

		public override bool AllowHolster
		{
			get
			{
				if (!_charging)
				{
					return !_chargeLoadStopwatch.IsRunning;
				}
				return false;
			}
		}

		public int TotalChargesPerformed { get; private set; }

		public bool MovementOverrideActive => _charging;

		public Vector3 MovementOverrideDirection => base.Owner.transform.forward;

		public bool MovementModifierActive => _charging;

		public float MovementSpeedMultiplier => _chargeMovementSpeedMultiplier;

		public float MovementSpeedLimit => _chargeMovementSpeedLimiter;

		public string Description => ItemTypeId.GetDescription();

		public string Name => ItemTypeId.GetName();

		public AlertContent Alert => _hintHelper.Alert;

		public override byte AttackPreformedByte => 4;

		public float TotalMeleeDamageDealt { get; internal set; }

		public static event Action<ushort, JailbirdMessageType> OnRpcReceived;

		public event Action<JailbirdMessageType> OnCmdSent;

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			_deterioration.Setup(this);
			if (!NetworkServer.active)
			{
				return;
			}
			if (pickup is JailbirdPickup jailbirdPickup)
			{
				TotalChargesPerformed = jailbirdPickup.TotalCharges;
				TotalMeleeDamageDealt = jailbirdPickup.TotalMelee;
				if (!jailbirdPickup.transform.TryGetComponentInParent<Locker>(out var _))
				{
					return;
				}
				base.OwnerInventory.ServerSelectItem(base.ItemSerial);
			}
			_deterioration.RecheckUsage();
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (NetworkServer.active && pickup is JailbirdPickup jailbirdPickup)
			{
				if (_deterioration.IsBroken)
				{
					jailbirdPickup.DestroySelf();
					return;
				}
				jailbirdPickup.TotalCharges = TotalChargesPerformed;
				jailbirdPickup.TotalMelee = TotalMeleeDamageDealt;
				jailbirdPickup.NetworkWear = _deterioration.WearState;
			}
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			_hintHelper.Hide();
			_chargeLoadStopwatch.Reset();
			_charging = false;
			_attackTriggered = false;
			if (NetworkServer.active)
			{
				SendRpc(JailbirdMessageType.Holstered);
				if (_deterioration.IsBroken)
				{
					base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
				}
			}
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			_hintHelper.Update(base.Owner);
			if (_deterioration.IsBroken)
			{
				if (NetworkServer.active)
				{
					_brokenRemoveTime -= Time.deltaTime;
				}
				if (_brokenRemoveTime < 0f)
				{
					base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
				}
			}
			else if (_charging)
			{
				UpdateCharging();
			}
			else
			{
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
				if (!_clientAttackCooldown.IsReady)
				{
					return;
				}
				if (GetAction(ActionName.Zoom) & flag)
				{
					if (!_chargeLoadStopwatch.IsRunning)
					{
						SendCmd(JailbirdMessageType.ChargeLoadTriggered);
						_chargeLoadStopwatch.Start();
					}
					if (_chargeLoadStopwatch.Elapsed.TotalSeconds < (double)_chargeAutoengageTime)
					{
						return;
					}
				}
				if (_chargeLoadStopwatch.IsRunning)
				{
					if ((_chargeLoadStopwatch.Elapsed.TotalSeconds > (double)_chargeReadyTime) & flag)
					{
						SendCmd(JailbirdMessageType.ChargeStarted);
					}
					else
					{
						SendCmd(JailbirdMessageType.ChargeFailed);
					}
					_chargeLoadStopwatch.Reset();
				}
				if (GetActionDown(ActionName.InspectItem) & flag2)
				{
					SendCmd(JailbirdMessageType.Inspect);
				}
				if (GetAction(ActionName.Shoot) && flag)
				{
					_attackTriggered = true;
					SendCmd(JailbirdMessageType.AttackTriggered);
					_clientDelayCooldown.Trigger(_meleeDelay);
					_clientAttackCooldown.Trigger(_meleeCooldown);
				}
			}
		}

		public void ServerReset()
		{
			if (NetworkServer.active)
			{
				TotalMeleeDamageDealt = 0f;
				TotalChargesPerformed = 0;
				_deterioration.RecheckUsage();
			}
		}

		public void ServerOnUpgraded(Scp914KnobSetting setting)
		{
			if (NetworkServer.active)
			{
				if (setting == Scp914KnobSetting.Coarse)
				{
					TotalChargesPerformed = JailbirdDeteriorationTracker.Scp914CoarseCharges;
					TotalMeleeDamageDealt = JailbirdDeteriorationTracker.Scp914CoarseDamage;
					_deterioration.RecheckUsage();
				}
				else
				{
					ServerReset();
				}
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			JailbirdMessageType jailbirdMessageType = (JailbirdMessageType)reader.ReadByte();
			OnRpcReceived?.Invoke(serial, jailbirdMessageType);
			switch (jailbirdMessageType)
			{
			case JailbirdMessageType.UpdateState:
				JailbirdDeteriorationTracker.ReadUsage(serial, reader);
				break;
			case JailbirdMessageType.AttackPerformed:
			{
				if (reader.ReadBool() && InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
				{
					AudioSourcePoolManager.PlayOnTransform(_hitClip, hub.transform, 15f);
				}
				break;
			}
			}
		}

		public override void ClientProcessRpcInstance(NetworkReader reader)
		{
			base.ClientProcessRpcInstance(reader);
			if (IsLocalPlayer)
			{
				switch ((JailbirdMessageType)reader.ReadByte())
				{
				case JailbirdMessageType.ChargeStarted:
					_charging = true;
					_firstChargeFrame = true;
					_chargeLoadStopwatch.Reset();
					_chargeAnyDetected = false;
					_chargeResetTime = reader.ReadDouble();
					break;
				case JailbirdMessageType.ChargeFailed:
					_chargeLoadStopwatch.Reset();
					_charging = false;
					break;
				}
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (_deterioration.IsBroken || !base.IsEquipped)
			{
				return;
			}
			JailbirdMessageType msg = (JailbirdMessageType)reader.ReadByte();
			bool allowAttack = !base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction);
			bool allowInspect = !base.Owner.HasBlock(BlockedInteraction.ItemUsage);
			PlayerProcessingJailbirdMessageEventArgs e = new PlayerProcessingJailbirdMessageEventArgs(base.Owner, this, msg, allowAttack, allowInspect);
			PlayerEvents.OnProcessingJailbirdMessage(e);
			if (!e.IsAllowed)
			{
				return;
			}
			msg = e.Message;
			allowAttack = e.AllowAttack;
			allowInspect = e.AllowInspect;
			if (!allowInspect)
			{
				return;
			}
			switch (msg)
			{
			case JailbirdMessageType.AttackTriggered:
				if (!allowAttack || (!base.IsControllable && _attackTriggered) || _chargeLoadStopwatch.IsRunning || !_serverAttackCooldown.TolerantIsReady)
				{
					return;
				}
				_attackTriggered = true;
				_serverAttackCooldown.Trigger(_meleeCooldown);
				SendRpc(JailbirdMessageType.AttackTriggered);
				break;
			case JailbirdMessageType.AttackPerformed:
				if (!allowAttack)
				{
					return;
				}
				if (_charging)
				{
					JailbirdServerAttack(reader);
					return;
				}
				if (!_attackTriggered || !allowAttack)
				{
					return;
				}
				_attackTriggered = false;
				JailbirdServerAttack(reader);
				break;
			case JailbirdMessageType.Inspect:
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
			case JailbirdMessageType.ChargeFailed:
				_chargeLoadStopwatch.Reset();
				SendRpc(msg);
				break;
			case JailbirdMessageType.ChargeLoadTriggered:
				if (allowAttack)
				{
					if (!allowAttack || _charging || _chargeLoadStopwatch.IsRunning)
					{
						return;
					}
					_chargeLoadStopwatch.Start();
					SendRpc(msg);
				}
				break;
			case JailbirdMessageType.ChargeStarted:
			{
				double totalSeconds = _chargeLoadStopwatch.Elapsed.TotalSeconds;
				if (!allowAttack || totalSeconds - 0.4000000059604645 > (double)_chargeAutoengageTime || totalSeconds + 0.4000000059604645 < (double)_chargeDuration)
				{
					SendRpc(JailbirdMessageType.ChargeFailed);
					break;
				}
				if (_charging)
				{
					return;
				}
				_chargeLoadStopwatch.Reset();
				_charging = true;
				_chargeResetTime = NetworkTime.time + (double)_chargeDuration;
				TotalChargesPerformed++;
				SendRpc(JailbirdMessageType.ChargeStarted, (NetworkWriter wr) =>
				{
					wr.WriteDouble(_chargeResetTime);
				});
				break;
			}
			}
			PlayerEvents.OnProcessedJailbirdMessage(new PlayerProcessedJailbirdMessageEventArgs(base.Owner, this, msg));
		}

		private void UpdateCharging()
		{
			double num = _chargeResetTime - NetworkTime.time;
			if (NetworkServer.active && num < -0.4000000059604645)
			{
				JailbirdServerAttack(null);
			}
			else
			{
				if (!IsLocalPlayer)
				{
					return;
				}
				if (!_chargeAnyDetected && base.AnyDetected)
				{
					num = Mathf.Min((float)num, _chargeDetectionDelay);
					_chargeResetTime = NetworkTime.time + num;
					_chargeAnyDetected = true;
				}
				if (num > 0.0)
				{
					if (_firstChargeFrame)
					{
						_firstChargeFrame = false;
						return;
					}
					if (base.Owner.GetVelocity().SqrMagnitudeIgnoreY() > _chargeCancelVelocitySqr)
					{
						return;
					}
				}
				ClientAttack();
				_charging = false;
				_clientAttackCooldown.Trigger(_meleeCooldown);
			}
		}

		private void JailbirdServerAttack(NetworkReader reader)
		{
			bool anyDamaged = ServerAttack(reader) == HitResult.HitPlayer;
			if (anyDamaged)
			{
				Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
			}
			SendRpc(JailbirdMessageType.AttackPerformed, (NetworkWriter wr) =>
			{
				wr.WriteBool(anyDamaged);
			});
			_deterioration.RecheckUsage();
			if (_charging)
			{
				_charging = false;
				if (_deterioration.IsBroken && anyDamaged)
				{
					ExplosionUtils.ServerExplode(base.Owner, ExplosionType.Jailbird);
				}
			}
		}

		private void ClientAttack()
		{
			if (ClientTryAttack())
			{
				OnCmdSent?.Invoke(JailbirdMessageType.AttackPerformed);
			}
		}

		private void SendRpc(JailbirdMessageType header, Action<NetworkWriter> extraData = null)
		{
			NetworkWriter writer;
			using (new AutosyncRpc(base.ItemId, out writer))
			{
				writer.WriteByte((byte)header);
				extraData?.Invoke(writer);
			}
		}

		private void SendCmd(JailbirdMessageType msg)
		{
			NetworkWriter writer;
			using (new AutosyncCmd(base.ItemId, out writer))
			{
				writer.WriteByte((byte)msg);
			}
			OnCmdSent?.Invoke(msg);
		}

		public bool CompareIdentical(ItemBase other)
		{
			if (other is JailbirdItem jailbirdItem)
			{
				return _deterioration.WearState == jailbirdItem._deterioration.WearState;
			}
			return false;
		}

		public override bool ApplyDamage(ReferenceHub attacker, IDestructible victim, float damage, Vector3 direction, bool isPrimaryTarget)
		{
			float num = (_charging ? _chargeDamage : damage);
			if (!victim.Damage(num, new JailbirdDamageHandler(attacker, num, direction), victim.CenterOfMass))
			{
				return false;
			}
			if (!_charging)
			{
				TotalMeleeDamageDealt += num;
			}
			else if (victim is HitboxIdentity hitboxIdentity)
			{
				hitboxIdentity.TargetHub.playerEffectsController.EnableEffect<Flashed>(_flashedDuration, addDuration: true);
				hitboxIdentity.TargetHub.playerEffectsController.EnableEffect<Concussed>(_concussionDuration, addDuration: true);
			}
			return true;
		}
	}
}
