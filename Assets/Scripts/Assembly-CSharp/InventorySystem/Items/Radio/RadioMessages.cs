using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Radio
{
	public static class RadioMessages
	{
		public enum RadioCommand : byte
		{
			Enable = 0,
			Disable = 1,
			ChangeRange = 2
		}

		public enum RadioRangeLevel : sbyte
		{
			RadioDisabled = -1,
			LowRange = 0,
			MediumRange = 1,
			HighRange = 2,
			UltraRange = 3
		}

		public static readonly Dictionary<uint, RadioStatusMessage> SyncedRangeLevels = new Dictionary<uint, RadioStatusMessage>();

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<RadioStatusMessage>(ClientStatusReceived);
				NetworkServer.ReplaceHandler<ClientRadioCommandMessage>(ServerCommandReceived);
				SyncedRangeLevels.Clear();
			};
			ReferenceHub.OnPlayerAdded += (ReferenceHub hub) =>
			{
				if (!NetworkServer.active)
				{
					return;
				}
				foreach (KeyValuePair<uint, RadioStatusMessage> syncedRangeLevel in SyncedRangeLevels)
				{
					hub.connectionToClient.Send(syncedRangeLevel.Value);
				}
			};
		}

		private static void ServerCommandReceived(NetworkConnection conn, ClientRadioCommandMessage msg)
		{
			if (GetRadio(ReferenceHub.GetHub(conn.identity.gameObject), out var radio))
			{
				radio.ServerProcessCmd(msg.Command);
			}
		}

		private static void ClientStatusReceived(RadioStatusMessage msg)
		{
			SyncedRangeLevels[msg.Owner] = msg;
			if (ReferenceHub.TryGetLocalHub(out var hub) && GetRadio(hub, out var radio) && radio.Owner.netId == msg.Owner)
			{
				radio.UserReceiveInfo(msg);
			}
		}

		private static bool GetRadio(ReferenceHub ply, out RadioItem radio)
		{
			radio = null;
			if (ply == null)
			{
				return false;
			}
			foreach (ItemBase value in ply.inventory.UserInventory.Items.Values)
			{
				if (value is RadioItem radioItem)
				{
					radio = radioItem;
					return true;
				}
			}
			return false;
		}

		public static void WriteRadioStatusMessage(this NetworkWriter writer, RadioStatusMessage msg)
		{
			msg.Serialize(writer);
		}

		public static RadioStatusMessage ReadRadioStatusMessage(this NetworkReader reader)
		{
			return new RadioStatusMessage(reader);
		}

		public static void WriteClientRadioCommandMessage(this NetworkWriter writer, ClientRadioCommandMessage msg)
		{
			msg.Serialize(writer);
		}

		public static ClientRadioCommandMessage ReadClientRadioCommandMessage(this NetworkReader reader)
		{
			return new ClientRadioCommandMessage(reader);
		}
	}
}
