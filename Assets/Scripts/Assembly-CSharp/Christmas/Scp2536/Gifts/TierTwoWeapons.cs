using InventorySystem;
using InventorySystem.Configs;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;

namespace Christmas.Scp2536.Gifts
{
	public class TierTwoWeapons : Scp2536ItemGift, ITimeLimitedGift
	{
		public override UrgencyLevel Urgency => UrgencyLevel.Five;

		public float SecondsUntilAvailable => 240f;

		public float SecondsUntilUnavailable => 360f;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[4]
		{
			new Scp2536Reward(ItemType.GunFSP9, 30f),
			new Scp2536Reward(ItemType.GunCrossvec, 45f),
			new Scp2536Reward(ItemType.GunA7, 10f),
			new Scp2536Reward(ItemType.GunRevolver, 15f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			int num = 0;
			foreach (ItemBase value in hub.inventory.UserInventory.Items.Values)
			{
				if (value.CountsTowardsCategoryLimit && value is Firearm)
				{
					num++;
				}
			}
			return num < InventoryLimits.GetCategoryLimit(ItemCategory.Firearm, hub);
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			ItemType type = GenerateRandomReward();
			hub.inventory.ServerAddItem(type, ItemAddReason.Scp2536, 0).GrantAmmoReward();
		}
	}
}
