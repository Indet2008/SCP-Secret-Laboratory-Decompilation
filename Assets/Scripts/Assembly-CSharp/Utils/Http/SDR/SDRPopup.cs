using TMPro;
using UnityEngine;

namespace Utils.Http.SDR
{
	public class SDRPopup : MonoBehaviour
	{
		private const int PopupOpenDuration = 10;

		private const int PopupStartValue = 15;

		[SerializeField]
		private GameObject _popupObject;

		[SerializeField]
		private TMP_Text _popupText;

		private float _popupTimer = 15f;

		public static SDRPopup Instance { get; private set; }

		public void Show(int translationIndex = 5)
		{
			_popupText.text = TranslationReader.Get("MenuWarnings", translationIndex, _popupText.text);
			_popupTimer = 0f;
		}

		private void Update()
		{
			_popupTimer += Time.deltaTime;
			if (_popupTimer > 10f && _popupObject.activeSelf)
			{
				_popupObject.SetActive(value: false);
			}
			else if (_popupTimer < 10f && !_popupObject.activeSelf)
			{
				_popupObject.SetActive(value: true);
			}
			if (_popupTimer <= 10f)
			{
				_popupTimer += Time.deltaTime;
			}
		}

		private void Awake()
		{
			Instance = this;
			Object.DontDestroyOnLoad(base.gameObject);
		}
	}
}
