using System;
using InventorySystem.Items.Pickups;
using MapGeneration.Holidays;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class RandomItemGroupSpawnpoint : ItemSpawnpointBase, IDistributorGenerationResolver
	{
		[Serializable]
		public struct ItemGroup
		{
			public ItemPreset[] Items;

			[Range(0f, 100f)]
			public float Chance;
		}

		[Serializable]
		public struct ItemPreset
		{
			public ItemType TargetItem;

			public Transform Position;
		}

		public ItemGroup[] Presets;

		public float TotalWeight
		{
			get
			{
				float num = 0f;
				ItemGroup[] presets = Presets;
				for (int i = 0; i < presets.Length; i++)
				{
					ItemGroup itemGroup = presets[i];
					num += itemGroup.Chance;
				}
				return num;
			}
		}

		public void Generate(ItemDistributor distributor)
		{
			ItemGroup? randomItemPreset = GetRandomItemPreset();
			if (!randomItemPreset.HasValue)
			{
				return;
			}
			ItemPreset[] items = randomItemPreset.Value.Items;
			for (int i = 0; i < items.Length; i++)
			{
				ItemPreset itemPreset = items[i];
				ItemType itemType = itemPreset.TargetItem;
				if (itemType == ItemType.Flashlight && HolidayUtils.IsHolidayActive(HolidayType.Halloween))
				{
					itemType = ItemType.Lantern;
				}
				ItemPickupBase itemPickupBase = ItemDistributor.ServerCreatePickup(itemType, itemPreset.Position);
				if (itemPickupBase != null)
				{
					distributor.ServerRegisterPickup(itemPickupBase, TriggerDoorName);
				}
			}
		}

		public override bool TryGeneratePickup(out ItemPickupBase pickup)
		{
			pickup = null;
			return false;
		}

		public ItemGroup? GetRandomItemPreset()
		{
			if (Presets == null || Presets.Length == 0)
			{
				return null;
			}
			float num = UnityEngine.Random.Range(0f, TotalWeight);
			float num2 = 0f;
			ItemGroup[] presets = Presets;
			for (int i = 0; i < presets.Length; i++)
			{
				ItemGroup value = presets[i];
				num2 += value.Chance;
				if (num <= num2)
				{
					return value;
				}
			}
			return null;
		}
	}
}
