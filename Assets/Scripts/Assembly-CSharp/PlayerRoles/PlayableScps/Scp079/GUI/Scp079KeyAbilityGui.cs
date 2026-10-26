using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079KeyAbilityGui : Scp079GuiElementBase
	{
		[SerializeField]
		private Image _background;

		[SerializeField]
		private Color _unavailableColor;

		[SerializeField]
		private Color _readyColor;

		[SerializeField]
		private TextMeshProUGUI _description;

		[SerializeField]
		private TextMeshProUGUI _keyText;

		[SerializeField]
		private GameObject _lmbObj;

		[SerializeField]
		private GameObject _rmbObj;

		[SerializeField]
		private RectTransform _rescaleTransform;

		[SerializeField]
		private Vector3 _rescaleParams;

		private KeyCode _prevKeycode;

		internal void Setup(bool isReady, string description, ActionName key, bool createSpace)
		{
			float y = (createSpace ? _rescaleParams.x : _rescaleParams.y);
			_rescaleTransform.sizeDelta = new Vector2(_rescaleParams.z, y);
			base.gameObject.SetActive(value: true);
			SetupKeycode(NewInput.GetKey(key));
			Color color = (isReady ? _readyColor : _unavailableColor);
			_description.text = description;
			_description.color = color;
			_background.color = color;
		}

		private void SetupKeycode(KeyCode keycode)
		{
			if (keycode != _prevKeycode)
			{
				bool flag = keycode == KeyCode.Mouse0;
				bool flag2 = keycode == KeyCode.Mouse1;
				_prevKeycode = keycode;
				_lmbObj.SetActive(flag);
				_rmbObj.SetActive(flag2);
				bool flag3 = flag | flag2;
				_keyText.gameObject.SetActive(!flag3);
				if (!flag3)
				{
					_keyText.text = new ReadableKeyCode(keycode).ShortVersion;
				}
			}
		}
	}
}
