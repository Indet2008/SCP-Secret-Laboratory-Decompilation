using System.Collections.Generic;
using NorthwoodLib.Pools;

namespace Utils.ConfigHandler
{
	public abstract class InheritableConfigRegister : ConfigRegister
	{
		public ConfigRegister ParentConfigRegister { get; protected set; }

		protected InheritableConfigRegister(ConfigRegister parentConfigRegister = null)
		{
			ParentConfigRegister = parentConfigRegister;
		}

		public abstract bool ShouldInheritConfigEntry(ConfigEntry configEntry);

		public abstract void UpdateConfigValueInheritable(ConfigEntry configEntry);

		public override void UpdateConfigValue(ConfigEntry configEntry)
		{
			if (configEntry != null && configEntry.Inherit && ParentConfigRegister != null && ShouldInheritConfigEntry(configEntry))
			{
				ParentConfigRegister.UpdateConfigValue(configEntry);
			}
			else
			{
				UpdateConfigValueInheritable(configEntry);
			}
		}

		public ConfigRegister[] GetConfigRegisterHierarchy(bool highestToLowest = true)
		{
			List<ConfigRegister> list = ListPool<ConfigRegister>.Shared.Rent();
			ConfigRegister configRegister = this;
			while (configRegister != null && !list.Contains(configRegister))
			{
				list.Add(configRegister);
				if (!(configRegister is InheritableConfigRegister inheritableConfigRegister))
				{
					break;
				}
				configRegister = inheritableConfigRegister.ParentConfigRegister;
			}
			if (highestToLowest)
			{
				list.Reverse();
			}
			ConfigRegister[] result = list.ToArray();
			ListPool<ConfigRegister>.Shared.Return(list);
			return result;
		}
	}
}
