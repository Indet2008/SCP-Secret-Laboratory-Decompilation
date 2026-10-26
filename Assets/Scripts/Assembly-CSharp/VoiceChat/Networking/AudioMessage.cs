using Mirror;

namespace VoiceChat.Networking
{
	public struct AudioMessage : NetworkMessage
	{
		public byte ControllerId;

		public int DataLength;

		public byte[] Data;

		public AudioMessage(byte controllerId, byte[] data, int dataLen)
		{
			ControllerId = controllerId;
			Data = data;
			DataLength = dataLen;
		}
	}
}
