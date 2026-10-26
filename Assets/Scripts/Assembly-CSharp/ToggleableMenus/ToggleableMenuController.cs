using System.Collections.Generic;
using UnityEngine;

namespace ToggleableMenus
{
	// Client-only in v14 (the server build ships an empty shell); ported from the SL 12 CE client,
	// plus hold-to-show handling for IHoldableMenu.
	public static class ToggleableMenuController
	{
		private static IRegisterableMenu _currentMenu;

		private static bool _wasAnyEnabled;

		public static readonly HashSet<IRegisterableMenu> RegisteredMenus = new HashSet<IRegisterableMenu>();

		private static readonly List<IRegisterableMenu> MenusNonAlloc = new List<IRegisterableMenu>();

		public static bool AnyEnabled
		{
			get
			{
				if (!IsNull(_currentMenu))
				{
					return _currentMenu.IsEnabled;
				}
				return false;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnUpdate += Update;
		}

		private static bool IsNull(IRegisterableMenu menu)
		{
			if (menu == null)
			{
				return true;
			}
			if (menu is Object obj)
			{
				return obj == null;
			}
			return false;
		}

		private static void Update()
		{
			if (_wasAnyEnabled && !AnyEnabled)
			{
				_currentMenu = null;
			}
			if (AnyEnabled && Input.GetKeyDown(KeyCode.Escape) && _currentMenu is ToggleableMenuBase current && current.CanToggle)
			{
				HideCurrent();
			}
			RegisteredMenus.RemoveWhere(IsNull);
			MenusNonAlloc.Clear();
			MenusNonAlloc.AddRange(RegisteredMenus);
			foreach (IRegisterableMenu menu in MenusNonAlloc)
			{
				if (menu is ToggleableMenuBase baseMenu)
				{
					if (menu is IHoldableMenu holdable && holdable.IsHoldable)
					{
						HandleHoldableMenu(baseMenu);
					}
					else
					{
						HandleBaseMenu(baseMenu);
					}
				}
			}
			_wasAnyEnabled = AnyEnabled;
		}

		private static void HandleBaseMenu(ToggleableMenuBase menu)
		{
			KeyCode key = NewInput.GetKey(menu.MenuActionKey);
			if (key == KeyCode.None || !Input.GetKeyDown(key) || !menu.CanToggle)
			{
				return;
			}
			ToggleMenu(menu);
		}

		private static void HandleHoldableMenu(ToggleableMenuBase menu)
		{
			KeyCode key = NewInput.GetKey(menu.MenuActionKey);
			if (key == KeyCode.None)
			{
				return;
			}
			if (Input.GetKeyDown(key) && menu.CanToggle && (!AnyEnabled || _currentMenu == menu))
			{
				ForceCurrent(menu);
			}
			else if (!Input.GetKey(key) && _currentMenu == menu && menu.IsEnabled)
			{
				HideCurrent();
			}
		}

		public static void ToggleMenu(IRegisterableMenu menu)
		{
			if (IsNull(menu))
			{
				return;
			}
			if (_currentMenu == menu && menu.IsEnabled)
			{
				HideCurrent();
				return;
			}
			if (AnyEnabled)
			{
				// Another menu is open; only switch if it allows being closed.
				if (_currentMenu is ToggleableMenuBase current && !current.CanToggle)
				{
					return;
				}
			}
			ForceCurrent(menu);
		}

		public static void ForceCurrent(IRegisterableMenu menu)
		{
			if (_currentMenu != menu)
			{
				HideCurrent();
			}
			if (IsNull(menu))
			{
				return;
			}
			_currentMenu = menu;
			menu.IsEnabled = true;
		}

		public static void HideCurrent()
		{
			if (!IsNull(_currentMenu))
			{
				_currentMenu.IsEnabled = false;
			}
			_currentMenu = null;
		}
	}
}
