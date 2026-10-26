using System;
using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public static class WearableSync
	{
		private static readonly Dictionary<uint, WearableSyncMessage> Database = new Dictionary<uint, WearableSyncMessage>();

		private static readonly NetworkWriter PayloadWriter = new NetworkWriter();

		public static bool TryGetData(ReferenceHub hub, out WearableSyncMessage data)
		{
			return Database.TryGetValue(hub.netId, out data);
		}

		public static WearableElements GetFlags(ReferenceHub hub)
		{
			if (!TryGetData(hub, out var data))
			{
				return WearableElements.None;
			}
			return data.Flags;
		}

		public static void OverrideWearables(this ReferenceHub hub, WearableElements newWearables)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Unable to set wearables on client!");
			}
			if (!hub.TryGetWearableSubcontroller<WearableSubcontroller>(out var subcontroller) || newWearables == WearableElements.None)
			{
				WearableSyncMessage wearableSyncMessage = new WearableSyncMessage(hub);
				UpdateDatabaseEntry(wearableSyncMessage);
				NetworkServer.SendToAll(wearableSyncMessage);
			}
			else
			{
				PayloadWriter.Reset();
				subcontroller.WriteWearableSyncvars(PayloadWriter, newWearables);
				WearableSyncMessage wearableSyncMessage2 = new WearableSyncMessage(hub, newWearables, PayloadWriter);
				UpdateDatabaseEntry(wearableSyncMessage2);
				NetworkServer.SendToAll(wearableSyncMessage2);
			}
		}

		public static void EnableWearables(this ReferenceHub hub, WearableElements toEnable)
		{
			WearableElements flags = GetFlags(hub);
			WearableElements wearableElements = flags | toEnable;
			if (wearableElements != flags)
			{
				hub.OverrideWearables(wearableElements);
			}
		}

		public static void DisableWearables(this ReferenceHub hub, WearableElements toDisable)
		{
			WearableElements flags = GetFlags(hub);
			WearableElements wearableElements = (WearableElements)((uint)flags & (uint)(byte)(~(int)toDisable));
			if (wearableElements != flags)
			{
				hub.OverrideWearables(wearableElements);
			}
		}

		private static void UpdateDatabaseEntry(WearableSyncMessage newEntry)
		{
			uint playerNetId = newEntry.PlayerNetId;
			if (Database.TryGetValue(playerNetId, out var value) && value.Payload != null)
			{
				value.Free();
			}
			Database[playerNetId] = newEntry;
			if (ReferenceHub.TryGetHubNetID(playerNetId, out var hub) && hub.TryGetWearableSubcontroller<WearableSubcontroller>(out var subcontroller))
			{
				subcontroller.ClientReceiveWearables(newEntry.Flags, newEntry.GetPayloadReader());
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ReferenceHub.OnPlayerAdded += OnHubAdded;
			ReferenceHub.OnPlayerRemoved += OnHubRemoved;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
			CustomNetworkManager.OnClientReady += OnClientReady;
		}

		private static void OnClientReady()
		{
			Database.Clear();
			NetworkClient.ReplaceHandler<WearableSyncMessage>(UpdateDatabaseEntry);
		}

		private static void OnHubRemoved(ReferenceHub hub)
		{
			Database.Remove(hub.netId);
		}

		private static void OnHubAdded(ReferenceHub hub)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			foreach (KeyValuePair<uint, WearableSyncMessage> item in Database)
			{
				if (item.Value.Flags != WearableElements.None && ReferenceHub.TryGetHubNetID(item.Key, out var hub2) && hub2.TryGetWearableSubcontroller<WearableSubcontroller>(out var subcontroller))
				{
					subcontroller.WriteWearableSyncvars(PayloadWriter, item.Value.Flags);
					WearableSyncMessage message = new WearableSyncMessage(hub2, item.Value.Flags, PayloadWriter);
					hub.connectionToClient.Send(message);
				}
			}
		}

		private static void OnServerRoleSet(ReferenceHub hub, RoleTypeId newRole, RoleChangeReason reason)
		{
			if (GetFlags(hub) != WearableElements.None)
			{
				hub.OverrideWearables(WearableElements.None);
			}
		}
	}
}
