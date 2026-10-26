using ToggleableMenus;

namespace PlayerRoles.Spectating
{
	public class OverwatchVoiceChatWindowToggler : SimpleToggleableMenu
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::TMPro.TextMeshProUGUI _toggleHint;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TextMeshProUGUI _menuTitle;


	}
}
