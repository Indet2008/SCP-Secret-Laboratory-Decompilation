using System;
using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public static class KeycardDetailSynchronizer
	{
		public struct DetailsSyncMsg : NetworkMessage
		{
			public ushort Serial;

			public ArraySegment<byte> Payload;
		}

		private const int MaxPayloadSize = 2048;

		private const int PoolCapacity = 512;

		private static readonly Stack<byte[]> PayloadPool = new Stack<byte[]>(512);

		private static readonly Dictionary<ushort, ArraySegment<byte>> Database = new Dictionary<ushort, ArraySegment<byte>>();

		private static readonly NetworkWriter PayloadWriterNonAlloc = new NetworkWriter();

		private static readonly Dictionary<ushort, KeycardGfx> RegisteredReceivers = new Dictionary<ushort, KeycardGfx>();

		public static NetworkReaderPooled PayloadReader { get; private set; }

		public static bool TryReapplyDetails(KeycardGfx target)
		{
			ItemIdentifier parentId = target.ParentId;
			if (!Database.TryGetValue(parentId.SerialNumber, out var value))
			{
				return false;
			}
			if (!parentId.TryGetTemplate<KeycardItem>(out var item))
			{
				return false;
			}
			ClientApplyDetails(value, item, target);
			return true;
		}

		public static void RegisterReceiver(KeycardGfx target)
		{
			ushort serialNumber = target.ParentId.SerialNumber;
			RegisteredReceivers[serialNumber] = target;
			TryReapplyDetails(target);
		}

		public static void UnregisterReceiver(KeycardGfx target)
		{
			ushort serialNumber = target.ParentId.SerialNumber;
			if (RegisteredReceivers.TryGetValue(serialNumber, out var value) && !(value != target))
			{
				RegisteredReceivers.Remove(serialNumber);
			}
		}

		public static void ServerProcessPickup(KeycardPickup pickup)
		{
			ushort serialNumber = pickup.ItemId.SerialNumber;
			if (Database.ContainsKey(serialNumber) || !pickup.TryGetTemplate<KeycardItem>(out var item))
			{
				return;
			}
			NetworkWriter payloadWriter = GetPayloadWriter();
			DetailBase[] details = item.Details;
			for (int i = 0; i < details.Length; i++)
			{
				if (details[i] is SyncedDetail syncedDetail)
				{
					syncedDetail.WriteNewPickup(pickup, payloadWriter);
				}
			}
			ServerAddDatabaseEntry(serialNumber, payloadWriter.ToArraySegment());
		}

		public static void ServerProcessItem(KeycardItem item)
		{
			if (Database.ContainsKey(item.ItemSerial))
			{
				return;
			}
			NetworkWriter payloadWriter = GetPayloadWriter();
			DetailBase[] details = item.Details;
			for (int i = 0; i < details.Length; i++)
			{
				if (details[i] is SyncedDetail syncedDetail)
				{
					syncedDetail.WriteNewItem(item, payloadWriter);
				}
			}
			ServerAddDatabaseEntry(item.ItemSerial, payloadWriter.ToArraySegment());
		}

		public static void ApplyTemplateDetails(KeycardItem template, KeycardGfx gfx)
		{
			NetworkWriter payloadWriter = GetPayloadWriter();
			DetailBase[] details = template.Details;
			for (int i = 0; i < details.Length; i++)
			{
				if (details[i] is SyncedDetail syncedDetail)
				{
					syncedDetail.WriteDefault(payloadWriter);
				}
			}
			ClientApplyDetails(payloadWriter.ToArraySegment(), template, gfx);
			PayloadPool.Push(payloadWriter.buffer);
		}

		private static void ClientApplyDetails(ArraySegment<byte> payload, KeycardItem template, KeycardGfx target)
		{
			using (PayloadReader = NetworkReaderPool.Get(payload))
			{
				DetailBase[] details = template.Details;
				foreach (DetailBase detailBase in details)
				{
					try
					{
						detailBase.ApplyDetail(target, template);
					}
					catch (Exception exception)
					{
						string arg = string.Concat(detailBase.GetType(), '@', template.name);
						Debug.LogError($"Error applying detail: '{arg}' Payload: {PayloadReader}");
						Debug.LogException(exception);
					}
				}
			}
			target.OnAllDetailsApplied();
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += OnClientReady;
			ReferenceHub.OnPlayerAdded += OnPlayerConnected;
		}

		private static void OnPlayerConnected(ReferenceHub hub)
		{
			if (!NetworkServer.active || hub.isLocalPlayer)
			{
				return;
			}
			foreach (KeyValuePair<ushort, ArraySegment<byte>> item in Database)
			{
				hub.connectionToClient.Send(new DetailsSyncMsg
				{
					Serial = item.Key,
					Payload = item.Value
				});
			}
		}

		private static void OnClientReady()
		{
			NetworkClient.ReplaceHandler<DetailsSyncMsg>(ClientReceiveMessage);
			foreach (KeyValuePair<ushort, ArraySegment<byte>> item in Database)
			{
				if (PayloadPool.Count >= 512)
				{
					break;
				}
				PayloadPool.Push(item.Value.Array);
			}
			Database.Clear();
			RegisteredReceivers.Clear();
		}

		private static void ServerAddDatabaseEntry(ushort serial, ArraySegment<byte> entry)
		{
			Database.Add(serial, entry);
			NetworkServer.SendToAll(new DetailsSyncMsg
			{
				Serial = serial,
				Payload = entry
			});
		}

		private static NetworkWriter GetPayloadWriter()
		{
			if (!PayloadPool.TryPop(out var result))
			{
				result = new byte[2048];
			}
			PayloadWriterNonAlloc.buffer = result;
			PayloadWriterNonAlloc.Reset();
			return PayloadWriterNonAlloc;
		}

		private static void ClientReceiveMessage(DetailsSyncMsg msg)
		{
			Database[msg.Serial] = msg.Payload;
			if (RegisteredReceivers.TryGetValue(msg.Serial, out var value) && !(value == null) && value.ParentId.TryGetTemplate<KeycardItem>(out var item))
			{
				ClientApplyDetails(msg.Payload, item, value);
			}
		}

		public static void SerializeDetailsSyncMsg(this NetworkWriter writer, DetailsSyncMsg msg)
		{
			writer.WriteUShort(msg.Serial);
			writer.WriteArraySegment(msg.Payload);
		}

		public static DetailsSyncMsg DeserializeDetailsSyncMsg(this NetworkReader reader)
		{
			ushort num = reader.ReadUShort();
			byte[] result;
			if (Database.TryGetValue(num, out var value))
			{
				result = value.Array;
			}
			else if (!PayloadPool.TryPop(out result))
			{
				result = new byte[2048];
			}
			int count = reader.ReadInt();
			reader.ReadBytes(result, count);
			return new DetailsSyncMsg
			{
				Serial = num,
				Payload = new ArraySegment<byte>(result, 0, count)
			};
		}
	}
}
