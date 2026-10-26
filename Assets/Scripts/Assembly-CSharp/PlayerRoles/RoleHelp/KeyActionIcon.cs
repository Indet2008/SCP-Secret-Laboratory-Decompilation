using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.RoleHelp
{
	public class KeyActionIcon : MonoBehaviour
	{
		[SerializeField]
		private ActionName _action;

		[SerializeField]
		private Image _keycodeBg;

		[SerializeField]
		private TMP_Text _keycodeText;

		[SerializeField]
		private TMP_Text _mouseText;

		[SerializeField]
		private GameObject[] _mouseIcons;

		private const KeyCode MouseMin = KeyCode.Mouse0;

		private const KeyCode MouseMax = KeyCode.Mouse6;

		private void Awake()
		{
			Refresh();
			NewInput.OnKeyModified += OnKeyModified;
		}

		private void OnDestroy()
		{
			NewInput.OnKeyModified -= OnKeyModified;
		}

		private void OnKeyModified(ActionName actionName, KeyCode kc)
		{
			if (actionName == _action)
			{
				Refresh(kc);
			}
		}

		private void Refresh()
		{
			Refresh(NewInput.GetKey(_action));
		}

		private void Refresh(KeyCode kc)
		{
			_mouseIcons.ForEach((GameObject x) =>
			{
				x.SetActive(value: false);
			});
			if (kc >= KeyCode.Mouse0 && kc <= KeyCode.Mouse6)
			{
				HandleMouse((int)(kc - 323));
			}
			else
			{
				HandleKeycode(new ReadableKeyCode(kc));
			}
		}

		private void HandleMouse(int buttonId)
		{
			_keycodeText.text = string.Empty;
			_mouseText.text = buttonId.ToString();
			int b = _mouseIcons.Length - 1;
			int num = Mathf.Min(buttonId, b);
			_mouseIcons[num].SetActive(value: true);
			_keycodeBg.enabled = false;
		}

		private void HandleKeycode(ReadableKeyCode rkc)
		{
			_keycodeText.text = rkc.NormalVersion;
			_keycodeBg.enabled = true;
		}
	}
}
