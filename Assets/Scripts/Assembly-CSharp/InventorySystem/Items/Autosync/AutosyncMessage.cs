using System;
using Mirror;

namespace InventorySystem.Items.Autosync
{
	public readonly struct AutosyncMessage : NetworkMessage
	{
		private static readonly byte[] Buffer = new byte[65790];

		private static readonly NetworkReader Reader = new NetworkReader(Buffer);

		private readonly int _bytesWritten;

		private readonly ushort _serial;

		private readonly ItemType _itemType;

		public AutosyncMessage(NetworkWriter writer, ItemIdentifier itemId)
		{
			_serial = itemId.SerialNumber;
			_itemType = itemId.TypeId;
			int position = writer.Position;
			writer.WriteByte((byte)Math.Min(position, 255));
			if (position >= 255)
			{
				writer.WriteUShort((ushort)(position - 255));
			}
			_bytesWritten = position;
			Array.Copy(writer.buffer, Buffer, _bytesWritten);
		}

		public override string ToString()
		{
			return string.Format("{0} (Item={1} Serial={2} Length={3} Payload={4})", "AutosyncMessage", _itemType, _serial, _bytesWritten, Reader);
		}

		internal AutosyncMessage(NetworkReader reader)
		{
			_serial = reader.ReadUShort();
			_itemType = (ItemType)reader.ReadByte();
			_bytesWritten = reader.ReadByte();
			if (_bytesWritten == 255)
			{
				_bytesWritten += reader.ReadUShort();
			}
			reader.ReadBytes(Buffer, _bytesWritten);
		}

		internal void Serialize(NetworkWriter writer)
		{
			writer.WriteUShort(_serial);
			writer.WriteByte((byte)_itemType);
			if (_bytesWritten < 255)
			{
				writer.WriteByte((byte)_bytesWritten);
			}
			else
			{
				writer.WriteByte(byte.MaxValue);
				writer.WriteUShort((ushort)(_bytesWritten - 255));
			}
			writer.WriteBytes(Buffer, 0, _bytesWritten);
		}

		internal void ProcessCmd(ReferenceHub sender)
		{
			if (!sender.inventory.UserInventory.Items.TryGetValue(_serial, out var value))
			{
				if (sender.isLocalPlayer)
				{
					TryEmulateDummies();
				}
			}
			else if (value is AutosyncItem autosyncItem && autosyncItem.ItemTypeId == _itemType)
			{
				ResetReader();
				autosyncItem.ServerProcessCmd(Reader);
			}
		}

		internal void ProcessRpc()
		{
			if (InventoryItemLoader.TryGetItem<AutosyncItem>(_itemType, out var result))
			{
				ResetReader();
				result.ClientProcessRpcTemplate(Reader, _serial);
			}
			if (_serial == 0)
			{
				return;
			}
			foreach (AutosyncItem instance in AutosyncItem.Instances)
			{
				if (instance.ItemSerial == _serial && instance.ItemTypeId == _itemType)
				{
					ResetReader();
					instance.ClientProcessRpcInstance(Reader);
				}
			}
		}

		private void ResetReader()
		{
			Reader.buffer = new ArraySegment<byte>(Buffer, 0, _bytesWritten);
			Reader.Position = 0;
		}

		private void TryEmulateDummies()
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsDummy)
				{
					ProcessCmd(allHub);
				}
			}
		}
	}
}
