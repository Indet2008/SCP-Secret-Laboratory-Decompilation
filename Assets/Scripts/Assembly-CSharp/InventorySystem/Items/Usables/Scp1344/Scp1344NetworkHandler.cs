using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.Usables.Scp1344
{
	public static class Scp1344NetworkHandler
	{
		private static readonly HashSet<uint> AlreadySyncedJoinNetIds = new HashSet<uint>();

		private static readonly Dictionary<ushort, Scp1344Status> ReceivedStatuses = new Dictionary<ushort, Scp1344Status>();

		public static event Action<ushort, Scp1344Status> OnStatusChanged;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				AlreadySyncedJoinNetIds.Clear();
				ReceivedStatuses.Clear();
				NetworkClient.ReplaceHandler<Scp1344StatusMessage>(ClientProcessStatusMessage);
				NetworkServer.ReplaceHandler<Scp1344StatusMessage>(ServerProcessStatusMessage);
			};
			Inventory.OnLocalClientStarted += () =>
			{
				NetworkClient.Send(new Scp1344StatusMessage(0, Scp1344Status.Idle));
			};
		}

		public static void ServerSendMessage(Scp1344StatusMessage msg)
		{
			msg.SendToAuthenticated();
			if (!NetworkClient.activeHost)
			{
				ClientProcessStatusMessage(msg);
			}
		}

		public static Scp1344Status GetSavedStatus(ushort serial)
		{
			return ReceivedStatuses.GetValueOrDefault(serial, Scp1344Status.Idle);
		}

		private static void ClientProcessStatusMessage(Scp1344StatusMessage msg)
		{
			OnStatusChanged?.Invoke(msg.Serial, msg.NewState);
			if (msg.NewState == Scp1344Status.Inspecting)
			{
				OnStatusChanged?.Invoke(msg.Serial, Scp1344Status.Idle);
			}
			else
			{
				ReceivedStatuses[msg.Serial] = msg.NewState;
			}
		}

		private static void ServerProcessStatusMessage(NetworkConnection conn, Scp1344StatusMessage msg)
		{
			if (!ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub))
			{
				return;
			}
			switch (msg.NewState)
			{
			case Scp1344Status.Idle:
				if (msg.Serial == 0 && AlreadySyncedJoinNetIds.Add(hub.netId))
				{
					SyncAllInstances(conn);
				}
				break;
			case Scp1344Status.Inspecting:
				TryInspect(hub);
				break;
			}
		}

		private static void TryInspect(ReferenceHub hub)
		{
			if (hub.inventory.CurInstance is Scp1344Item scp1344Item && !(scp1344Item == null) && scp1344Item.AllowInspect)
			{
				PlayerInspectingItemEventArgs e = new PlayerInspectingItemEventArgs(hub, scp1344Item);
				PlayerEvents.OnInspectingItem(e);
				if (e.IsAllowed)
				{
					ServerSendMessage(new Scp1344StatusMessage(scp1344Item.ItemSerial, Scp1344Status.Inspecting));
					PlayerEvents.OnInspectedItem(new PlayerInspectedItemEventArgs(hub, scp1344Item));
				}
			}
		}

		private static void SyncAllInstances(NetworkConnection conn)
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.inventory.CurInstance is Scp1344Item scp1344Item && !(scp1344Item == null) && scp1344Item.Status != Scp1344Status.Idle)
				{
					conn.Send(new Scp1344StatusMessage(scp1344Item.ItemSerial, scp1344Item.Status));
				}
			}
		}
	}
}
