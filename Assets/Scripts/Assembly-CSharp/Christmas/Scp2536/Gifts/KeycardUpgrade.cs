using System.Collections.Generic;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Keycards;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace Christmas.Scp2536.Gifts
{
	public class KeycardUpgrade : Scp2536GiftBase
	{
		public override UrgencyLevel Urgency => UrgencyLevel.Five;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (base.CanBeGranted(hub))
			{
				return hub.inventory.UserInventory.Items.Any((KeyValuePair<ushort, ItemBase> i) =>
				{
					if (!(i.Value is KeycardItem { ItemTypeId: var itemTypeId }))
					{
						return false;
					}
					return (uint)(itemTypeId - 8) > 3u;
				});
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			KeycardItem keycardItem = null;
			bool flag = false;
			foreach (ItemBase value in hub.inventory.UserInventory.Items.Values)
			{
				if (value is KeycardItem keycardItem2)
				{
					flag = true;
					keycardItem = keycardItem2;
					break;
				}
			}
			if (!flag)
			{
				Debug.LogError("Attempted to grant KeycardUpgrade to a player with no keycards.");
				return;
			}
			ItemType type = UpgradeKeycard(keycardItem.ItemTypeId);
			hub.inventory.ServerRemoveItem(keycardItem.ItemSerial, null);
			hub.inventory.ServerAddItem(type, ItemAddReason.Scp2536, 0).GrantAmmoReward();
		}

		private ItemType GenerateOutcome(params ItemType[] outcomes)
		{
			return outcomes[Random.Range(0, outcomes.Length)];
		}

		public ItemType UpgradeKeycard(ItemType keyId)
		{
			switch (keyId)
			{
			case ItemType.KeycardJanitor:
				return GenerateOutcome(ItemType.KeycardZoneManager, ItemType.KeycardScientist);
			case ItemType.KeycardScientist:
				return ItemType.KeycardResearchCoordinator;
			case ItemType.KeycardResearchCoordinator:
				return ItemType.KeycardFacilityManager;
			case ItemType.KeycardZoneManager:
				return GenerateOutcome(ItemType.KeycardFacilityManager, ItemType.KeycardMTFOperative);
			case ItemType.KeycardGuard:
			case ItemType.KeycardMTFPrivate:
				return ItemType.KeycardMTFOperative;
			case ItemType.KeycardMTFOperative:
				return ItemType.KeycardMTFCaptain;
			case ItemType.KeycardContainmentEngineer:
				return ItemType.KeycardFacilityManager;
			default:
				return ItemType.KeycardChaosInsurgency;
			}
		}
	}
}
