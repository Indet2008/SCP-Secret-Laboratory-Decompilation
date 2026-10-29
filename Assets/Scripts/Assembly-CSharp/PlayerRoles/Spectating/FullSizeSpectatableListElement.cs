using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Spectating
{
	public class FullSizeSpectatableListElement : SpectatableListElementBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[SerializeField]
		private Image _mainBackground;

		[SerializeField]
		private TextMeshProUGUI _nicknameText;

		[SerializeField]
		private GameObject _currentIndicator;

		protected override void Update()
		{
			base.Update();
			PlayerRoleBase mainRole = base.Target.MainRole;
			if (mainRole.Pooled)
			{
				return;
			}
			if (_nicknameText != null && mainRole.TryGetOwner(out var hub))
			{
				_nicknameText.text = hub.nicknameSync.DisplayName;
			}
			bool isCurrent = base.IsCurrent;
			_currentIndicator.SetActive(isCurrent);
			_mainBackground.color = (isCurrent ? SpectatableListColors.BgSelected : SpectatableListColors.BgRegular);
		}
	}
}
