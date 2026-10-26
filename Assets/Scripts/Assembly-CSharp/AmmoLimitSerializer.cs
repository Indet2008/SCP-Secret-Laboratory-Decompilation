using Mirror;

public static class AmmoLimitSerializer
{
	public static void WriteAmmoLimit(this NetworkWriter writer, ServerConfigSynchronizer.AmmoLimit value)
	{
		writer.WriteByte((byte)value.AmmoType);
		writer.WriteUShort(value.Limit);
	}

	public static ServerConfigSynchronizer.AmmoLimit ReadAmmoLimit(this NetworkReader reader)
	{
		return new ServerConfigSynchronizer.AmmoLimit
		{
			AmmoType = (ItemType)reader.ReadByte(),
			Limit = reader.ReadUShort()
		};
	}
}
