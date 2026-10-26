using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments
{
	public static class AttachmentCodeSync
	{
		public readonly struct AttachmentCodeMessage : NetworkMessage
		{
			public readonly ushort WeaponSerial;

			public readonly uint AttachmentCode;

			public AttachmentCodeMessage(NetworkReader reader)
			{
				WeaponSerial = reader.ReadUShort();
				AttachmentCode = reader.ReadUInt();
			}

			public AttachmentCodeMessage(ushort serial, uint attCode)
			{
				WeaponSerial = serial;
				AttachmentCode = attCode;
			}

			public void Serialize(NetworkWriter writer)
			{
				writer.WriteUShort(WeaponSerial);
				writer.WriteUInt(AttachmentCode);
			}

			public void Apply()
			{
				ReceivedCodes[WeaponSerial] = AttachmentCode;
				OnReceived?.Invoke(WeaponSerial, AttachmentCode);
			}
		}

		[StructLayout(LayoutKind.Sequential, Size = 1)]
		public readonly struct AttachmentCodePackMessage : NetworkMessage
		{
			private static readonly List<AttachmentCodeMessage> LastDeserialized = new List<AttachmentCodeMessage>();

			public AttachmentCodePackMessage(NetworkReader reader)
			{
				LastDeserialized.Clear();
				int num = reader.ReadInt();
				for (int i = 0; i < num; i++)
				{
					LastDeserialized.Add(new AttachmentCodeMessage(reader));
				}
			}

			public void Serialize(NetworkWriter writer)
			{
				writer.WriteInt(ReceivedCodes.Count);
				foreach (KeyValuePair<ushort, uint> receivedCode in ReceivedCodes)
				{
					new AttachmentCodeMessage(receivedCode.Key, receivedCode.Value).Serialize(writer);
				}
			}

			public void Apply()
			{
				LastDeserialized.ForEach((AttachmentCodeMessage x) =>
				{
					x.Apply();
				});
			}
		}

		private static readonly Dictionary<ushort, uint> ReceivedCodes = new Dictionary<ushort, uint>();

		public static event Action<ushort, uint> OnReceived;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += OnClientReady;
			ReferenceHub.OnPlayerAdded += OnNewPlayerAdded;
		}

		private static void OnClientReady()
		{
			ReceivedCodes.Clear();
			NetworkClient.ReplaceHandler((AttachmentCodeMessage x) =>
			{
				x.Apply();
			});
			NetworkClient.ReplaceHandler((AttachmentCodePackMessage x) =>
			{
				x.Apply();
			});
		}

		private static void OnNewPlayerAdded(ReferenceHub hub)
		{
			if (NetworkServer.active)
			{
				hub.connectionToClient.Send<AttachmentCodePackMessage>(default);
			}
		}

		public static bool TryGet(ushort serial, out uint code)
		{
			return ReceivedCodes.TryGetValue(serial, out code);
		}

		public static void ServerSetCode(ushort serial, uint code)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Attempting to override attachment code on client!");
			}
			ReceivedCodes[serial] = code;
			NetworkServer.SendToAll(new AttachmentCodeMessage(serial, code));
		}

		public static void ServerResendAttachmentCode(this Firearm firearm)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Attempting to resend attachment code on client!");
			}
			ServerSetCode(firearm.ItemSerial, firearm.GetCurrentAttachmentsCode());
		}

		public static void WriteAttachmentCodeMessage(this NetworkWriter writer, AttachmentCodeMessage value)
		{
			value.Serialize(writer);
		}

		public static AttachmentCodeMessage ReadAttachmentCodeMessage(this NetworkReader reader)
		{
			return new AttachmentCodeMessage(reader);
		}

		public static void WriteAttachmentCodePackMessage(this NetworkWriter writer, AttachmentCodePackMessage value)
		{
			value.Serialize(writer);
		}

		public static AttachmentCodePackMessage ReadAttachmentCodePackMessage(this NetworkReader reader)
		{
			return new AttachmentCodePackMessage(reader);
		}
	}
}
