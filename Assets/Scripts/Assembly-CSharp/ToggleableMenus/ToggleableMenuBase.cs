using CursorManagement;
using UnityEngine;

namespace ToggleableMenus
{
	public abstract class ToggleableMenuBase : MonoBehaviour, IRegisterableMenu, ICursorOverride
	{
		private bool _isEnabled;

		public ActionName MenuActionKey;

		public abstract bool CanToggle { get; }

		public virtual CursorOverrideMode CursorOverride
		{
			get
			{
				if (!IsEnabled)
				{
					return CursorOverrideMode.NoOverride;
				}
				return CursorOverrideMode.Free;
			}
		}

		public virtual bool LockMovement => false;

		public virtual bool IsEnabled
		{
			get
			{
				return _isEnabled;
			}
			set
			{
				if (value != _isEnabled)
				{
					_isEnabled = value;
					OnToggled();
				}
			}
		}

		protected abstract void OnToggled();

		protected virtual void Awake()
		{
			// The server build stripped these client registrations (bodies from the SL 12 CE client).
			CursorManager.Register(this);
			ToggleableMenuController.RegisteredMenus.Add(this);
		}

		protected virtual void OnDestroy()
		{
			CursorManager.Unregister(this);
			ToggleableMenuController.RegisteredMenus.Remove(this);
		}
	}
}
