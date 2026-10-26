using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Modules;

namespace Christmas.Scp2536
{
	public static class Scp2536Utils
	{
		public static void GrantAmmoReward(this ItemBase reward)
		{
			if (!(reward.Owner == null) && reward is Firearm firearm && firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module))
			{
				reward.OwnerInventory.ServerAddAmmo(module.AmmoType, module.AmmoMax);
			}
		}
	}
}
