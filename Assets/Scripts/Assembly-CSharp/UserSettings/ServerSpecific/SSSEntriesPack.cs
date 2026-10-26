using System;
using Mirror;

namespace UserSettings.ServerSpecific
{
	public readonly struct SSSEntriesPack : NetworkMessage
	{
		public readonly ServerSpecificSettingBase[] Settings;

		public readonly int Version;

		public SSSEntriesPack(NetworkReader reader)
		{
			Version = reader.ReadInt();
			Settings = new ServerSpecificSettingBase[reader.ReadByte()];
			for (int i = 0; i < Settings.Length; i++)
			{
				Type typeFromCode = ServerSpecificSettingsSync.GetTypeFromCode(reader.ReadByte());
				ServerSpecificSettingBase serverSpecificSettingBase = ServerSpecificSettingsSync.CreateInstance(typeFromCode) as ServerSpecificSettingBase;
				serverSpecificSettingBase.DeserializeEntry(reader);
				if (serverSpecificSettingBase.IsServerOnly)
				{
					TransferOrApplyDefaultValue(serverSpecificSettingBase, typeFromCode);
				}
				Settings[i] = serverSpecificSettingBase;
			}
		}

		public SSSEntriesPack(ServerSpecificSettingBase[] settings, int version)
		{
			Settings = settings;
			Version = version;
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteInt(Version);
			if (Settings == null)
			{
				writer.WriteByte(0);
				return;
			}
			writer.WriteByte((byte)Settings.Length);
			ServerSpecificSettingBase[] settings = Settings;
			foreach (ServerSpecificSettingBase serverSpecificSettingBase in settings)
			{
				writer.WriteByte(ServerSpecificSettingsSync.GetCodeFromType(serverSpecificSettingBase.GetType()));
				serverSpecificSettingBase.SerializeEntry(writer);
			}
		}

		private static void TransferOrApplyDefaultValue(ServerSpecificSettingBase newSetting, Type settingType)
		{
			bool flag = false;
			if (ServerSpecificSettingsSync.DefinedSettings != null)
			{
				ServerSpecificSettingBase[] definedSettings = ServerSpecificSettingsSync.DefinedSettings;
				foreach (ServerSpecificSettingBase serverSpecificSettingBase in definedSettings)
				{
					if (serverSpecificSettingBase.SettingId == newSetting.SettingId && !(serverSpecificSettingBase.GetType() != settingType))
					{
						serverSpecificSettingBase.TransferValue(newSetting);
						flag = true;
						break;
					}
				}
			}
			if (!flag)
			{
				newSetting.ApplyDefaultValues();
			}
		}
	}
}
