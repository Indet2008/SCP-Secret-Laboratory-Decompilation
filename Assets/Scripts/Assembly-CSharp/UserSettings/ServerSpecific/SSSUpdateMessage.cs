using System;
using System.Collections.Generic;
using Mirror;
using NorthwoodLib.Pools;

namespace UserSettings.ServerSpecific
{
	public readonly struct SSSUpdateMessage : NetworkMessage
	{
		public readonly int Id;

		public readonly byte TypeCode;

		public readonly List<byte> DeserializedPooledPayload;

		public readonly Action<NetworkWriter> ServersidePayloadWriter;

		public SSSUpdateMessage(NetworkReader reader)
		{
			Id = reader.ReadInt();
			TypeCode = reader.ReadByte();
			int count = reader.ReadInt();
			DeserializedPooledPayload = ListPool<byte>.Shared.Rent(reader.ReadBytesSegment(count));
			ServersidePayloadWriter = null;
		}

		public SSSUpdateMessage(ServerSpecificSettingBase setting, Action<NetworkWriter> writerFunc)
		{
			Id = setting.SettingId;
			TypeCode = ServerSpecificSettingsSync.GetCodeFromType(setting.GetType());
			DeserializedPooledPayload = null;
			ServersidePayloadWriter = writerFunc;
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteInt(Id);
			writer.WriteByte(TypeCode);
			using NetworkWriterPooled networkWriterPooled = NetworkWriterPool.Get();
			ServersidePayloadWriter?.Invoke(networkWriterPooled);
			writer.WriteArraySegment(networkWriterPooled.ToArraySegment());
		}
	}
}
