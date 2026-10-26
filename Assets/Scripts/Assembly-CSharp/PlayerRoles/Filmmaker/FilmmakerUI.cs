using UnityEngine;

namespace PlayerRoles.Filmmaker
{
	public class FilmmakerUI : MonoBehaviour
	{
		private enum FilmmakerKey
		{
			UpdatePlayback = 32,
			JumpToBeginning = 278,
			JumpToEnd = 279,
			RemoveKeyframe = 127,
			JumpForward = 275,
			JumpBackward = 276
		}

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Toggle _automaticPreview;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.Slider _playbackSpeedPercent;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _playbackSpeedText;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Dropdown _blendModeDropdown;


	}
}
