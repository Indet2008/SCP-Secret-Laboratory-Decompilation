using InventorySystem.Items;
using UnityEngine;

namespace InventorySystem.GUI.Descriptions
{
	public abstract class RadialDescriptionBase : MonoBehaviour
	{
		public ItemDescriptionType DescriptionType;

		public abstract void UpdateInfo(ItemBase targetItem, Color roleColor);
	}
}
