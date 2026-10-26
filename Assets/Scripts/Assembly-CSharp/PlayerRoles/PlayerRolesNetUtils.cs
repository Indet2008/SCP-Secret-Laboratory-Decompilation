using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace PlayerRoles
{
	public static class PlayerRolesNetUtils
	{
		public static readonly Dictionary<uint, NetworkReader> QueuedRoles = new Dictionary<uint, NetworkReader>();

		public static bool InfoPackAlreadyReceived;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				QueuedRoles.Clear();
				InfoPackAlreadyReceived = NetworkServer.active;
				NetworkClient.ReplaceHandler((RoleSyncInfo rsi) =>
				{
				});
				NetworkClient.ReplaceHandler((RoleSyncInfoPack rsip) =>
				{
					InfoPackAlreadyReceived = true;
				});
			};
			ReferenceHub.OnPlayerAdded += HandleSpawnedPlayer;
		}

		private static void HandleSpawnedPlayer(ReferenceHub hub)
		{
			NetworkReader value;
			if (NetworkServer.active)
			{
				if (!hub.isLocalPlayer)
				{
					hub.connectionToClient.Send(new RoleSyncInfoPack(hub));
				}
			}
			else if (QueuedRoles.TryGetValue(hub.netId, out value))
			{
				hub.roleManager.InitializeNewRole(value.ReadRoleType(), RoleChangeReason.None, RoleSpawnFlags.All, value);
			}
		}

		public static void WriteRoleSyncInfo(this NetworkWriter writer, RoleSyncInfo info)
		{
			info.Write(writer);
		}

		public static RoleSyncInfo ReadRoleSyncInfo(this NetworkReader reader)
		{
			return new RoleSyncInfo(reader);
		}

		public static void WriteRoleSyncInfoPack(this NetworkWriter writer, RoleSyncInfoPack info)
		{
			info.WritePlayers(writer);
		}

		public static RoleSyncInfoPack ReadRoleSyncInfoPack(this NetworkReader reader)
		{
			return new RoleSyncInfoPack(reader);
		}
	}
}
