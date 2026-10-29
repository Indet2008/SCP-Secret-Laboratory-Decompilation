namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerReceivingLoadoutEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::System.Collections.Generic.List<ItemType> Items { get; }

		public global::System.Collections.Generic.Dictionary<ItemType, ushort> Ammo { get; }

		public bool InventoryReset { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerReceivingLoadoutEventArgs(ReferenceHub hub, global::System.Collections.Generic.List<ItemType> items, global::System.Collections.Generic.Dictionary<ItemType, ushort> ammo, bool inventoryReset)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Items = items;
			Ammo = ammo;
			InventoryReset = inventoryReset;
		}

		public void AddItem(ItemType type)
		{
			Items.Add(type);
		}

		public void AddAmmo(ItemType ammoType, ushort ammoAmount)
		{
			if (Ammo.ContainsKey(ammoType))
			{
				Ammo[ammoType] += ammoAmount;
			}
			else
			{
				Ammo.Add(ammoType, ammoAmount);
			}
		}

		public void SetAmmo(ItemType ammoType, ushort ammoAmount)
		{
			if (Ammo.ContainsKey(ammoType))
			{
				Ammo[ammoType] = ammoAmount;
			}
			else
			{
				Ammo.Add(ammoType, ammoAmount);
			}
		}

		public void ClearAmmo()
		{
			Ammo.Clear();
		}

		public void ClearItems()
		{
			Items.Clear();
		}
	}
}
