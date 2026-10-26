using System;
using System.Collections.Generic;
using CentralAuth;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using NorthwoodLib.Pools;
using UnityEngine;
using Utils.Networking;

namespace UserSettings.ServerSpecific
{
	public static class ServerSpecificSettingsSync
	{
		public static int Version = 1;

		private static Type[] _allTypes;

		private static byte[] _payloadBufferNonAlloc = new byte[1500];

		private static readonly Dictionary<ReferenceHub, List<ServerSpecificSettingBase>> ReceivedUserSettings = new Dictionary<ReferenceHub, List<ServerSpecificSettingBase>>();

		private static readonly Dictionary<ReferenceHub, SSSUserStatusReport> ReceivedUserStatuses = new Dictionary<ReferenceHub, SSSUserStatusReport>();

		private static readonly Func<ServerSpecificSettingBase>[] AllSettingConstructors = new Func<ServerSpecificSettingBase>[8]
		{
			() => new SSGroupHeader(0, null),
			() => new SSKeybindSetting(0, null),
			() => new SSDropdownSetting(0, null, null),
			() => new SSTwoButtonsSetting(0, null, null, null),
			() => new SSSliderSetting(0, null, 0f, 0f),
			() => new SSPlaintextSetting(0, null),
			() => new SSButton(0, null, null),
			() => new SSTextArea(0, null)
		};

		public static ServerSpecificSettingBase[] DefinedSettings { get; set; }

		public static Predicate<ReferenceHub> SendOnJoinFilter { get; set; }

		public static string CurServerPrefsKey
		{
			get
			{
				string serverIDLastJoined = FavoriteAndHistory.ServerIDLastJoined;
				if (string.IsNullOrEmpty(serverIDLastJoined))
				{
					return LiteNetLib4MirrorNetworkManager.singleton.networkAddress;
				}
				return serverIDLastJoined;
			}
		}

		private static Type[] AllSettingTypes
		{
			get
			{
				if (_allTypes != null)
				{
					return _allTypes;
				}
				_allTypes = new Type[AllSettingConstructors.Length];
				for (int i = 0; i < _allTypes.Length; i++)
				{
					_allTypes[i] = AllSettingConstructors[i]().GetType();
				}
				return _allTypes;
			}
		}

		public static event Action<ReferenceHub, ServerSpecificSettingBase> ServerOnSettingValueReceived;

		public static event Action<ReferenceHub, SSSUserStatusReport> ServerOnStatusReceived;

		public static T GetSettingOfUser<T>(ReferenceHub user, int id) where T : ServerSpecificSettingBase
		{
			if (TryGetSettingOfUser<T>(user, id, out var result))
			{
				return result;
			}
			T val = CreateInstance(typeof(T)) as T;
			val.SetId(id, null);
			val.ApplyDefaultValues();
			ReceivedUserSettings[user].Add(val);
			return val;
		}

		public static bool TryGetSettingOfUser<T>(ReferenceHub user, int id, out T result) where T : ServerSpecificSettingBase
		{
			foreach (ServerSpecificSettingBase item in ReceivedUserSettings.GetOrAddNew(user))
			{
				if (item.SettingId == id && item is T val)
				{
					result = val;
					return true;
				}
			}
			result = null;
			return false;
		}

		public static int GetUserVersion(ReferenceHub user)
		{
			if (!ReceivedUserStatuses.TryGetValue(user, out var value))
			{
				return 0;
			}
			return value.Version;
		}

		public static bool IsTabOpenForUser(ReferenceHub user)
		{
			if (ReceivedUserStatuses.TryGetValue(user, out var value))
			{
				return value.TabOpen;
			}
			return false;
		}

		public static byte GetCodeFromType(Type type)
		{
			int num = AllSettingTypes.IndexOf(type);
			if (num < 0)
			{
				throw new ArgumentException(type.FullName + " is not a supported server-specific setting serializer.", "type");
			}
			return (byte)num;
		}

		public static Type GetTypeFromCode(byte header)
		{
			return AllSettingTypes[header];
		}

		public static void SendToAll()
		{
			if (NetworkServer.active)
			{
				new SSSEntriesPack(DefinedSettings, Version).SendToAuthenticated();
			}
		}

		public static void SendToPlayersConditionally(Func<ReferenceHub, bool> filter)
		{
			if (NetworkServer.active)
			{
				new SSSEntriesPack(DefinedSettings, Version).SendToHubsConditionally(filter);
			}
		}

		public static void SendToPlayer(ReferenceHub hub)
		{
			if (NetworkServer.active)
			{
				hub.connectionToClient.Send(new SSSEntriesPack(DefinedSettings, Version));
			}
		}

		public static void SendToPlayer(ReferenceHub hub, ServerSpecificSettingBase[] collection, int? versionOverride = null)
		{
			if (NetworkServer.active)
			{
				hub.connectionToClient.Send(new SSSEntriesPack(collection, versionOverride ?? Version));
			}
		}

		public static ServerSpecificSettingBase CreateInstance(Type t)
		{
			return AllSettingConstructors[AllSettingTypes.IndexOf(t)]();
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerAuthenticationManager.OnInstanceModeChanged += (ReferenceHub hub, ClientInstanceMode _) =>
			{
				if (SendOnJoinFilter == null || SendOnJoinFilter(hub))
				{
					SendToPlayer(hub);
				}
			};
			CustomNetworkManager.OnClientReady += () =>
			{
				ReceivedUserSettings.Clear();
				ReceivedUserStatuses.Clear();
				NetworkClient.ReplaceHandler<SSSEntriesPack>(ClientProcessPackMsg);
				NetworkClient.ReplaceHandler<SSSUpdateMessage>(ClientProcessUpdateMsg);
				NetworkServer.ReplaceHandler<SSSClientResponse>(ServerProcessClientResponseMsg);
				NetworkServer.ReplaceHandler<SSSUserStatusReport>(ServerProcessClientStatusMsg);
			};
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				if (NetworkServer.active)
				{
					ReceivedUserSettings.Remove(hub);
					ReceivedUserStatuses.Remove(hub);
				}
			};
			StaticUnityMethods.OnUpdate += UpdateDefinedSettings;
		}

		private static void UpdateDefinedSettings()
		{
			try
			{
				if (StaticUnityMethods.IsPlaying)
				{
					DefinedSettings?.ForEach((ServerSpecificSettingBase x) =>
					{
						x.OnUpdate();
					});
				}
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		private static void ClientProcessPackMsg(SSSEntriesPack pack)
		{
		}

		private static void ClientProcessUpdateMsg(SSSUpdateMessage msg)
		{
			Type typeFromCode = GetTypeFromCode(msg.TypeCode);
			List<byte> deserializedPooledPayload = msg.DeserializedPooledPayload;
			ServerSpecificSettingBase[] definedSettings = DefinedSettings;
			foreach (ServerSpecificSettingBase serverSpecificSettingBase in definedSettings)
			{
				if (serverSpecificSettingBase.SettingId == msg.Id && !(serverSpecificSettingBase.GetType() != typeFromCode))
				{
					if (_payloadBufferNonAlloc.Length < deserializedPooledPayload.Count)
					{
						_payloadBufferNonAlloc = new byte[deserializedPooledPayload.Count + _payloadBufferNonAlloc.Length];
					}
					deserializedPooledPayload.CopyTo(_payloadBufferNonAlloc);
					using (NetworkReaderPooled reader = NetworkReaderPool.Get(new ArraySegment<byte>(_payloadBufferNonAlloc, 0, deserializedPooledPayload.Count)))
					{
						serverSpecificSettingBase.DeserializeUpdate(reader);
					}
					break;
				}
			}
			ListPool<byte>.Shared.Return(deserializedPooledPayload);
		}

		private static bool ServerPrevalidateClientResponse(SSSClientResponse msg)
		{
			if (DefinedSettings == null)
			{
				return false;
			}
			ServerSpecificSettingBase[] definedSettings = DefinedSettings;
			foreach (ServerSpecificSettingBase serverSpecificSettingBase in definedSettings)
			{
				if (serverSpecificSettingBase.SettingId == msg.Id && !(serverSpecificSettingBase.GetType() != msg.SettingType))
				{
					return true;
				}
			}
			return false;
		}

		private static void ServerDeserializeClientResponse(ReferenceHub sender, ServerSpecificSettingBase setting, NetworkReaderPooled reader)
		{
			if (setting.ResponseMode != ServerSpecificSettingBase.UserResponseMode.None)
			{
				setting.DeserializeValue(reader);
				ServerOnSettingValueReceived?.Invoke(sender, setting);
			}
			reader.Dispose();
		}

		private static void ServerProcessClientResponseMsg(NetworkConnection conn, SSSClientResponse msg)
		{
			if (!ReferenceHub.TryGetHub(conn, out var hub) || !ServerPrevalidateClientResponse(msg))
			{
				return;
			}
			List<ServerSpecificSettingBase> orAddNew = ReceivedUserSettings.GetOrAddNew(hub);
			NetworkReaderPooled reader = NetworkReaderPool.Get(msg.Payload);
			foreach (ServerSpecificSettingBase item in orAddNew)
			{
				if (item.SettingId == msg.Id && !(item.GetType() != msg.SettingType))
				{
					ServerDeserializeClientResponse(hub, item, reader);
					return;
				}
			}
			ServerSpecificSettingBase serverSpecificSettingBase = CreateInstance(msg.SettingType);
			orAddNew.Add(serverSpecificSettingBase);
			serverSpecificSettingBase.SetId(msg.Id, null);
			serverSpecificSettingBase.ApplyDefaultValues();
			ServerDeserializeClientResponse(hub, serverSpecificSettingBase, reader);
		}

		private static void ServerProcessClientStatusMsg(NetworkConnection conn, SSSUserStatusReport msg)
		{
			if (ReferenceHub.TryGetHub(conn, out var hub))
			{
				ReceivedUserStatuses[hub] = msg;
				ServerOnStatusReceived?.Invoke(hub, msg);
			}
		}
	}
}
