using System;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.Spectating
{
	public static class SpectatorNetworking
	{
		public struct SpectatedNetIdSyncMessage : NetworkMessage
		{
			public uint NetId;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkServer.ReplaceHandler((NetworkConnectionToClient conn, SpectatedNetIdSyncMessage msg) =>
				{
					if (ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub) && hub.roleManager.CurrentRole is SpectatorRole spectatorRole)
					{
						ReferenceHub.TryGetHubNetID(spectatorRole.SyncedSpectatedNetId, out var hub2);
						ReferenceHub.TryGetHubNetID(msg.NetId, out var hub3);
						if (hub3 == null || !(hub3.roleManager.CurrentRole is ISpectatableRole spectatableRole) || spectatableRole.SpectatorModule.IsSpectatingAllowed || hub.roleManager.CurrentRole.RoleTypeId == RoleTypeId.Overwatch)
						{
							spectatorRole.SyncedSpectatedNetId = msg.NetId;
							PlayerEvents.OnChangedSpectator(new PlayerChangedSpectatorEventArgs(hub, hub2, hub3));
						}
					}
				});
			};
			SpectatorTargetTracker.OnTargetChanged += () =>
			{
				if (NetworkClient.isConnected)
				{
					NetworkClient.Send(new SpectatedNetIdSyncMessage
					{
						NetId = (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub) ? hub.netId : 0u)
					});
				}
			};
		}

		public static void SendToSpectatorsOf<T>(this T msg, ReferenceHub target, bool includeTarget = false) where T : struct, NetworkMessage
		{
			msg.SendToHubsConditionally((ReferenceHub x) => target.IsSpectatedBy(x) || (includeTarget && x == target));
		}

		public static void ForeachSpectatorOf(ReferenceHub target, Action<ReferenceHub> action)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (target.IsSpectatedBy(allHub))
				{
					action(allHub);
				}
			}
		}

		public static bool IsSpectatedBy(this ReferenceHub target, ReferenceHub spectator)
		{
			if (spectator.roleManager.CurrentRole is SpectatorRole spectatorRole)
			{
				return spectatorRole.SyncedSpectatedNetId == target.netId;
			}
			return false;
		}

		public static bool IsLocallySpectated(this ReferenceHub target)
		{
			if (SpectatorTargetTracker.TryGetTrackedPlayer(out var hub))
			{
				return hub == target;
			}
			return false;
		}
	}
}
