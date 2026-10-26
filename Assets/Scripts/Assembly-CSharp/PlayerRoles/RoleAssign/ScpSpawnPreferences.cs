using System.Collections.Generic;
using Mirror;
using PlayerRoles.PlayableScps;
using UnityEngine;
using UserSettings;
using UserSettings.OtherSettings;

namespace PlayerRoles.RoleAssign
{
	public static class ScpSpawnPreferences
	{
		public readonly struct SpawnPreferences : NetworkMessage
		{
			private readonly byte _count;

			public readonly Dictionary<RoleTypeId, int> Preferences;

			public readonly bool OptOutOfScp;

			public SpawnPreferences(bool autoSetup)
			{
				_count = 0;
				Preferences = new Dictionary<RoleTypeId, int>();
				OptOutOfScp = false;
				if (!autoSetup)
				{
					return;
				}
				OptOutOfScp = UserSetting<bool>.Get(ScpSetting.ScpOptOut, defaultValue: false);
				foreach (KeyValuePair<RoleTypeId, PlayerRoleBase> allRole in PlayerRoleLoader.AllRoles)
				{
					if (allRole.Value is ISpawnableScp)
					{
						Preferences[allRole.Key] = GetPreference(allRole.Key);
						_count++;
					}
				}
			}

			public SpawnPreferences(NetworkReader reader)
			{
				OptOutOfScp = reader.ReadBool();
				_count = reader.ReadByte();
				Preferences = new Dictionary<RoleTypeId, int>(_count);
				for (int i = 0; i < _count; i++)
				{
					RoleTypeId key = reader.ReadRoleType();
					int val = reader.ReadSByte();
					Preferences[key] = ClampPreference(val);
				}
			}

			public void Serialize(NetworkWriter writer)
			{
				writer.WriteBool(OptOutOfScp);
				writer.WriteByte(_count);
				foreach (KeyValuePair<RoleTypeId, int> preference in Preferences)
				{
					writer.WriteRoleType(preference.Key);
					writer.WriteSByte((sbyte)preference.Value);
				}
			}
		}

		public static readonly Dictionary<int, SpawnPreferences> Preferences = new Dictionary<int, SpawnPreferences>();

		public const int MaxPreference = 5;

		private const string PrefsPrefix = "SpawnPreference_Role_";

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				Preferences.Clear();
				NetworkServer.ReplaceHandler<SpawnPreferences>(OnMessageReceived);
				NetworkClient.Send(new SpawnPreferences(autoSetup: true));
				UserSetting<bool>.AddListener(ScpSetting.ScpOptOut, (bool _) =>
				{
					NetworkClient.Send(new SpawnPreferences(autoSetup: true));
				});
			};
		}

		private static int ClampPreference(int val)
		{
			return Mathf.Clamp(val, -5, 5);
		}

		private static void OnMessageReceived(NetworkConnection conn, SpawnPreferences msg)
		{
			Preferences[conn.connectionId] = msg;
		}

		public static int GetPreference(RoleTypeId role)
		{
			int num = (int)role;
			return ClampPreference(PlayerPrefsSl.Get("SpawnPreference_Role_" + num, 0));
		}

		public static void SavePreference(RoleTypeId role, int value)
		{
			int num = (int)role;
			PlayerPrefsSl.Set("SpawnPreference_Role_" + num, value);
			if (NetworkClient.active)
			{
				NetworkClient.Send(new SpawnPreferences(autoSetup: true));
			}
		}

		public static void WriteSpawnPreferences(this NetworkWriter writer, SpawnPreferences msg)
		{
			msg.Serialize(writer);
		}

		public static SpawnPreferences ReadSpawnPreferences(this NetworkReader reader)
		{
			return new SpawnPreferences(reader);
		}
	}
}
