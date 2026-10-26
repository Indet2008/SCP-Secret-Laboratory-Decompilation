namespace InventorySystem.Items.Firearms.Modules
{
	public static class ModulesUtils
	{
		public static bool AnyModuleBusy(this Firearm firearm, ModuleBase ignoredModule = null)
		{
			ModuleBase[] modules = firearm.Modules;
			foreach (ModuleBase moduleBase in modules)
			{
				if (moduleBase is IBusyIndicatorModule { IsBusy: not false } && !(ignoredModule == moduleBase))
				{
					return true;
				}
			}
			return false;
		}

		public static int GetTotalStoredAmmo(ItemIdentifier id)
		{
			if (!InventoryItemLoader.TryGetItem<Firearm>(id.TypeId, out var result))
			{
				return 0;
			}
			int num = 0;
			ModuleBase[] modules = result.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is IAmmoContainerModule ammoContainerModule)
				{
					num += ammoContainerModule.GetAmmoStoredForSerial(id.SerialNumber);
				}
			}
			return num;
		}

		public static int GetTotalStoredAmmo(this Firearm firearm)
		{
			firearm.GetAmmoContainerData(out var totalStored, out var _);
			return totalStored;
		}

		public static int GetTotalMaxAmmo(this Firearm firearm)
		{
			firearm.GetAmmoContainerData(out var _, out var totalMax);
			return totalMax;
		}

		public static void GetAmmoContainerData(this Firearm firearm, out int totalStored, out int totalMax)
		{
			totalStored = 0;
			totalMax = 0;
			ModuleBase[] modules = firearm.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is IAmmoContainerModule ammoContainerModule)
				{
					totalStored += ammoContainerModule.AmmoStored;
					totalMax += ammoContainerModule.AmmoMax;
				}
			}
		}

		public static bool TryGetModuleWithId<T>(this Firearm firearm, int id, out T module)
		{
			if (!firearm.TryGetSubcomponentFromId(id, out var subcomponent) || !(subcomponent is T val))
			{
				module = default;
				return false;
			}
			module = val;
			return true;
		}

		public static bool TryGetModule<T>(this Firearm firearm, out T module, bool ignoreSubmodules = true)
		{
			ModuleBase[] modules = firearm.Modules;
			foreach (ModuleBase moduleBase in modules)
			{
				if ((!ignoreSubmodules || !moduleBase.IsSubmodule) && moduleBase is T val)
				{
					module = val;
					return true;
				}
			}
			module = default;
			return false;
		}

		public static bool TryGetModules<T1, T2>(this Firearm firearm, out T1 m1, out T2 m2)
		{
			m1 = default;
			m2 = default;
			bool flag = false;
			bool flag2 = false;
			ModuleBase[] modules = firearm.Modules;
			foreach (ModuleBase moduleBase in modules)
			{
				if (!moduleBase.IsSubmodule)
				{
					if (!flag && moduleBase is T1 val)
					{
						m1 = val;
						flag = true;
					}
					if (!flag2 && moduleBase is T2 val2)
					{
						m2 = val2;
						flag2 = true;
					}
					if (flag & flag2)
					{
						return true;
					}
				}
			}
			return false;
		}

		public static bool TryGetModules<T1, T2, T3>(this Firearm firearm, out T1 m1, out T2 m2, out T3 m3)
		{
			m1 = default;
			m2 = default;
			m3 = default;
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			ModuleBase[] modules = firearm.Modules;
			foreach (ModuleBase moduleBase in modules)
			{
				if (!moduleBase.IsSubmodule)
				{
					if (!flag && moduleBase is T1 val)
					{
						m1 = val;
						flag = true;
					}
					if (!flag2 && moduleBase is T2 val2)
					{
						m2 = val2;
						flag2 = true;
					}
					if (!flag3 && moduleBase is T3 val3)
					{
						m3 = val3;
						flag3 = true;
					}
					if (flag & flag2 & flag3)
					{
						return true;
					}
				}
			}
			return false;
		}

		public static bool TryGetModules<T1, T2, T3, T4>(this Firearm firearm, out T1 m1, out T2 m2, out T3 m3, out T4 m4)
		{
			m1 = default;
			m2 = default;
			m3 = default;
			m4 = default;
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			ModuleBase[] modules = firearm.Modules;
			foreach (ModuleBase moduleBase in modules)
			{
				if (!moduleBase.IsSubmodule)
				{
					if (!flag && moduleBase is T1 val)
					{
						m1 = val;
						flag = true;
					}
					if (!flag2 && moduleBase is T2 val2)
					{
						m2 = val2;
						flag2 = true;
					}
					if (!flag3 && moduleBase is T3 val3)
					{
						m3 = val3;
						flag3 = true;
					}
					if (!flag4 && moduleBase is T4 val4)
					{
						m4 = val4;
						flag4 = true;
					}
					if (flag & flag2 & flag3 & flag4)
					{
						return true;
					}
				}
			}
			return false;
		}

		public static bool TryGetModuleTemplate<T>(ItemType itemType, out T module)
		{
			if (InventoryItemLoader.TryGetItem<Firearm>(itemType, out var result))
			{
				return result.TryGetModule<T>(out module);
			}
			module = default;
			return false;
		}
	}
}
