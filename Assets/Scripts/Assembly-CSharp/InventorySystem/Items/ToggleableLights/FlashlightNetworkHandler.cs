using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.ToggleableLights
{
	public static class FlashlightNetworkHandler
	{
		public readonly struct FlashlightMessage : NetworkMessage
		{
			public readonly ushort Serial;

			public readonly bool NewState;

			public FlashlightMessage(ushort flashlightSerial, bool newState)
			{
				Serial = flashlightSerial;
				NewState = newState;
			}
		}

		private static readonly HashSet<uint> AlreadyRequestedFirstimeSync = new HashSet<uint>();

		public static readonly Dictionary<ushort, bool> ReceivedStatuses = new Dictionary<ushort, bool>();

		public static event Action<FlashlightMessage> OnStatusReceived;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandlers;
			Inventory.OnLocalClientStarted += () =>
			{
				NetworkClient.Send(new FlashlightMessage(0, newState: false));
			};
		}

		private static void RegisterHandlers()
		{
			AlreadyRequestedFirstimeSync.Clear();
			ReceivedStatuses.Clear();
			NetworkClient.ReplaceHandler<FlashlightMessage>(ClientProcessMessage);
			NetworkServer.ReplaceHandler<FlashlightMessage>(ServerProcessMessage);
		}

		private static void ClientProcessMessage(FlashlightMessage msg)
		{
			ReceivedStatuses[msg.Serial] = msg.NewState;
			OnStatusReceived?.Invoke(msg);
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.inventory.UserInventory.Items.TryGetValue(msg.Serial, out var value) && value is ToggleableLightItemBase toggleableLightItemBase)
			{
				toggleableLightItemBase.IsEmittingLight = msg.NewState;
			}
		}

		private static void ServerProcessMessage(NetworkConnection conn, FlashlightMessage msg)
		{
			if (!ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub))
			{
				return;
			}
			if (msg.Serial == 0)
			{
				ServerProcessFirstTimeRequest(conn);
			}
			if (hub.inventory.CurItem.SerialNumber == msg.Serial && hub.inventory.CurInstance is ToggleableLightItemBase toggleableLightItemBase)
			{
				bool newState = msg.NewState;
				PlayerTogglingFlashlightEventArgs e = new PlayerTogglingFlashlightEventArgs(hub, toggleableLightItemBase, newState);
				PlayerEvents.OnTogglingFlashlight(e);
				if (e.IsAllowed)
				{
					newState = (toggleableLightItemBase.IsEmittingLight = e.NewState);
					new FlashlightMessage(msg.Serial, newState).SendToAuthenticated();
					PlayerEvents.OnToggledFlashlight(new PlayerToggledFlashlightEventArgs(hub, toggleableLightItemBase, newState));
				}
			}
		}

		private static void ServerProcessFirstTimeRequest(NetworkConnection conn)
		{
			if (!AlreadyRequestedFirstimeSync.Add(conn.identity.netId))
			{
				return;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.inventory.CurInstance is ToggleableLightItemBase toggleableLightItemBase && !(toggleableLightItemBase == null) && !toggleableLightItemBase.IsEmittingLight)
				{
					conn.Send(new FlashlightMessage(allHub.inventory.CurItem.SerialNumber, newState: false));
				}
			}
		}

		public static void Serialize(this NetworkWriter writer, FlashlightMessage value)
		{
			writer.WriteUShort(value.Serial);
			writer.WriteBool(value.NewState);
		}

		public static FlashlightMessage Deserialize(this NetworkReader reader)
		{
			return new FlashlightMessage(reader.ReadUShort(), reader.ReadBool());
		}
	}
}
