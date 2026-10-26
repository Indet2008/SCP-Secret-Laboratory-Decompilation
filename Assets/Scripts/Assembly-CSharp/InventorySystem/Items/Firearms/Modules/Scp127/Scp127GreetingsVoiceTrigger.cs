using AudioPooling;
using InventorySystem.Items.Pickups;
using MapGeneration.Distributors;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127GreetingsVoiceTrigger : Scp127VoiceTriggerBase
	{
		[SerializeField]
		private Scp127VoiceLineCollection _firstTimeEquipLines;

		[SerializeField]
		private Scp127VoiceLineCollection _lockerEquipLines;

		[SerializeField]
		private Scp127VoiceLineCollection _reEquipLines;

		[SerializeField]
		private Scp127VoiceLineCollection _holsterLines;

		[SerializeField]
		private Scp127VoiceLineCollection _droppedLines;

		[SerializeField]
		private float _uniquePickupLineTimeout;

		private int _remainingFramesHolster;

		private float _rangeMultiplier;

		private bool _pickedUpFromLocker;

		private bool _newFriendship;

		private double _pickupTimestamp;

		private const float OwnerDroppedRangeScale = 3f;

		protected override float DefaultAudioRange => _rangeMultiplier * base.DefaultAudioRange;

		internal override void ServerOnPickedUp(ItemPickupBase ipb)
		{
			base.ServerOnPickedUp(ipb);
			if (ipb.transform.TryGetComponentInParent<Locker>(out var _))
			{
				_pickupTimestamp = NetworkTime.time;
				_pickedUpFromLocker = true;
				base.Item.OwnerInventory.ServerSelectItem(base.ItemSerial);
			}
		}

		public override AudioPoolSession? OnVoiceLineRequested(ushort serial, AudioClip clip, NetworkReader extraData)
		{
			bool flag = extraData.Remaining > 0 && extraData.TryReadReferenceHub(out var hub) && hub.IsPOV;
			_rangeMultiplier = (flag ? 3f : 1f);
			return base.OnVoiceLineRequested(serial, clip, extraData);
		}

		public override bool ContainsAudioClip(AudioClip clip)
		{
			if (!_firstTimeEquipLines.Contains(clip) && !_lockerEquipLines.Contains(clip) && !_reEquipLines.Contains(clip) && !_holsterLines.Contains(clip))
			{
				return _droppedLines.Contains(clip);
			}
			return true;
		}

		public override void OnFriendshipCreated()
		{
			base.OnFriendshipCreated();
			_newFriendship = true;
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (!base.IsServer)
			{
				return;
			}
			if (_newFriendship)
			{
				double num = NetworkTime.time - _pickupTimestamp;
				if (_pickedUpFromLocker && num < (double)_uniquePickupLineTimeout)
				{
					_pickedUpFromLocker = false;
					ServerPlayVoiceLineFromCollection(_lockerEquipLines);
				}
				else
				{
					ServerPlayVoiceLineFromCollection(_firstTimeEquipLines);
				}
				_newFriendship = false;
			}
			else
			{
				ServerPlayVoiceLineFromCollection(_reEquipLines, null, VoiceLinePriority.Low);
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			if (base.IsServer)
			{
				_remainingFramesHolster = 3;
			}
		}

		internal override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (base.IsServer && !(pickup == null))
			{
				ServerPlayVoiceLineFromCollection(_droppedLines, WriteOwner);
			}
		}

		internal override void AlwaysUpdate()
		{
			base.AlwaysUpdate();
			if (!base.IsServer || _remainingFramesHolster == 0)
			{
				return;
			}
			if (base.Firearm.IsEquipped)
			{
				_remainingFramesHolster = 0;
				return;
			}
			_remainingFramesHolster--;
			if (_remainingFramesHolster <= 0)
			{
				ServerPlayVoiceLineFromCollection(_holsterLines, null, VoiceLinePriority.Low);
			}
		}

		private void WriteOwner(NetworkWriter writer)
		{
			writer.WriteReferenceHub(base.Item.Owner);
		}
	}
}
