using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Extensions;
using UnityEngine;

namespace InventorySystem.Searching
{
	public class FirearmSearchCompletor : ItemSearchCompletor
	{
		private readonly Component[] _extensions;

		public FirearmSearchCompletor(ReferenceHub hub, FirearmPickup targetPickup, ItemBase targetItem, double maxDistanceSquared)
			: base(hub, targetPickup, targetItem, maxDistanceSquared)
		{
			_extensions = targetPickup.Worldmodel.Extensions;
		}

		protected override bool ValidateAny()
		{
			if (!base.ValidateAny())
			{
				return false;
			}
			Component[] extensions = _extensions;
			for (int i = 0; i < extensions.Length; i++)
			{
				if (extensions[i] is IPickupLockingExtension { LockPrefab: not false })
				{
					return false;
				}
			}
			return true;
		}
	}
}
