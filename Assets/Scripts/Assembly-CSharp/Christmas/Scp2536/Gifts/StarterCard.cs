using System.Collections.Generic;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Keycards;
using Utils.NonAllocLINQ;

namespace Christmas.Scp2536.Gifts
{
	public class StarterCard : Scp2536ItemGift
	{
		public override UrgencyLevel Urgency => UrgencyLevel.Five;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[2]
		{
			new Scp2536Reward(ItemType.KeycardJanitor, 50f),
			new Scp2536Reward(ItemType.KeycardScientist, 50f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (base.CanBeGranted(hub))
			{
				return !hub.inventory.UserInventory.Items.Any((KeyValuePair<ushort, ItemBase> i) => i.Value is KeycardItem);
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			ItemType type = GenerateRandomReward();
			hub.inventory.ServerAddItem(type, ItemAddReason.Scp2536, 0).GrantAmmoReward();
		}
	}
}
