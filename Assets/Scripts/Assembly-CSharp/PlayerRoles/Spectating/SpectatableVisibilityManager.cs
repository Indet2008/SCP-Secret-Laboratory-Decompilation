using System;
using System.Collections.Generic;
using CentralAuth;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.Spectating
{
	public static class SpectatableVisibilityManager
	{
		public static Action<ReferenceHub, bool> OnVisibilityChanged;

		private static readonly HashSet<ReferenceHub> _forcedHiddenPlayers = new HashSet<ReferenceHub>();

		public static int HiddenPlayersCount
		{
			get
			{
				if (NetworkServer.active)
				{
					return _forcedHiddenPlayers.Count;
				}
				if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole.RoleTypeId == RoleTypeId.Overwatch)
				{
					return 0;
				}
				return _forcedHiddenPlayers.Count;
			}
		}

		public static void SetHidden(ReferenceHub hub, bool hidden)
		{
			if (!hidden)
			{
				_forcedHiddenPlayers.Remove(hub);
			}
			else
			{
				_forcedHiddenPlayers.Add(hub);
			}
			new SpectatableVisibilityMessages.SpectatableVisibilityMessage(hub, hidden).SendToHubsConditionally((ReferenceHub n) => n.authManager.InstanceMode == ClientInstanceMode.ReadyClient);
		}

		public static bool IsHidden(ReferenceHub hub)
		{
			return _forcedHiddenPlayers.Contains(hub);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandler;
			ReferenceHub.OnPlayerAdded += OnPlayerAdded;
			ReferenceHub.OnPlayerRemoved += OnPlayerRemoved;
		}

		private static void RegisterHandler()
		{
			NetworkClient.ReplaceHandler((SpectatableVisibilityMessages.SpectatableVisibilityMessage msg) =>
			{
				if (!(msg.TargetHub == null))
				{
					if (!msg.ForceHidden)
					{
						_forcedHiddenPlayers.Remove(msg.TargetHub);
					}
					else
					{
						_forcedHiddenPlayers.Add(msg.TargetHub);
					}
					OnVisibilityChanged?.Invoke(msg.TargetHub, msg.ForceHidden);
				}
			});
		}

		private static void OnPlayerAdded(ReferenceHub hub)
		{
			if (!NetworkServer.active || hub.isLocalPlayer)
			{
				return;
			}
			foreach (ReferenceHub forcedHiddenPlayer in _forcedHiddenPlayers)
			{
				hub.connectionToClient.Send(new SpectatableVisibilityMessages.SpectatableVisibilityMessage(forcedHiddenPlayer, forceHidden: true));
			}
		}

		private static void OnPlayerRemoved(ReferenceHub hub)
		{
			_forcedHiddenPlayers.Remove(hub);
		}
	}
}
