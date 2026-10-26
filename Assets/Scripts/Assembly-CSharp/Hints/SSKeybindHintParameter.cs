using System;
using Mirror;
using UnityEngine;
using UserSettings.ServerSpecific;

namespace Hints
{
	public class SSKeybindHintParameter : FormattablePrimitiveHintParameter<int>
	{
		public const string SettingNotFound = "SERVER SETTING NOT FOUND";

		public const string KeyNotAssigned = "KEY NOT ASSIGNED";

		public const string DefaultKeybindFormat = "[{0}]";

		public static SSKeybindHintParameter FromNetwork(NetworkReader reader)
		{
			SSKeybindHintParameter sSKeybindHintParameter = new SSKeybindHintParameter();
			sSKeybindHintParameter.Deserialize(reader);
			return sSKeybindHintParameter;
		}

		private static string GetAndFormatKeybind(int value, string format)
		{
			ServerSpecificSettingBase[] definedSettings = ServerSpecificSettingsSync.DefinedSettings;
			for (int i = 0; i < definedSettings.Length; i++)
			{
				if (definedSettings[i] is SSKeybindSetting sSKeybindSetting && sSKeybindSetting.SettingId == value)
				{
					if (sSKeybindSetting.AssignedKeyCode == KeyCode.None)
					{
						return string.Format(format, TranslationReader.Get("KeyCodes", 1, "KEY NOT ASSIGNED"));
					}
					string normalVersion = new ReadableKeyCode(sSKeybindSetting.AssignedKeyCode).NormalVersion;
					return string.Format(format, normalVersion);
				}
			}
			return string.Format(format, TranslationReader.Get("KeyCodes", 0, "SERVER SETTING NOT FOUND"));
		}

		protected SSKeybindHintParameter()
			: base((Func<int, string, string>)GetAndFormatKeybind, (Func<NetworkReader, int>)NetworkReaderExtensions.ReadInt, (Action<NetworkWriter, int>)NetworkWriterExtensions.WriteInt)
		{
		}

		public SSKeybindHintParameter(int value, string format)
			: base(value, format, (Func<int, string, string>)GetAndFormatKeybind, (Func<NetworkReader, int>)NetworkReaderExtensions.ReadInt, (Action<NetworkWriter, int>)NetworkWriterExtensions.WriteInt)
		{
		}

		public SSKeybindHintParameter(int value)
			: this(value, "[{0}]")
		{
		}
	}
}
