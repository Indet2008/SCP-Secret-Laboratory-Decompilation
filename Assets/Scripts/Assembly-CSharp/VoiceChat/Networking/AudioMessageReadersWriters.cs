using Mirror;

namespace VoiceChat.Networking
{
	public static class AudioMessageReadersWriters
	{
		private static readonly byte[] ReceiveArray = new byte[512];

		public static AudioMessage DeserializeVoiceMessage(this NetworkReader reader)
		{
			byte controllerId = reader.ReadByte();
			int num = reader.ReadUShort();
			reader.ReadBytes(ReceiveArray, num);
			return new AudioMessage(controllerId, ReceiveArray, num);
		}

		public static void SerializeVoiceMessage(this NetworkWriter writer, AudioMessage msg)
		{
			writer.WriteByte(msg.ControllerId);
			writer.WriteUShort((ushort)msg.DataLength);
			writer.WriteBytes(msg.Data, 0, msg.DataLength);
		}
	}
}
