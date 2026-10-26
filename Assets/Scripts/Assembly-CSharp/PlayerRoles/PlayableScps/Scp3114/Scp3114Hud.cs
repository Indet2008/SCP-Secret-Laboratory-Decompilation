using PlayerRoles.PlayableScps.HUDs;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Hud : ViewmodelScpHud
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _hudRoot;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.ScpWarningHud _warning;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _strangleCooldown;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _strangleTimer;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _identityCooldown;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.LoadingCircleHud _stealSkinBar;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage _avatarImage;


	}
}
