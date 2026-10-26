using InventorySystem.Items.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;
using VoiceChat.Playbacks;

namespace InventorySystem.Items.Radio
{
	public class RadioThirdperson : IdleThirdpersonItem
	{
		[SerializeField]
		private SpatializedRadioPlaybackBase _playback;

		private uint _netId;

		private sbyte _prevVal;

		protected override void Update()
		{
			base.Update();
			if (!RadioMessages.SyncedRangeLevels.TryGetValue(_netId, out var value))
			{
				return;
			}
			sbyte range = (sbyte)value.Range;
			if (range != _prevVal)
			{
				if (range < 0)
				{
					_playback.gameObject.SetActive(value: false);
				}
				else
				{
					_playback.gameObject.SetActive(value: true);
					_playback.RangeId = range;
				}
				_prevVal = range;
			}
		}

		internal override void Initialize(InventorySubcontroller subcontroller, ItemIdentifier id)
		{
			base.Initialize(subcontroller, id);
			_prevVal = sbyte.MinValue;
			_netId = subcontroller.Model.OwnerHub.netId;
			_playback.IgnoredNetId = _netId;
		}
	}
}
