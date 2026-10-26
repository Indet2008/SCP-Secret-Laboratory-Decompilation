using System;

namespace InventorySystem.Items.Firearms.Modules
{
	public interface IReloadUnloadValidatorModule
	{
		public enum Authorization
		{
			Idle = 0,
			Allowed = 1,
			Vetoed = 2
		}

		Authorization ReloadAuthorization { get; }

		Authorization UnloadAuthorization { get; }

		static bool ValidateReload(Firearm firearm)
		{
			if (ValidateAny(firearm, (IReloadUnloadValidatorModule x) => x.ReloadAuthorization))
			{
				return !firearm.PrimaryActionBlocked;
			}
			return false;
		}

		static bool ValidateUnload(Firearm firearm)
		{
			if (ValidateAny(firearm, (IReloadUnloadValidatorModule x) => x.UnloadAuthorization))
			{
				return !firearm.PrimaryActionBlocked;
			}
			return false;
		}

		private static bool ValidateAny(Firearm firearm, Func<IReloadUnloadValidatorModule, Authorization> authorizationFetcher)
		{
			bool result = false;
			ModuleBase[] modules = firearm.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is IReloadUnloadValidatorModule arg)
				{
					switch (authorizationFetcher(arg))
					{
					case Authorization.Allowed:
						result = true;
						break;
					case Authorization.Vetoed:
						return false;
					}
				}
			}
			return result;
		}
	}
}
