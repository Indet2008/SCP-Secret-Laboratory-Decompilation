using System.Text;
using InventorySystem.Configs;
using InventorySystem.Items;
using InventorySystem.Items.Armor;
using NorthwoodLib.Pools;
using TMPro;
using UnityEngine;

namespace InventorySystem.GUI.Descriptions
{
	public class ArmorDescriptionGui : RadialDescriptionBase
	{
		[SerializeField]
		private TextMeshProUGUI _title;

		[SerializeField]
		private TextMeshProUGUI _itemLimits;

		[SerializeField]
		private TextMeshProUGUI _ammoLimits;

		[SerializeField]
		private FirearmDescriptionGui.FirearmStatBar _helmetBar;

		[SerializeField]
		private FirearmDescriptionGui.FirearmStatBar _vestBar;

		[SerializeField]
		private FirearmDescriptionGui.FirearmStatBar _staminaBar;

		[SerializeField]
		private FirearmDescriptionGui.FirearmStatBar _movementBar;

		public override void UpdateInfo(ItemBase targetItem, Color roleColor)
		{
			_title.text = ((targetItem is IItemNametag itemNametag) ? itemNametag.Name : targetItem.ItemTypeId.ToString());
			_itemLimits.color = roleColor;
			_ammoLimits.color = roleColor;
			if (!(targetItem is BodyArmor bodyArmor))
			{
				return;
			}
			_helmetBar.SetValue((float)bodyArmor.HelmetEfficacy / 100f, bodyArmor.HelmetEfficacy + "%", roleColor);
			_vestBar.SetValue((float)bodyArmor.VestEfficacy / 100f, bodyArmor.VestEfficacy + "%", roleColor);
			float staminaUsageMultiplier = bodyArmor.StaminaUsageMultiplier;
			float movementSpeedMultiplier = bodyArmor.MovementSpeedMultiplier;
			_staminaBar.SetValue(staminaUsageMultiplier - 1f, "+" + Mathf.Round((staminaUsageMultiplier - 1f) * 100f) + "%", roleColor);
			_movementBar.SetValue(movementSpeedMultiplier, "-" + Mathf.Round((1f - movementSpeedMultiplier) * 100f) + "%", roleColor);
			string totalWord = TranslationReader.Get("InventoryGUI", 14, "total");
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			if (TranslationReader.TryGet("InventoryGUI", 12, out var val))
			{
				stringBuilder.Append("<size=11><color=white>");
				stringBuilder.Append(val);
				stringBuilder.Append("</color></size>");
				BodyArmor.ArmorCategoryLimitModifier[] categoryLimits = bodyArmor.CategoryLimits;
				for (int i = 0; i < categoryLimits.Length; i++)
				{
					BodyArmor.ArmorCategoryLimitModifier armorCategoryLimitModifier = categoryLimits[i];
					string label = TranslationReader.Get("Categories", (int)armorCategoryLimitModifier.Category, armorCategoryLimitModifier.Category.ToString());
					AddRecord(stringBuilder, armorCategoryLimitModifier.Limit, label, InventoryLimits.GetCategoryLimit(bodyArmor, armorCategoryLimitModifier.Category), totalWord);
				}
			}
			StringBuilder stringBuilder2 = StringBuilderPool.Shared.Rent();
			if (TranslationReader.TryGet("InventoryGUI", 13, out var val2))
			{
				stringBuilder2.Append("<size=11><color=white>");
				stringBuilder2.Append(val2);
				stringBuilder2.Append("</color></size>");
				BodyArmor.ArmorAmmoLimit[] ammoLimits = bodyArmor.AmmoLimits;
				for (int i = 0; i < ammoLimits.Length; i++)
				{
					BodyArmor.ArmorAmmoLimit armorAmmoLimit = ammoLimits[i];
					if (InventoryItemLoader.AvailableItems.TryGetValue(armorAmmoLimit.AmmoType, out var value) && value is IItemNametag itemNametag2)
					{
						AddRecord(stringBuilder2, armorAmmoLimit.Limit, itemNametag2.Name, InventoryLimits.GetAmmoLimit(bodyArmor, armorAmmoLimit.AmmoType), totalWord);
					}
				}
			}
			_itemLimits.text = stringBuilder.ToString();
			_ammoLimits.text = stringBuilder2.ToString();
			StringBuilderPool.Shared.Return(stringBuilder);
			StringBuilderPool.Shared.Return(stringBuilder2);
		}

		private void AddRecord(StringBuilder sb, int relativeLimit, string label, int total, string totalWord)
		{
			sb.Append("\n+");
			sb.Append(relativeLimit);
			sb.Append(" <color=white>");
			sb.Append(label);
			sb.Append("</color> (");
			sb.AppendFormat(totalWord, total);
			sb.Append(")");
		}
	}
}
