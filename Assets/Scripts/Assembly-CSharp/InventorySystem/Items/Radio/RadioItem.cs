using InventorySystem.GUI;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Scp914;
using UnityEngine;
using VoiceChat.Playbacks;

namespace InventorySystem.Items.Radio
{
	public class RadioItem : ItemBase, IAcquisitionConfirmationTrigger, IItemDescription, IItemNametag, IUpgradeTrigger, IUniqueItem
	{
		private const float DrainMultiplier = 0.5f;

		public RadioRangeMode[] Ranges;

		public AnimationCurve VoiceVolumeCurve;

		public AnimationCurve NoiseLevelCurve;

		private bool _enabled;

		private float _battery;

		private byte _lastSentBatteryLevel;

		private byte _rangeId;

		private static KeyCode _circleModeKey;

		private static KeyCode _toggleKey;

		public bool AcquisitionAlreadyReceived { get; set; }

		public override float Weight => 1.7f;

		public bool IsUsable
		{
			get
			{
				if (_enabled)
				{
					return _battery > 0f;
				}
				return false;
			}
		}

		public string Description => ItemTypeId.GetDescription();

		public string Name => ItemTypeId.GetName();

		public byte BatteryPercent
		{
			get
			{
				return (byte)Mathf.RoundToInt(_battery * 100f);
			}
			set
			{
				_battery = (float)(int)value / 100f;
			}
		}

		public RadioMessages.RadioRangeLevel RangeLevel => (RadioMessages.RadioRangeLevel)(_enabled ? _rangeId : (-1));

		public void ServerConfirmAcqusition()
		{
			SendStatusMessage();
		}

		public bool CompareIdentical(ItemBase other)
		{
			if (other is RadioItem radioItem && RangeLevel == radioItem.RangeLevel)
			{
				return BatteryPercent == radioItem.BatteryPercent;
			}
			return false;
		}

		public void ServerOnUpgraded(Scp914KnobSetting setting)
		{
			BatteryPercent = 100;
			SendStatusMessage();
		}

		public override void OnAdded(ItemPickupBase ipb)
		{
			if (IsLocalPlayer)
			{
				_circleModeKey = NewInput.GetKey(ActionName.Shoot);
				_toggleKey = NewInput.GetKey(ActionName.Zoom);
			}
			if (NetworkServer.active)
			{
				if (ipb is RadioPickup radioPickup)
				{
					_enabled = radioPickup.SavedEnabled;
					_rangeId = radioPickup.SavedRange;
					_battery = radioPickup.SavedBattery;
				}
				else
				{
					_enabled = true;
					_battery = 1f;
					_rangeId = 1;
				}
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			if (NetworkServer.active && pickup is RadioPickup radioPickup)
			{
				radioPickup.NetworkSavedEnabled = _enabled;
				radioPickup.NetworkSavedRange = _rangeId;
				radioPickup.SavedBattery = _battery;
			}
		}

		public override void OnEquipped()
		{
			if (NetworkServer.active)
			{
				SendStatusMessage();
			}
		}

		public override void EquipUpdate()
		{
			if (IsLocalPlayer && InventoryGuiController.ItemsSafeForInteraction && !Cursor.visible)
			{
				if (Input.GetKeyDown(_circleModeKey) && _enabled)
				{
					NetworkClient.Send(new ClientRadioCommandMessage(RadioMessages.RadioCommand.ChangeRange));
				}
				if (Input.GetKeyDown(_toggleKey))
				{
					NetworkClient.Send(new ClientRadioCommandMessage(_enabled ? RadioMessages.RadioCommand.Disable : RadioMessages.RadioCommand.Enable));
				}
			}
		}

		public void ServerProcessCmd(RadioMessages.RadioCommand command)
		{
			if (base.Owner.HasBlock(BlockedInteraction.ItemUsage))
			{
				return;
			}
			switch (command)
			{
			case RadioMessages.RadioCommand.Enable:
			{
				if (_enabled || _battery <= 0f)
				{
					return;
				}
				PlayerTogglingRadioEventArgs e3 = new PlayerTogglingRadioEventArgs(base.Owner, this, newState: true);
				PlayerEvents.OnTogglingRadio(e3);
				if (!e3.IsAllowed)
				{
					return;
				}
				_enabled = true;
				PlayerEvents.OnToggledRadio(new PlayerToggledRadioEventArgs(base.Owner, this, newState: true));
				break;
			}
			case RadioMessages.RadioCommand.Disable:
			{
				if (!_enabled)
				{
					return;
				}
				PlayerTogglingRadioEventArgs e2 = new PlayerTogglingRadioEventArgs(base.Owner, this, newState: false);
				PlayerEvents.OnTogglingRadio(e2);
				if (!e2.IsAllowed)
				{
					return;
				}
				_enabled = false;
				PlayerEvents.OnToggledRadio(new PlayerToggledRadioEventArgs(base.Owner, this, newState: false));
				break;
			}
			case RadioMessages.RadioCommand.ChangeRange:
			{
				byte b = (byte)(_rangeId + 1);
				if (b >= Ranges.Length)
				{
					b = 0;
				}
				PlayerChangingRadioRangeEventArgs e = new PlayerChangingRadioRangeEventArgs(base.Owner, this, (RadioMessages.RadioRangeLevel)b);
				PlayerEvents.OnChangingRadioRange(e);
				if (!e.IsAllowed)
				{
					return;
				}
				PlayerEvents.OnChangedRadioRange(new PlayerChangedRadioRangeEventArgs(range: (RadioMessages.RadioRangeLevel)(_rangeId = (byte)e.Range), hub: base.Owner, radio: this));
				break;
			}
			}
			SendStatusMessage();
		}

		public void UserReceiveInfo(RadioStatusMessage info)
		{
			if (IsLocalPlayer)
			{
				_enabled = info.Range != RadioMessages.RadioRangeLevel.RadioDisabled;
				BatteryPercent = info.Battery;
			}
		}

		private void Update()
		{
			if (!NetworkServer.active || !IsUsable)
			{
				return;
			}
			float num = (PersonalRadioPlayback.IsTransmitting(base.Owner) ? ((float)Ranges[_rangeId].MinuteCostWhenTalking) : Ranges[_rangeId].MinuteCostWhenIdle);
			float drain = Time.deltaTime * 0.5f * (num / 60f / 100f);
			PlayerUsingRadioEventArgs e = new PlayerUsingRadioEventArgs(base.Owner, this, drain);
			PlayerEvents.OnUsingRadio(e);
			if (e.IsAllowed)
			{
				drain = e.Drain;
				_battery = Mathf.Clamp01(_battery - drain);
				if (_battery == 0f)
				{
					_enabled = false;
				}
				if (Mathf.Abs(_lastSentBatteryLevel - BatteryPercent) >= 1 && base.OwnerInventory.CurItem.TypeId == ItemType.Radio)
				{
					SendStatusMessage();
				}
				PlayerEvents.OnUsedRadio(new PlayerUsedRadioEventArgs(base.Owner, this, drain));
			}
		}

		private void SendStatusMessage()
		{
			_lastSentBatteryLevel = BatteryPercent;
			NetworkServer.SendToReady(new RadioStatusMessage(this));
		}
	}
}
