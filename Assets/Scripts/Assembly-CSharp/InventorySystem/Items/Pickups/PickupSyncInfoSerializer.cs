using Mirror;

namespace InventorySystem.Items.Pickups
{
	public static class PickupSyncInfoSerializer
	{
		public static void WritePickupSyncInfo(this NetworkWriter writer, PickupSyncInfo value)
		{
			writer.WriteSByte((sbyte)value.ItemId);
			writer.WriteUShort(value.Serial);
			writer.WriteFloat(value.WeightKg);
			writer.WriteByte(value.SyncedFlags);
		}

		public static PickupSyncInfo ReadPickupSyncInfo(this NetworkReader reader)
		{
			return new PickupSyncInfo
			{
				ItemId = (ItemType)reader.ReadSByte(),
				Serial = reader.ReadUShort(),
				WeightKg = reader.ReadFloat(),
				SyncedFlags = reader.ReadByte()
			};
		}
	}
}
