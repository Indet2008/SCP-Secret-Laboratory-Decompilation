using RemoteAdmin;
using TMPro;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchUIController : MonoBehaviour
	{
		[SerializeField]
		private SubmenuSelector _submenuSelector;

		[SerializeField]
		private GameObject _uiObject;

		[SerializeField]
		private GameObject _playerInfoRootObject;

		[SerializeField]
		private GameObject _hitRegRootObject;

		[SerializeField]
		private TextMeshProUGUI _playerInfoText;

		public static OverwatchUIController Instance { get; private set; }

		public void SetRootVisibility(bool visible)
		{
			_uiObject.SetActive(visible);
		}

		public void SetPlayerInfoVisibility(bool visible)
		{
			_playerInfoRootObject.SetActive(visible);
		}

		public void SetHitregInfoVisibility(bool visible)
		{
			_hitRegRootObject.SetActive(visible);
		}

		public void SetPlayerInfoText(string text)
		{
			_playerInfoText.SetText(text);
		}

		private void Awake()
		{
			Instance = this;
			SetPlayerInfoVisibility(OverwatchSettingsController.PlayerInfoEnabled);
			SetHitregInfoVisibility(OverwatchSettingsController.HitregInfoLogEnabled);
		}

		private void OnDisable()
		{
			Instance = null;
		}
	}
}
