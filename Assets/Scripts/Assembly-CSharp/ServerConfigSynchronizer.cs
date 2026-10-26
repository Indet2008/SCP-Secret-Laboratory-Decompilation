using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Achievements;
using GameCore;
using InventorySystem.Configs;
using Mirror;
using UnityEngine;

public class ServerConfigSynchronizer : NetworkBehaviour
{
	[Flags]
	public enum MainBoolsSettings : byte
	{
		FriendlyFire = 1,
		DisabledAchievements = 2
	}

	[Serializable]
	public struct AmmoLimit
	{
		public ItemType AmmoType;

		public ushort Limit;
	}

	public struct PredefinedBanTemplate
	{
		public int Duration;

		public string FormattedDuration;

		public string Reason;
	}

	public static ServerConfigSynchronizer Singleton;

	public static Action OnRefreshed;

	[SyncVar]
	public byte MainBoolsSync;

	public SyncList<sbyte> CategoryLimits = new SyncList<sbyte>();

	public SyncList<AmmoLimit> AmmoLimitsSync = new SyncList<AmmoLimit>();

	[SyncVar]
	public string ServerName;

	[SyncVar]
	public bool EnableRemoteAdminPredefinedBanTemplates = true;

	[SyncVar]
	public string RemoteAdminExternalPlayerLookupMode = "disabled";

	[SyncVar]
	public string RemoteAdminExternalPlayerLookupURL = "";

	[NonSerialized]
	public string RemoteAdminExternalPlayerLookupToken = string.Empty;

	public readonly SyncList<PredefinedBanTemplate> RemoteAdminPredefinedBanTemplates = new SyncList<PredefinedBanTemplate>();

	private bool _ready;

	public byte NetworkMainBoolsSync
	{
		get
		{
			return MainBoolsSync;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref MainBoolsSync, 1uL, null);
		}
	}

	public string NetworkServerName
	{
		get
		{
			return ServerName;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref ServerName, 2uL, null);
		}
	}

	public bool NetworkEnableRemoteAdminPredefinedBanTemplates
	{
		get
		{
			return EnableRemoteAdminPredefinedBanTemplates;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref EnableRemoteAdminPredefinedBanTemplates, 4uL, null);
		}
	}

	public string NetworkRemoteAdminExternalPlayerLookupMode
	{
		get
		{
			return RemoteAdminExternalPlayerLookupMode;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref RemoteAdminExternalPlayerLookupMode, 8uL, null);
		}
	}

	public string NetworkRemoteAdminExternalPlayerLookupURL
	{
		get
		{
			return RemoteAdminExternalPlayerLookupURL;
		}
		[param: In]
		set
		{
			GeneratedSyncVarSetter(value, ref RemoteAdminExternalPlayerLookupURL, 16uL, null);
		}
	}

	public static void RefreshAllConfigs()
	{
		if (!(Singleton == null))
		{
			Singleton.RefreshMainBools();
			Singleton.RefreshCategoryLimits();
			Singleton.RefreshAmmoLimits();
			Singleton.RefreshRAConfigs();
			OnRefreshed?.Invoke();
		}
	}

	[Server]
	public void RefreshMainBools()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerConfigSynchronizer::RefreshMainBools()' called when server was not active");
		}
		else
		{
			NetworkMainBoolsSync = Misc.BoolsToByte(ServerConsole.FriendlyFire, AchievementManager.AchievementsDisabled);
		}
	}

	[Server]
	public void RefreshRAConfigs()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerConfigSynchronizer::RefreshRAConfigs()' called when server was not active");
			return;
		}
		NetworkEnableRemoteAdminPredefinedBanTemplates = ServerStatic.RolesConfig.GetBool("enable_predefined_ban_templates", def: true);
		NetworkRemoteAdminExternalPlayerLookupMode = ServerStatic.RolesConfig.GetString("external_player_lookup_mode", "disabled").Trim().ToLower();
		NetworkRemoteAdminExternalPlayerLookupURL = ServerStatic.RolesConfig.GetString("external_player_lookup_url");
		RemoteAdminExternalPlayerLookupToken = ServerStatic.RolesConfig.GetString("external_player_lookup_token");
		RemoteAdminPredefinedBanTemplates.Clear();
		if (!EnableRemoteAdminPredefinedBanTemplates)
		{
			return;
		}
		List<string> stringList = ServerStatic.RolesConfig.GetStringList("PredefinedBanTemplates");
		if (stringList != null)
		{
			PredefinedBanTemplate item = default;
			foreach (string item2 in stringList)
			{
				string[] array = YamlConfig.ParseCommaSeparatedString(item2);
				if (array == null)
				{
					continue;
				}
				if (array.Length != 2)
				{
					ServerConsole.AddLog("Invalid ban template in RA Config file! Template: " + item2);
					continue;
				}
				if (!int.TryParse(array[0], out var result) || result < 0)
				{
					ServerConsole.AddLog("Invalid ban template in RA Config file - duration must be a non-negative integer. Ban template name: " + item2);
					continue;
				}
				item.Reason = array[1];
				TimeSpan timeSpan = TimeSpan.FromSeconds(result);
				item.Duration = (int)timeSpan.TotalMinutes;
				int num = timeSpan.Days / 365;
				if (num > 0)
				{
					item.FormattedDuration = $"{num}y";
				}
				else if (timeSpan.Days > 0)
				{
					item.FormattedDuration = $"{timeSpan.Days}d";
				}
				else if (timeSpan.Hours > 0)
				{
					item.FormattedDuration = $"{timeSpan.Hours}h";
				}
				else if (timeSpan.Minutes > 0)
				{
					item.FormattedDuration = $"{timeSpan.Minutes}m";
				}
				else
				{
					item.FormattedDuration = $"{timeSpan.Seconds}s";
				}
				RemoteAdminPredefinedBanTemplates.Add(item);
			}
			if (RemoteAdminPredefinedBanTemplates.Count == 0)
			{
				NetworkEnableRemoteAdminPredefinedBanTemplates = false;
			}
		}
		else
		{
			NetworkEnableRemoteAdminPredefinedBanTemplates = false;
		}
	}

	[Server]
	public void RefreshCategoryLimits()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerConfigSynchronizer::RefreshCategoryLimits()' called when server was not active");
			return;
		}
		CategoryLimits.Clear();
		ItemCategory[] values = EnumUtils<ItemCategory>.Values;
		for (int i = 0; i < values.Length; i++)
		{
			ItemCategory itemCategory = values[i];
			if ((int)itemCategory != i)
			{
				throw new InvalidOperationException($"Item categories (enum type: {typeof(ItemCategory)}) must start at zero and increment by 1.");
			}
			sbyte item;
			if (InventoryLimits.StandardCategoryLimits.TryGetValue(itemCategory, out var value))
			{
				if (value >= 0)
				{
					string key = "limit_category_" + itemCategory.ToString().ToLowerInvariant();
					item = ConfigFile.ServerConfig.GetSByte(key, value);
				}
				else
				{
					item = value;
				}
			}
			else
			{
				item = sbyte.MaxValue;
			}
			CategoryLimits.Add(item);
		}
	}

	[Server]
	public void RefreshAmmoLimits()
	{
		if (!NetworkServer.active)
		{
			Debug.LogWarning("[Server] function 'System.Void ServerConfigSynchronizer::RefreshAmmoLimits()' called when server was not active");
			return;
		}
		if (AmmoLimitsSync.Count > 0)
		{
			AmmoLimitsSync.Clear();
		}
		foreach (KeyValuePair<ItemType, ushort> standardAmmoLimit in InventoryLimits.StandardAmmoLimits)
		{
			ushort uShort = ConfigFile.ServerConfig.GetUShort("limit_" + standardAmmoLimit.Key.ToString().ToLowerInvariant(), standardAmmoLimit.Value);
			AmmoLimitsSync.Add(new AmmoLimit
			{
				AmmoType = standardAmmoLimit.Key,
				Limit = uShort
			});
		}
	}

	private void Awake()
	{
		Singleton = this;
	}

	private void Update()
	{
		if (!_ready)
		{
			ReferenceHub hub;
			if (!NetworkServer.active)
			{
				_ready = true;
			}
			else if (ReferenceHub.TryGetHostHub(out hub))
			{
				_ready = true;
				RefreshAllConfigs();
			}
		}
	}

	public ServerConfigSynchronizer()
	{
		InitSyncObject(CategoryLimits);
		InitSyncObject(AmmoLimitsSync);
		InitSyncObject(RemoteAdminPredefinedBanTemplates);
	}

	public override bool Weaved()
	{
		return true;
	}

	protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
	{
		base.SerializeSyncVars(writer, forceAll);
		if (forceAll)
		{
			NetworkWriterExtensions.WriteByte(writer, MainBoolsSync);
			writer.WriteString(ServerName);
			writer.WriteBool(EnableRemoteAdminPredefinedBanTemplates);
			writer.WriteString(RemoteAdminExternalPlayerLookupMode);
			writer.WriteString(RemoteAdminExternalPlayerLookupURL);
			return;
		}
		writer.WriteULong(base.syncVarDirtyBits);
		if ((base.syncVarDirtyBits & 1L) != 0L)
		{
			NetworkWriterExtensions.WriteByte(writer, MainBoolsSync);
		}
		if ((base.syncVarDirtyBits & 2L) != 0L)
		{
			writer.WriteString(ServerName);
		}
		if ((base.syncVarDirtyBits & 4L) != 0L)
		{
			writer.WriteBool(EnableRemoteAdminPredefinedBanTemplates);
		}
		if ((base.syncVarDirtyBits & 8L) != 0L)
		{
			writer.WriteString(RemoteAdminExternalPlayerLookupMode);
		}
		if ((base.syncVarDirtyBits & 0x10L) != 0L)
		{
			writer.WriteString(RemoteAdminExternalPlayerLookupURL);
		}
	}

	protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
	{
		base.DeserializeSyncVars(reader, initialState);
		if (initialState)
		{
			GeneratedSyncVarDeserialize(ref MainBoolsSync, null, NetworkReaderExtensions.ReadByte(reader));
			GeneratedSyncVarDeserialize(ref ServerName, null, reader.ReadString());
			GeneratedSyncVarDeserialize(ref EnableRemoteAdminPredefinedBanTemplates, null, reader.ReadBool());
			GeneratedSyncVarDeserialize(ref RemoteAdminExternalPlayerLookupMode, null, reader.ReadString());
			GeneratedSyncVarDeserialize(ref RemoteAdminExternalPlayerLookupURL, null, reader.ReadString());
			return;
		}
		long num = (long)reader.ReadULong();
		if ((num & 1L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref MainBoolsSync, null, NetworkReaderExtensions.ReadByte(reader));
		}
		if ((num & 2L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref ServerName, null, reader.ReadString());
		}
		if ((num & 4L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref EnableRemoteAdminPredefinedBanTemplates, null, reader.ReadBool());
		}
		if ((num & 8L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref RemoteAdminExternalPlayerLookupMode, null, reader.ReadString());
		}
		if ((num & 0x10L) != 0L)
		{
			GeneratedSyncVarDeserialize(ref RemoteAdminExternalPlayerLookupURL, null, reader.ReadString());
		}
	}
}
