using Mirror;

namespace VoiceChat.Networking
{
	public static class VoiceMessageReadersWriters
	{
		private static readonly byte[] ReceiveArray = new byte[512];

		public static VoiceMessage DeserializeVoiceMessage(this NetworkReader reader)
		{
			int value = reader.ReadRecyclablePlayerId().Value;
			VoiceChatChannel channel = (VoiceChatChannel)reader.ReadByte();
			int num = reader.ReadUShort();
			reader.ReadBytes(ReceiveArray, num);
			if (value == 0 || !ReferenceHub.TryGetHub(value, out var hub))
			{
				return new VoiceMessage(null, channel, ReceiveArray, num, isNull: true);
			}
			return new VoiceMessage(hub, channel, ReceiveArray, num, isNull: false);
		}

		public static void SerializeVoiceMessage(this NetworkWriter writer, VoiceMessage msg)
		{
			writer.WriteRecyclablePlayerId(new RecyclablePlayerId(msg.Speaker));
			writer.WriteByte((byte)msg.Channel);
			writer.WriteUShort((ushort)msg.DataLength);
			writer.WriteBytes(msg.Data, 0, msg.DataLength);
		}
	}
}
