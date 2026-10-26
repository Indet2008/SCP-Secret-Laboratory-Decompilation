using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace UserSettings.GUIElements
{
	[RequireComponent(typeof(CanvasGroup))]
	public class UserSettingDependency : MonoBehaviour
	{
		[Serializable]
		private class Dependency
		{
			private enum Condition
			{
				EqualsTo = 0,
				LessThan = 1,
				GreaterThan = 2
			}

			private enum SettingType
			{
				Slider = 0,
				Toggle = 1,
				Dropdown = 2
			}

			[SerializeField]
			private Component _targetComponent;

			[SerializeField]
			private Condition _condition;

			[SerializeField]
			private bool _invertCondition;

			[SerializeField]
			private float _valueToCompare;

			private bool _setup;

			private SettingType _type;

			private UserSettingsUIBase<Slider, float> _uiSlider;

			private UserSettingsUIBase<Toggle, bool> _uiToggle;

			private UserSettingsUIBase<TMP_Dropdown, int> _uiDropdown;

			public bool ConditionMet
			{
				get
				{
					if (!_setup)
					{
						Setup();
						_setup = true;
					}
					bool flag = Evaluate();
					bool result = !flag;
					if (!_invertCondition)
					{
						return flag;
					}
					return result;
				}
			}

			private void Setup()
			{
				if (_targetComponent is UserSettingsUIBase<Slider, float> uiSlider)
				{
					_uiSlider = uiSlider;
					_type = SettingType.Slider;
					return;
				}
				if (_targetComponent is UserSettingsUIBase<Toggle, bool> uiToggle)
				{
					_uiToggle = uiToggle;
					_type = SettingType.Toggle;
					return;
				}
				if (_targetComponent is UserSettingsUIBase<TMP_Dropdown, int> uiDropdown)
				{
					_uiDropdown = uiDropdown;
					_type = SettingType.Dropdown;
					return;
				}
				throw new NotImplementedException("Unhandled type for settings dependency: " + _targetComponent.GetType().AssemblyQualifiedName);
			}

			private bool Evaluate()
			{
				float num = _type switch
				{
					SettingType.Slider => _uiSlider.TargetUI.value, 
					SettingType.Toggle => _uiToggle.TargetUI.isOn ? 1 : 0, 
					SettingType.Dropdown => _uiDropdown.TargetUI.value, 
					_ => throw new NotImplementedException($"Unable to parse type '{_type}' as float!"), 
				};
				return _condition switch
				{
					Condition.EqualsTo => num == _valueToCompare, 
					Condition.GreaterThan => num > _valueToCompare, 
					Condition.LessThan => num < _valueToCompare, 
					_ => throw new NotImplementedException($"Unhandled condition '{_condition}'!"), 
				};
			}
		}

		[SerializeField]
		private Dependency[] _dependencies;

		[SerializeField]
		private float _fadeSpeed = 10f;

		[SerializeField]
		private float _minFade = 0.2f;

		private CanvasGroup _fader;

		private bool ShouldBeVisible
		{
			get
			{
				Dependency[] dependencies = _dependencies;
				for (int i = 0; i < dependencies.Length; i++)
				{
					if (!dependencies[i].ConditionMet)
					{
						return false;
					}
				}
				return true;
			}
		}

		private void Awake()
		{
			_fader = GetComponent<CanvasGroup>();
		}

		private void OnEnable()
		{
			_fader.alpha = (ShouldBeVisible ? 1f : _minFade);
		}

		private void Update()
		{
			bool shouldBeVisible = ShouldBeVisible;
			float num = Time.deltaTime * _fadeSpeed;
			float num2 = (shouldBeVisible ? num : (0f - num));
			_fader.blocksRaycasts = shouldBeVisible;
			_fader.alpha = Mathf.Clamp(_fader.alpha + num2, _minFade, 1f);
		}
	}
}
