namespace InventorySystem.Items.Firearms.Modules
{
	public interface IDisplayableAmmoProviderModule
	{
		DisplayAmmoValues PredictedDisplayAmmo { get; }

		DisplayAmmoValues GetDisplayAmmoForSerial(ushort serial);

		static DisplayAmmoValues GetCombinedDisplayAmmo(Firearm firearm)
		{
			int num = 0;
			int num2 = 0;
			ModuleBase[] modules = firearm.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is IDisplayableAmmoProviderModule { PredictedDisplayAmmo: var predictedDisplayAmmo })
				{
					num += predictedDisplayAmmo.Magazines;
					num2 += predictedDisplayAmmo.Chambered;
				}
			}
			return new DisplayAmmoValues(num, num2);
		}

		static DisplayAmmoValues GetCombinedDisplayAmmo(ItemIdentifier id)
		{
			if (!InventoryItemLoader.TryGetItem<Firearm>(id.TypeId, out var result))
			{
				return default;
			}
			ushort serialNumber = id.SerialNumber;
			int num = 0;
			int num2 = 0;
			ModuleBase[] modules = result.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is IDisplayableAmmoProviderModule displayableAmmoProviderModule)
				{
					DisplayAmmoValues displayAmmoForSerial = displayableAmmoProviderModule.GetDisplayAmmoForSerial(serialNumber);
					num += displayAmmoForSerial.Magazines;
					num2 += displayAmmoForSerial.Chambered;
				}
			}
			return new DisplayAmmoValues(num, num2);
		}
	}
}
