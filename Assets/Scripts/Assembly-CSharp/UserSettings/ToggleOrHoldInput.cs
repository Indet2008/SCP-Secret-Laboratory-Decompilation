using System;
using UnityEngine;

namespace UserSettings
{
	public class ToggleOrHoldInput
	{
		public enum InputActivationMode
		{
			Toggle = 0,
			Hold = 1
		}

		private readonly ActionName _targetAction;

		private readonly InputActivationMode _mode;

		private readonly CachedUserSetting<bool> _trackedSetting;

		private bool _toggled;

		private bool ToggleMode => _mode switch
		{
			InputActivationMode.Toggle => _trackedSetting.Value, 
			InputActivationMode.Hold => !_trackedSetting.Value, 
			_ => throw new InvalidOperationException(string.Format("Undefined {0} with value of {1} detected for this Toggle/Hold setting.", "InputActivationMode", _mode)), 
		};

		private KeyCode TargetKey => NewInput.GetKey(_targetAction);

		public bool KeyHeld => Input.GetKey(TargetKey);

		public bool KeyDown => Input.GetKeyDown(TargetKey);

		public bool IsActive
		{
			get
			{
				if (ToggleMode)
				{
					if (KeyDown)
					{
						_toggled = !_toggled;
					}
				}
				else
				{
					if (KeyDown)
					{
						_toggled = true;
					}
					if (!KeyHeld)
					{
						_toggled = false;
					}
				}
				return _toggled;
			}
		}

		public void ResetAll()
		{
			_toggled = false;
		}

		public void ResetToggle()
		{
			if (ToggleMode)
			{
				ResetAll();
			}
		}

		public ToggleOrHoldInput(ActionName targetAction, CachedUserSetting<bool> settings, InputActivationMode modeWhenTrue = InputActivationMode.Toggle)
		{
			_targetAction = targetAction;
			_trackedSetting = settings;
			_mode = modeWhenTrue;
		}
	}
}
