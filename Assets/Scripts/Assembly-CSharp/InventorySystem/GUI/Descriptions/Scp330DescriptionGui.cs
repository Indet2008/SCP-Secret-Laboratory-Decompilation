using System.Collections.Generic;
using InventorySystem.Items;
using InventorySystem.Items.Usables.Scp330;
using TMPro;
using UnityEngine;

namespace InventorySystem.GUI.Descriptions
{
	public class Scp330DescriptionGui : RadialDescriptionBase
	{
		[SerializeField]
		private TextMeshProUGUI _title;

		[SerializeField]
		private TextMeshProUGUI _desc;

		[SerializeField]
		private TextMeshProUGUI _candies;

		public override void UpdateInfo(ItemBase targetItem, Color roleColor)
		{
			if (!(targetItem is Scp330Bag scp330Bag))
			{
				return;
			}
			_title.text = scp330Bag.Name;
			_desc.text = scp330Bag.Description;
			_candies.text = string.Empty;
			_candies.color = roleColor;
			Dictionary<CandyKindID, int> dictionary = new Dictionary<CandyKindID, int>();
			foreach (CandyKindID candy in scp330Bag.Candies)
			{
				if (!dictionary.TryGetValue(candy, out var value))
				{
					value = 0;
				}
				value = (dictionary[candy] = value + 1);
			}
			foreach (CandyKindID candy2 in scp330Bag.Candies)
			{
				if (dictionary.TryGetValue(candy2, out var value2))
				{
					Scp330Translations.GetCandyTranslation(candy2, out var text, out var _, out var _);
					dictionary.Remove(candy2);
					string text2 = text;
					if (value2 > 1)
					{
						text2 = text2 + " (<color=white>" + value2 + "x</color>)";
					}
					TextMeshProUGUI candies = _candies;
					candies.text = candies.text + text2 + "\n";
				}
			}
			_title.text = scp330Bag.Name;
			_desc.text = scp330Bag.Description;
		}
	}
}
