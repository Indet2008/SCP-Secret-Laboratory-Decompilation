namespace InventorySystem.Items.Firearms.Modules
{
	[UniqueModule]
	public interface IReloaderModule
	{
		bool IsReloading { get; }

		bool IsUnloading { get; }

		bool IsReloadingOrUnloading
		{
			get
			{
				if (!IsReloading)
				{
					return IsUnloading;
				}
				return true;
			}
		}

		bool GetDisplayReloadingOrUnloading(ushort serial);
	}
}
