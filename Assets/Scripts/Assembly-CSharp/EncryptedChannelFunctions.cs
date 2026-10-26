using Mirror;

internal static class EncryptedChannelFunctions
{
	internal static void SerializeEncryptedMessageOutside(this NetworkWriter writer, EncryptedChannelManager.EncryptedMessageOutside value)
	{
		writer.WriteByte((byte)value.Level);
		writer.WriteArray(value.Data);
	}

	internal static EncryptedChannelManager.EncryptedMessageOutside DeserializeEncryptedMessageOutside(this NetworkReader reader)
	{
		return new EncryptedChannelManager.EncryptedMessageOutside((EncryptedChannelManager.SecurityLevel)reader.ReadByte(), reader.ReadArray<byte>());
	}
}
