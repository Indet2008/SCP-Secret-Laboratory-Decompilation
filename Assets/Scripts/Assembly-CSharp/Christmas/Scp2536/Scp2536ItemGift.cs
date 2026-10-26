using System.Collections.Generic;
using System.Linq;
using InventorySystem;
using InventorySystem.Items;
using UnityEngine;

namespace Christmas.Scp2536
{
	public abstract class Scp2536ItemGift : Scp2536GiftBase
	{
		private readonly float _chanceSum;

		protected abstract Scp2536Reward[] Rewards { get; }

		protected Scp2536ItemGift()
		{
			_chanceSum = Rewards.Sum((Scp2536Reward r) => r.Weight);
		}

		protected void GrantAllRewards(ReferenceHub hub)
		{
			Scp2536Reward[] rewards = Rewards;
			for (int i = 0; i < rewards.Length; i++)
			{
				ItemType reward = rewards[i].Reward;
				Dictionary<ushort, ItemBase> items = hub.inventory.UserInventory.Items;
				if (items.Count >= 8)
				{
					hub.inventory.ServerDropItem(items.ElementAt(items.Count - 1).Key);
				}
				hub.inventory.ServerAddItem(reward, ItemAddReason.Scp2536, 0).GrantAmmoReward();
			}
		}

		protected ItemType GenerateRandomReward()
		{
			float num = Random.Range(0f, _chanceSum);
			ItemType result = ItemType.Coin;
			Scp2536Reward[] rewards = Rewards;
			for (int i = 0; i < rewards.Length; i++)
			{
				Scp2536Reward scp2536Reward = rewards[i];
				result = scp2536Reward.Reward;
				num -= scp2536Reward.Weight;
				if (num <= 0f)
				{
					return result;
				}
			}
			return result;
		}
	}
}
