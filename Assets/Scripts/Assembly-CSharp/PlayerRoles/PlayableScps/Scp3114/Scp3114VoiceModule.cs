using System;
using UnityEngine;
using VoiceChat;
using VoiceChat.Playbacks;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114VoiceModule : StandardScpVoiceModule
	{
		[SerializeField]
		private SingleBufferPlayback[] _proximityPlaybacks;

		private bool _hintAlreadyDisplayed;

		private const VoiceChatChannel ProximityChannel = VoiceChatChannel.Proximity;

		private const float HumanRangeSqr = 320f;

		public override bool IsSpeaking
		{
			get
			{
				if (!base.IsSpeaking)
				{
					return _proximityPlaybacks[0].MaxSamples > 0;
				}
				return true;
			}
		}

		private bool IsDisguised => ScpRole.CurIdentity.Status == Scp3114Identity.DisguiseStatus.Active;

		private Scp3114Role ScpRole => base.Role as Scp3114Role;

		private bool AnyHumansNearby
		{
			get
			{
				Vector3 cameraPosition = ScpRole.CameraPosition;
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					if (allHub.roleManager.CurrentRole is HumanRole humanRole && !((humanRole.CameraPosition - cameraPosition).sqrMagnitude > 320f) && Physics.Linecast(cameraPosition, humanRole.CameraPosition, VisionInformation.VisionLayerMask))
					{
						return true;
					}
				}
				return false;
			}
		}

		public event Action OnHintTriggered;

		private void UpdateHint(bool primary, bool alt)
		{
			if (IsDisguised)
			{
				if (alt && AnyHumansNearby)
				{
					_hintAlreadyDisplayed = true;
				}
				else if (primary && AnyHumansNearby)
				{
					_hintAlreadyDisplayed = true;
					OnHintTriggered?.Invoke();
				}
			}
		}

		protected override VoiceChatChannel ProcessInputs(bool primary, bool alt)
		{
			if (!_hintAlreadyDisplayed)
			{
				UpdateHint(primary, alt);
			}
			if (primary)
			{
				return PrimaryChannel;
			}
			if (alt && IsDisguised)
			{
				return VoiceChatChannel.Proximity;
			}
			return VoiceChatChannel.None;
		}

		protected override void ProcessSamples(float[] data, int len)
		{
			if (base.CurrentChannel == VoiceChatChannel.Proximity)
			{
				SingleBufferPlayback[] proximityPlaybacks = _proximityPlaybacks;
				for (int i = 0; i < proximityPlaybacks.Length; i++)
				{
					proximityPlaybacks[i].WriteBuffer(data, len);
				}
			}
			else
			{
				base.ProcessSamples(data, len);
			}
		}

		public override VoiceChatChannel ValidateSend(VoiceChatChannel channel)
		{
			if ((channel != VoiceChatChannel.Proximity || !IsDisguised) && channel != PrimaryChannel)
			{
				return VoiceChatChannel.None;
			}
			return channel;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_hintAlreadyDisplayed = false;
		}
	}
}
