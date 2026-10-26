using System;
using Hints;
using InventorySystem.Configs;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using UnityEngine;

namespace InventorySystem.Searching
{
	public class ItemSearchCompletor : PickupSearchCompletor
	{
		private readonly ItemCategory _category;

		private readonly bool _countsTowardsCategoryLimit;

		private sbyte CategoryCount
		{
			get
			{
				sbyte b = 0;
				foreach (ItemBase value in base.Hub.inventory.UserInventory.Items.Values)
				{
					if (value.CountsTowardsCategoryLimit && value.Category == _category)
					{
						b++;
					}
				}
				return b;
			}
		}

		public ItemSearchCompletor(ReferenceHub hub, ItemPickupBase targetPickup, ItemBase targetItem, double maxDistanceSquared)
			: base(hub, targetPickup, maxDistanceSquared)
		{
			_category = targetItem.Category;
			_countsTowardsCategoryLimit = targetItem.CountsTowardsCategoryLimit;
		}

		protected override bool ValidateAny()
		{
			if (!base.ValidateAny())
			{
				return false;
			}
			if (base.Hub.inventory.UserInventory.Items.Count >= 8)
			{
				base.Hub.hints.Show(new TranslationHint(HintTranslations.MaxItemsAlreadyReached, new HintParameter[1]
				{
					new ByteHintParameter(8)
				}, new HintEffect[1] { HintEffectPresets.TrailingPulseAlpha(0.5f, 1f, 0.5f, 2f, 0f, 3) }, 2f));
				return false;
			}
			if (_category != ItemCategory.None)
			{
				int num = Mathf.Abs(InventoryLimits.GetCategoryLimit(_category, base.Hub));
				if (CategoryCount >= num)
				{
					base.Hub.hints.Show(new TranslationHint(HintTranslations.MaxItemCategoryAlreadyReached, new HintParameter[2]
					{
						new ItemCategoryHintParameter(_category),
						new ByteHintParameter((byte)num)
					}, new HintEffect[1] { HintEffectPresets.TrailingPulseAlpha(0.5f, 1f, 0.5f, 2f, 0f, 2) }, 2f));
					return false;
				}
			}
			return true;
		}

		public override bool ValidateStart()
		{
			if (!base.ValidateStart())
			{
				return false;
			}
			if (TargetItemType == ItemType.None)
			{
				throw new InvalidOperationException("Item has an invalid ItemType.");
			}
			if (_category == ItemCategory.Ammo)
			{
				throw new InvalidOperationException("Item is not equippable (can be held in inventory).");
			}
			return true;
		}

		public override void Complete()
		{
			base.Complete();
			PlayerPickingUpItemEventArgs e = new PlayerPickingUpItemEventArgs(base.Hub, TargetPickup);
			PlayerEvents.OnPickingUpItem(e);
			if (!e.IsAllowed)
			{
				ItemPickupBase targetPickup = TargetPickup;
				PickupSyncInfo info = TargetPickup.Info;
				info.InUse = false;
				targetPickup.NetworkInfo = info;
			}
			else
			{
				ItemBase item = base.Hub.inventory.ServerAddItem(TargetPickup.Info.ItemId, ItemAddReason.PickedUp, TargetPickup.Info.Serial, TargetPickup);
				TargetPickup.DestroySelf();
				CheckCategoryLimitHint();
				PlayerEvents.OnPickedUpItem(new PlayerPickedUpItemEventArgs(base.Hub, item));
			}
		}

		protected void CheckCategoryLimitHint()
		{
			sbyte categoryLimit = InventoryLimits.GetCategoryLimit(_category, base.Hub);
			if (_category != ItemCategory.None && categoryLimit >= 0 && CategoryCount >= categoryLimit && _countsTowardsCategoryLimit)
			{
				HintEffect[] effects = HintEffectPresets.FadeInAndOut(0.25f);
				HintParameter[] parameters = new HintParameter[2]
				{
					new ItemCategoryHintParameter(_category),
					new ByteHintParameter((byte)categoryLimit)
				};
				base.Hub.hints.Show(new TranslationHint(HintTranslations.MaxItemCategoryReached, parameters, effects, 1.5f));
			}
		}
	}
}
