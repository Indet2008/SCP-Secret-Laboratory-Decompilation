using InventorySystem;
using InventorySystem.Configs;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;

namespace Christmas.Scp2536.Gifts
{
	public class TierOneWeapons : Scp2536ItemGift, ITimeLimitedGift
	{
		public override UrgencyLevel Urgency => UrgencyLevel.Five;

		public float SecondsUntilAvailable => 120f;

		public float SecondsUntilUnavailable => 240f;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[2]
		{
			new Scp2536Reward(ItemType.GunCOM15, 50f),
			new Scp2536Reward(ItemType.GunCOM18, 50f)
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
