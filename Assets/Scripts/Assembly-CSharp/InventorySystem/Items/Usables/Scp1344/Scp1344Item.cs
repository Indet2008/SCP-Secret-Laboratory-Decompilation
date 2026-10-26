using CustomPlayerEffects;
using InventorySystem.Drawers;
using InventorySystem.Items.Pickups;
using Mirror;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp1344
{
	public class Scp1344Item : UsableItem, IWearableItem, IItemProgressbarDrawer, IItemDrawer
	{
		private const ActionName InspectKey = ActionName.InspectItem;

		private const float EquipTime = 1.3f;

		private const float DeactivationTime = 5.1f;

		private const float DeactivationTransitionTime = 0.5f;

		private const float StabTime = 0.065f;

		private const float ActivationTime = 5f;

		private const float ActivationTransitionTime = 1f;

		private const float ActivationItemDeselectionTime = 0.75f;

		private const float InspectionCooldown = 4f;

		private const byte ActivationBlindnessIntensity = 100;

		private const byte LockedBlindnessIntensity = 101;

		private const byte MinBlindnessIntensity = 15;

		private const float BarWidth = 650f;

		private Scp1344Status _status;

		private float _useTime;

		private float _cancelationTime;

		private byte _savedIntensity;

		private double _nextInspectTime;

		private int _lastLifeId;

		public CustomPlayerEffects.Scp1344 Scp1344Effect => base.Owner.playerEffectsController.GetEffect<CustomPlayerEffects.Scp1344>();

		public Blindness BlindnessEffect => base.Owner.playerEffectsController.GetEffect<Blindness>();

		public SeveredEyes SeveredEyesEffect => base.Owner.playerEffectsController.GetEffect<SeveredEyes>();

		public bool IsWorn
		{
			get
			{
				Scp1344Status status = Status;
				return status == Scp1344Status.Active || status == Scp1344Status.Deactivating;
			}
		}

		public WearableSlot Slot => WearableSlot.Eyes;

		public override bool CanStartUsing
		{
			get
			{
				if (!base.Owner.HasBlock(BlockedInteraction.ItemPrimaryAction))
				{
					if (Status != Scp1344Status.Deactivating)
					{
						if (Status == Scp1344Status.Idle && !Scp1344Effect.IsEnabled)
						{
							return BlindnessEffect.Intensity <= 100;
						}
						return false;
					}
					return true;
				}
				return false;
			}
		}

		public override bool AllowEquip => Status != Scp1344Status.Active;

		public override bool AllowHolster
		{
			get
			{
				if (Status == Scp1344Status.Deactivating)
				{
					return !base.IsEquipped;
				}
				return true;
			}
		}

		public bool AllowInspect
		{
			get
			{
				if (Status == Scp1344Status.Idle)
				{
					return _nextInspectTime < NetworkTime.time;
				}
				return false;
			}
		}

		public bool ProgressbarEnabled => Status == Scp1344Status.Deactivating;

		public float ProgressbarMin => 0f;

		public float ProgressbarMax => 5.1f;

		public float ProgressbarValue
		{
			get
			{
				if (!NetworkServer.active)
				{
					return Time.time - _useTime;
				}
				return _useTime;
			}
		}

		public float ProgressbarWidth => 650f;

		public Scp1344Status Status
		{
			get
			{
				if (CurLifeId != _lastLifeId)
				{
					_status = Scp1344Status.Idle;
					_lastLifeId = CurLifeId;
				}
				return _status;
			}
			set
			{
				_status = value;
				_lastLifeId = CurLifeId;
				if (NetworkServer.active)
				{
					ServerChangeStatus(value);
				}
				else
				{
					ClientChangeStatus(value);
				}
			}
		}

		private int CurLifeId => base.Owner.roleManager.CurrentRole.UniqueLifeIdentifier;

		public override void ServerOnUsingCompleted()
		{
			if (Status == Scp1344Status.Idle)
			{
				ServerSetStatus(Scp1344Status.Equipping);
			}
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			if (NetworkServer.active)
			{
				Scp1344Status status = Status;
				if (status != Scp1344Status.Stabbing && status != Scp1344Status.Active && status != Scp1344Status.Dropping && status != Scp1344Status.CancelingDeactivation)
				{
					ServerSetStatus(Scp1344Status.Idle);
				}
			}
		}

		public override ItemPickupBase ServerDropItem(bool spawn)
		{
			Scp1344Status status = Status;
			if (status == Scp1344Status.Deactivating || status == Scp1344Status.CancelingDeactivation)
			{
				return null;
			}
			if (Status != Scp1344Status.Active)
			{
				return base.ServerDropItem(spawn);
			}
			ServerSetStatus(Scp1344Status.Dropping);
			return null;
		}

		public override void OnEquipped()
		{
			base.OnEquipped();
			if (NetworkServer.active && Status == Scp1344Status.Dropping)
			{
				ServerSetStatus(Scp1344Status.Deactivating);
			}
		}

		public override void OnUsingStarted()
		{
			if (NetworkServer.active && Status == Scp1344Status.Deactivating)
			{
				ServerSetStatus(Scp1344Status.CancelingDeactivation);
			}
			else
			{
				base.OnUsingStarted();
			}
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (Input.GetKeyDown(NewInput.GetKey(ActionName.InspectItem)) && AllowInspect)
			{
				NetworkClient.Send(new Scp1344StatusMessage(base.ItemSerial, Scp1344Status.Inspecting));
			}
		}

		private void OnPlayerInventoryDropped(ReferenceHub targetHub)
		{
			if (!(targetHub != base.Owner))
			{
				base.ServerDropItem(spawn: true);
				Scp1344Status status = Status;
				if (status == Scp1344Status.Active || status == Scp1344Status.Stabbing || status == Scp1344Status.Deactivating)
				{
					ActivateFinalEffects();
				}
			}
		}

		private void OnAnyPlayerDied(ReferenceHub hub, DamageHandlerBase _)
		{
			if (!(hub != base.Owner))
			{
				Status = Scp1344Status.Idle;
			}
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				switch (Status)
				{
				case Scp1344Status.Equipping:
					ServerUpdateTimedStatus(1.3f, Scp1344Status.Activating);
					break;
				case Scp1344Status.Activating:
					ServerUpdateTimedStatus(5f, Scp1344Status.Stabbing);
					break;
				case Scp1344Status.Stabbing:
					ServerUpdateTimedStatus(0.065f, Scp1344Status.Active);
					break;
				case Scp1344Status.Active:
					ServerUpdateActive();
					break;
				case Scp1344Status.Deactivating:
					ServerUpdateDeactivating();
					break;
				case Scp1344Status.CancelingDeactivation:
					ServerUpdateTimedStatus(0.5f, Scp1344Status.Active);
					break;
				case Scp1344Status.Dropping:
					break;
				}
			}
		}

		private void ServerUpdateTimedStatus(float time, Scp1344Status status)
		{
			_useTime += Time.deltaTime;
			if (!(_useTime < time))
			{
				switch (Status)
				{
				case Scp1344Status.Stabbing:
					_savedIntensity = 100;
					break;
				case Scp1344Status.CancelingDeactivation:
					base.OwnerInventory.ServerSelectItem(0);
					break;
				}
				ServerSetStatus(status);
			}
		}

		private void ServerUpdateActive()
		{
			if (BlindnessEffect.Intensity <= 15)
			{
				return;
			}
			_useTime += Time.deltaTime;
			float useTime = _useTime;
			if (useTime < 0.75f)
			{
				return;
			}
			if (useTime < 1f)
			{
				if (base.IsEquipped)
				{
					base.OwnerInventory.ServerSelectItem(0);
				}
			}
			else
			{
				float num = 100f - 20f * Mathf.Pow(_useTime, 0.385f);
				BlindnessEffect.Intensity = (byte)num;
			}
		}

		private void ServerUpdateDeactivating()
		{
			_useTime += Time.deltaTime;
			float useTime = _useTime;
			if (!(useTime < 0.5f))
			{
				if (useTime < 5.1f)
				{
					BlindnessEffect.Intensity = _savedIntensity;
					return;
				}
				ActivateFinalEffects();
				base.ServerDropItem(spawn: true);
			}
		}

		private void ActivateFinalEffects()
		{
			BlindnessEffect.Intensity = 101;
			Scp1344Effect.IsEnabled = false;
			SeveredEyesEffect.IsEnabled = true;
		}

		private void Awake()
		{
			Scp1344NetworkHandler.OnStatusChanged += OnStatusChanged;
			InventoryExtensions.OnInventoryDropped += OnPlayerInventoryDropped;
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			Scp1344NetworkHandler.OnStatusChanged -= OnStatusChanged;
			InventoryExtensions.OnInventoryDropped -= OnPlayerInventoryDropped;
			PlayerStats.OnAnyPlayerDied -= OnAnyPlayerDied;
		}

		private void OnStatusChanged(ushort serial, Scp1344Status status)
		{
			if (base.ItemSerial == serial)
			{
				Status = status;
				if (status == Scp1344Status.Dropping)
				{
					Scp1344Effect.PlayBuildupSound();
				}
			}
		}

		private void ServerSetStatus(Scp1344Status status)
		{
			Scp1344NetworkHandler.ServerSendMessage(new Scp1344StatusMessage(base.ItemSerial, status));
			switch (status)
			{
			case Scp1344Status.Activating:
				base.Owner.EnableWearables(WearableElements.Scp1344Goggles);
				break;
			case Scp1344Status.Idle:
				base.Owner.DisableWearables(WearableElements.Scp1344Goggles);
				break;
			}
		}

		private void ClientChangeStatus(Scp1344Status status)
		{
			switch (status)
			{
			case Scp1344Status.Deactivating:
				IsUsing = false;
				_useTime = Time.time;
				break;
			case Scp1344Status.Inspecting:
				_nextInspectTime = NetworkTime.time + 4.0;
				break;
			}
		}

		private void ServerChangeStatus(Scp1344Status status)
		{
			switch (status)
			{
			case Scp1344Status.Idle:
			case Scp1344Status.Equipping:
			case Scp1344Status.Activating:
			case Scp1344Status.Stabbing:
			case Scp1344Status.Deactivating:
				IsUsing = false;
				_useTime = 0f;
				break;
			case Scp1344Status.Active:
				_useTime = _cancelationTime;
				_cancelationTime = 0f;
				Scp1344Effect.IsEnabled = true;
				BlindnessEffect.Intensity = _savedIntensity;
				break;
			case Scp1344Status.Dropping:
				_cancelationTime = _useTime;
				_savedIntensity = BlindnessEffect.Intensity;
				BlindnessEffect.Intensity = 101;
				if (base.OwnerInventory.CurItem.SerialNumber == base.ItemSerial)
				{
					ServerSetStatus(Scp1344Status.Deactivating);
				}
				else
				{
					base.OwnerInventory.ServerSelectItem(base.ItemSerial);
				}
				break;
			case Scp1344Status.Inspecting:
				_nextInspectTime = NetworkTime.time + 4.0;
				break;
			case Scp1344Status.CancelingDeactivation:
				_useTime = 0f;
				_savedIntensity = BlindnessEffect.Intensity;
				BlindnessEffect.Intensity = 100;
				break;
			}
		}
	}
}
