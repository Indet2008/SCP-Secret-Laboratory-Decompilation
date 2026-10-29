using System.Collections.Generic;
using UnityEngine;

namespace ToggleableMenus
{
	// Client-only in v14 (the server build ships an empty shell); rebuilt from the v14 client binary.
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
				if (_wasAnyEnabled)
				{
					return !IsNull(_currentMenu);
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
			if (AnyEnabled && (Input.GetKeyDown(KeyCode.Escape) || !_currentMenu.IsEnabled))
			{
				if (_currentMenu is SimpleToggleableMenu simpleToggleableMenu && !simpleToggleableMenu.CanToggle)
				{
					return;
				}
				_currentMenu.IsEnabled = false;
				_currentMenu = null;
			}
			RegisteredMenus.RemoveWhere(IsNull);
			MenusNonAlloc.Clear();
			MenusNonAlloc.AddRange(RegisteredMenus);
			foreach (IRegisterableMenu item in MenusNonAlloc)
			{
				if (item is ToggleableMenuBase toggleableMenuBase)
				{
					if (toggleableMenuBase is IHoldableMenu { IsHoldable: not false })
					{
						HandleHoldableMenu(toggleableMenuBase);
					}
					else
					{
						HandleBaseMenu(toggleableMenuBase);
					}
				}
			}
			_wasAnyEnabled = !IsNull(_currentMenu);
		}

		private static void HandleBaseMenu(ToggleableMenuBase menu)
		{
			if (Input.GetKeyDown(NewInput.GetKey(menu.MenuActionKey)) && menu.CanToggle)
			{
				ToggleMenu(menu);
			}
		}

		private static void HandleHoldableMenu(ToggleableMenuBase menu)
		{
			if (menu.CanToggle)
			{
				KeyCode key = NewInput.GetKey(menu.MenuActionKey);
				if ((!menu.IsEnabled && Input.GetKeyDown(key)) || (menu.IsEnabled && !Input.GetKey(key)))
				{
					ToggleMenu(menu);
				}
			}
		}

		public static void ToggleMenu(IRegisterableMenu menu)
		{
			if (_wasAnyEnabled)
			{
				// While a menu is open, other menus' keys are ignored (e.g. typing into the console).
				if (menu == _currentMenu)
				{
					HideCurrent();
				}
			}
			else if (!IsNull(menu))
			{
				menu.IsEnabled = true;
				_wasAnyEnabled = true;
				_currentMenu = menu;
			}
		}

		public static void ForceCurrent(IRegisterableMenu menu)
		{
			if (_wasAnyEnabled && _currentMenu != menu && !IsNull(_currentMenu))
			{
				_currentMenu.IsEnabled = false;
			}
			if (!IsNull(menu))
			{
				menu.IsEnabled = true;
				_wasAnyEnabled = true;
				_currentMenu = menu;
			}
		}

		public static void HideCurrent()
		{
			if (AnyEnabled)
			{
				_currentMenu.IsEnabled = false;
				_currentMenu = null;
				_wasAnyEnabled = false;
			}
		}
	}
}
