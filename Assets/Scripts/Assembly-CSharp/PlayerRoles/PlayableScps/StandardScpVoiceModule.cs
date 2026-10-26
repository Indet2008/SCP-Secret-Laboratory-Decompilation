using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp079;
using PlayerRoles.Visibility;
using PlayerRoles.Voice;
using UnityEngine;
using VoiceChat;

namespace PlayerRoles.PlayableScps
{
	public class StandardScpVoiceModule : GlobalVoiceModuleBase
	{
		private VisibilityController _visibilityController;

		protected override VoiceChatChannel PrimaryChannel => VoiceChatChannel.ScpChat;

		public override VoiceChatChannel ValidateReceive(ReferenceHub speaker, VoiceChatChannel channel)
		{
			channel = base.ValidateReceive(speaker, channel);
			if (channel == VoiceChatChannel.Proximity && !CheckProximity(speaker))
			{
				return VoiceChatChannel.None;
			}
			return channel;
		}

		protected override void Awake()
		{
			base.Awake();
			if (base.Role is ICustomVisibilityRole customVisibilityRole)
			{
				_visibilityController = customVisibilityRole.VisibilityController;
			}
		}

		private bool CheckProximity(ReferenceHub hub)
		{
			if (base.Owner.roleManager.CurrentRole is Scp079Role scp079Role)
			{
				return Vector3.Distance(scp079Role.CameraPosition, hub.GetPosition()) <= 110f;
			}
			if (_visibilityController == null)
			{
				return Vector3.Distance(base.Owner.GetPosition(), hub.GetPosition()) <= 110f;
			}
			if (hub != base.Owner)
			{
				return _visibilityController.ValidateVisibility(hub);
			}
			return false;
		}
	}
}
