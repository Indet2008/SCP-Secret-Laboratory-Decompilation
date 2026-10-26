using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace UserSettings.GUIElements
{
	public class UserSettingsTwoButtons : UserSettingsUIBase<Toggle, bool>, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
	{
		[SerializeField]
		private Image _trueImage;

		[SerializeField]
		private Image _falseImage;

		[SerializeField]
		private RoleAccentColor _inactiveColor;

		[SerializeField]
		private RoleAccentColor _highlightColor;

		[SerializeField]
		private RoleAccentColor _activeColor;

		[SerializeField]
		private float _transitionTime;

		private float _curAnim;

		private bool _isHighlighted;

		protected override UnityEvent<bool> OnValueChangedEvent => base.TargetUI.onValueChanged;

		private void Update()
		{
			UpdateColors(instant: false);
		}

		private void OnEnable()
		{
			UpdateColors(instant: true);
		}

		private void OnDisable()
		{
			_isHighlighted = false;
		}

		protected void UpdateColors(bool instant)
		{
			if ((_transitionTime <= 0f) | instant)
			{
				_curAnim = (base.TargetUI.isOn ? 1 : 0);
			}
			else
			{
				float num = Time.deltaTime / _transitionTime;
				if (base.TargetUI.isOn)
				{
					_curAnim += num;
				}
				else
				{
					_curAnim -= num;
				}
				_curAnim = Mathf.Clamp01(_curAnim);
			}
			RoleAccentColor roleAccentColor = (_isHighlighted ? _highlightColor : _inactiveColor);
			_trueImage.color = Color.Lerp(roleAccentColor.Color, _activeColor.Color, _curAnim);
			_falseImage.color = Color.Lerp(_activeColor.Color, roleAccentColor.Color, _curAnim);
		}

		protected override void SetValueAndTriggerEvent(bool val)
		{
			base.TargetUI.isOn = val;
		}

		protected override void SetValueWithoutNotify(bool val)
		{
			base.TargetUI.SetIsOnWithoutNotify(val);
		}

		public void OnPointerEnter(PointerEventData eventData)
		{
			_isHighlighted = true;
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			_isHighlighted = false;
		}
	}
}
