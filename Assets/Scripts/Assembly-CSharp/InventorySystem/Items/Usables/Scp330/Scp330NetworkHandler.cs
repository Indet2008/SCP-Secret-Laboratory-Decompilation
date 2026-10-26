using System;
using System.Collections.Generic;
using Footprinting;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.Usables.Scp330
{
	public static class Scp330NetworkHandler
	{
		public static readonly Dictionary<ushort, CandyKindID> ReceivedSelectedCandies = new Dictionary<ushort, CandyKindID>();

		public static event Action<SelectScp330Message> OnClientSelectMessageReceived;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandlers;
		}

		private static void RegisterHandlers()
		{
			NetworkServer.ReplaceHandler<SelectScp330Message>(ServerSelectMessageReceived);
			NetworkClient.ReplaceHandler<SelectScp330Message>(ClientSelectMessageReceived);
			NetworkClient.ReplaceHandler<SyncScp330Message>(ClientSyncMessageReceived);
			ReceivedSelectedCandies.Clear();
		}

		private static void ServerSelectMessageReceived(NetworkConnection conn, SelectScp330Message msg)
		{
			if (ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub) && hub.inventory.CurInstance is Scp330Bag scp330Bag && !(scp330Bag == null) && scp330Bag.ItemSerial == msg.Serial && msg.CandyID < scp330Bag.Candies.Count)
			{
				if (msg.Drop)
				{
					scp330Bag.ServerDropCandy(msg.CandyID);
				}
				else if (!hub.HasBlock(BlockedInteraction.ItemPrimaryAction))
				{
					scp330Bag.ServerSelectCandy(msg.CandyID);
				}
			}
		}

		public static void ServerDropCandy(this Scp330Bag bag, int index)
		{
			if (InventoryExtensions.ServerCreatePickup(psi: new PickupSyncInfo(bag.ItemTypeId, bag.Weight, 0), inv: bag.OwnerInventory, item: bag) is Scp330Pickup scp330Pickup)
			{
				scp330Pickup.PreviousOwner = new Footprint(bag.Owner);
				CandyKindID candyKindID = bag.TryRemove(index);
				if (candyKindID != CandyKindID.None)
				{
					scp330Pickup.NetworkExposedCandy = candyKindID;
					scp330Pickup.StoredCandies.Add(candyKindID);
				}
			}
		}

		public static void ServerSelectCandy(this Scp330Bag bag, int index)
		{
			if (bag.Candies.TryGet(index, out var element))
			{
				PlayerUsingItemEventArgs e = new PlayerUsingItemEventArgs(bag.Owner, bag);
				PlayerEvents.OnUsingItem(e);
				if (e.IsAllowed)
				{
					bag.SelectedCandyId = index;
					PlayerHandler handler = UsableItemsController.GetHandler(bag.Owner);
					handler.CurrentUsable = new CurrentlyUsedItem(bag, bag.ItemSerial, Time.timeSinceLevelLoad);
					handler.CurrentUsable.Item.OnUsingStarted();
					new SelectScp330Message
					{
						CandyID = (int)element,
						Drop = false,
						Serial = bag.ItemSerial
					}.SendToAuthenticated();
				}
			}
		}

		private static void ClientSyncMessageReceived(SyncScp330Message msg)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.inventory.UserInventory.Items.TryGetValue(msg.Serial, out var value) && value is Scp330Bag scp330Bag)
			{
				scp330Bag.Candies = msg.Candies;
			}
		}

		private static void ClientSelectMessageReceived(SelectScp330Message msg)
		{
			CandyKindID candyKindID = (CandyKindID)msg.CandyID;
			ReceivedSelectedCandies[msg.Serial] = candyKindID;
			OnClientSelectMessageReceived?.Invoke(msg);
			if (InventoryExtensions.TryGetHubHoldingSerial(msg.Serial, out var hub))
			{
				if (hub.isLocalPlayer && hub.inventory.CurInstance is Scp330Bag scp330Bag && scp330Bag != null)
				{
					scp330Bag.OnUsingStarted();
				}
				if (InventoryItemLoader.TryGetItem<Scp330Bag>(ItemType.SCP330, out var _))
				{
					UsableItemsController.PlaySoundOnPlayer(hub, Scp330Viewmodel.GetClipForCandy(candyKindID));
					UsableItemsController.StartTimes[msg.Serial] = Time.timeSinceLevelLoad;
				}
			}
		}

		public static void SerializeSyncMessage(this NetworkWriter writer, SyncScp330Message value)
		{
			writer.WriteUShort(value.Serial);
			writer.WriteByte((byte)value.Candies.Count);
			foreach (CandyKindID candy in value.Candies)
			{
				writer.WriteByte((byte)candy);
			}
		}

		public static SyncScp330Message DeserializeSyncMessage(this NetworkReader reader)
		{
			ushort serial = reader.ReadUShort();
			byte b = reader.ReadByte();
			List<CandyKindID> list = new List<CandyKindID>();
			for (int i = 0; i < b; i++)
			{
				list.Add((CandyKindID)reader.ReadByte());
			}
			return new SyncScp330Message
			{
				Candies = list,
				Serial = serial
			};
		}

		public static void SerializeSelectMessage(this NetworkWriter writer, SelectScp330Message value)
		{
			int num = value.CandyID + 1;
			writer.WriteUShort(value.Serial);
			writer.WriteSByte((sbyte)(value.Drop ? (-num) : num));
		}

		public static SelectScp330Message DeserializeSelectMessage(this NetworkReader reader)
		{
			ushort serial = reader.ReadUShort();
			int num = reader.ReadSByte();
			return new SelectScp330Message
			{
				CandyID = Mathf.Abs(num) - 1,
				Serial = serial,
				Drop = (num < 0)
			};
		}
	}
}
