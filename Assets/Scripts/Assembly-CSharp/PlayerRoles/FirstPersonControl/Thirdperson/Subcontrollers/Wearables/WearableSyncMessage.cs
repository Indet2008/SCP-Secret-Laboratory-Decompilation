using System;
using System.Collections.Generic;
using Mirror;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public readonly struct WearableSyncMessage : NetworkMessage
	{
		private const int MaxSyncvarBytes = 128;

		private static readonly Stack<byte[]> PayloadPool = new Stack<byte[]>();

		private static readonly NetworkReader PayloadReader = new NetworkReader(new byte[128]);

		public readonly uint PlayerNetId;

		public readonly WearableElements Flags;

		public readonly byte[] Payload;

		public readonly int PayloadSize;

		public WearableSyncMessage(NetworkReader reader)
		{
			PlayerNetId = reader.ReadUInt();
			Flags = (WearableElements)reader.ReadByte();
			PayloadSize = reader.ReadByte();
			if (PayloadSize > 0)
			{
				if (!PayloadPool.TryPop(out Payload))
				{
					Payload = new byte[128];
				}
				reader.ReadBytes(Payload, PayloadSize);
			}
			else
			{
				Payload = null;
			}
		}

		public WearableSyncMessage(ReferenceHub hub, WearableElements flags, NetworkWriter payloadWriter)
		{
			PlayerNetId = hub.netId;
			Flags = flags;
			PayloadSize = payloadWriter.Position;
			if (PayloadSize > 128)
			{
				throw new InvalidOperationException(string.Format("Unable to create {0} with payload of {1}.", "WearableSyncMessage", PayloadSize));
			}
			if (PayloadSize > 0)
			{
				if (!PayloadPool.TryPop(out Payload))
				{
					Payload = new byte[128];
				}
				Array.Copy(payloadWriter.buffer, Payload, PayloadSize);
			}
			else
			{
				Payload = null;
			}
		}

		public WearableSyncMessage(ReferenceHub hub)
		{
			PlayerNetId = hub.netId;
			Flags = WearableElements.None;
			PayloadSize = 0;
			Payload = null;
		}

		public void Free()
		{
			PayloadPool.Push(Payload);
		}

		public NetworkReader GetPayloadReader()
		{
			if (Payload == null)
			{
				PayloadReader.Position = PayloadReader.Capacity;
			}
			else
			{
				PayloadReader.SetBuffer(new ArraySegment<byte>(Payload, 0, PayloadSize));
			}
			return PayloadReader;
		}

		public void SerializeAndFree(NetworkWriter writer)
		{
			writer.WriteUInt(PlayerNetId);
			writer.WriteByte((byte)Flags);
			writer.WriteByte((byte)PayloadSize);
			if (Payload != null)
			{
				writer.WriteBytes(Payload, 0, PayloadSize);
			}
		}
	}
}
