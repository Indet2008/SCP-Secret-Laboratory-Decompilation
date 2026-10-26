namespace InventorySystem.Items.Usables
{
	public readonly struct CurrentlyUsedItem
	{
		public static CurrentlyUsedItem None = new CurrentlyUsedItem(null, 0, 0f);

		public readonly UsableItem Item;

		public readonly ushort ItemSerial;

		public readonly float StartTime;

		public CurrentlyUsedItem(UsableItem item, ushort serial, float startTime)
		{
			Item = item;
			ItemSerial = serial;
			StartTime = startTime;
		}
	}
}
