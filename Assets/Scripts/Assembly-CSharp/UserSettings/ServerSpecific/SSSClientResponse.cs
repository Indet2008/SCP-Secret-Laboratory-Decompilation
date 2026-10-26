using System;
using Mirror;

namespace UserSettings.ServerSpecific
{
	public readonly struct SSSClientResponse : NetworkMessage
	{
		public readonly Type SettingType;

		public readonly int Id;

		public readonly byte[] Payload;

		public SSSClientResponse(NetworkReader reader)
		{
			SettingType = ServerSpecificSettingsSync.GetTypeFromCode(reader.ReadByte());
			Id = reader.ReadInt();
			int count = reader.ReadInt();
			Payload = reader.ReadBytes(count);
		}

		public SSSClientResponse(ServerSpecificSettingBase modifiedSetting)
		{
			SettingType = modifiedSetting.GetType();
			Id = modifiedSetting.SettingId;
			using NetworkWriterPooled networkWriterPooled = NetworkWriterPool.Get();
			modifiedSetting.SerializeValue(networkWriterPooled);
			Payload = networkWriterPooled.ToArray();
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteByte(ServerSpecificSettingsSync.GetCodeFromType(SettingType));
			writer.WriteInt(Id);
			writer.WriteInt(Payload.Length);
			writer.WriteBytes(Payload, 0, Payload.Length);
		}
	}
}
