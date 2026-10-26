using PlayerRoles.PlayableScps.HUDs;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939Hud : ViewmodelScpHud
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _hudRoot;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _mimicryMenuRoot;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TextMeshProUGUI _lungeReadyText;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _amnesticCloudPlacedIcon;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _amnesticCloudBuildupIcon;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.AbilityHud _mimicryCooldown;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.HUDs.ScpWarningHud _warningElement;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.Volume _postProcessVolume;

		[global::UnityEngine.SerializeField]
		private float _blurAdditive;

		[global::UnityEngine.SerializeField]
		private float _effectsLerpSpeed;


	}
}
