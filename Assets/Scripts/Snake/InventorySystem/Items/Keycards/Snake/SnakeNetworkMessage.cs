namespace InventorySystem.Items.Keycards.Snake
{
	public struct SnakeNetworkMessage : global::Mirror.NetworkMessage
	{
		[global::System.Flags]
		public enum SyncFlags : byte
		{
			Delta = 1,
			HasNewFood = 2,
			GameOver = 4,
			GameReset = 8
		}

		public global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags Flags;

		public global::UnityEngine.Vector2Int? NextFoodPosition;

		public global::UnityEngine.Vector2Int MoveOffset;

		public global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> Segments;

		private SnakeNetworkMessage(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags flags, global::UnityEngine.Vector2Int? nextFood, global::UnityEngine.Vector2Int moveOffset, global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> positions)
		{
			Flags = flags;
			NextFoodPosition = nextFood;
			MoveOffset = moveOffset;
			Segments = positions;
		}

		public SnakeNetworkMessage(global::Mirror.NetworkReader reader)
		{
			NextFoodPosition = null;
			Segments = null;
			Flags = (global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags)reader.ReadByte();
			MoveOffset = ReadVector2Compressed(reader);
			if (Flags.HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.HasNewFood))
			{
				NextFoodPosition = ReadVector2CompressedNullable(reader);
			}
			if (!HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.Delta))
			{
				int num = reader.ReadByte();
				Segments = new global::System.Collections.Generic.List<global::UnityEngine.Vector2Int>(num);
				for (int i = 0; i < num; i++)
				{
					Segments.Add(ReadVector2Compressed(reader));
				}
			}
		}

		public void WriteSelf(global::Mirror.NetworkWriter writer)
		{
			writer.WriteByte((byte)Flags);
			WriteVector2Compressed(writer, MoveOffset);
			if (HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.HasNewFood))
			{
				WriteVector2Compressed(writer, NextFoodPosition);
			}
			if (!HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.Delta))
			{
				int num = global::UnityEngine.Mathf.Min(Segments.Count, 255);
				writer.WriteByte((byte)num);
				for (int i = 0; i < num; i++)
				{
					WriteVector2Compressed(writer, Segments[i]);
				}
			}
		}

		public static global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage NewSimple(global::UnityEngine.Vector2Int moveOffset)
		{
			return new global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.Delta, null, moveOffset, null);
		}

		public static global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage NewEaten(global::UnityEngine.Vector2Int moveOffset, global::UnityEngine.Vector2Int? nextFood)
		{
			return new global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.Delta | global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.HasNewFood, nextFood, moveOffset, null);
		}

		public static global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage NewGameOver()
		{
			return new global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.Delta | global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.GameOver, null, global::UnityEngine.Vector2Int.zero, null);
		}

		public static global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage NewReset(global::UnityEngine.Vector2Int? nextFood)
		{
			return new global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.Delta | global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.HasNewFood | global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.GameReset, nextFood, global::UnityEngine.Vector2Int.zero, null);
		}

		public static global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage NewFullResync(bool gameover, global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> positions, global::UnityEngine.Vector2Int? nextFood)
		{
			global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags syncFlags = global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.HasNewFood;
			if (gameover)
			{
				syncFlags |= global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.GameOver;
			}
			return new global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage(syncFlags, nextFood, global::UnityEngine.Vector2Int.zero, positions);
		}

		public bool HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags flag)
		{
			return (flag & Flags) != 0;
		}

		private static void WriteVector2Compressed(global::Mirror.NetworkWriter writer, global::UnityEngine.Vector2Int? vector)
		{
			if (!vector.HasValue)
			{
				global::Mirror.NetworkWriterExtensions.WriteSByte(writer, sbyte.MaxValue);
				return;
			}
			global::Mirror.NetworkWriterExtensions.WriteSByte(writer, (sbyte)vector.Value.x);
			global::Mirror.NetworkWriterExtensions.WriteSByte(writer, (sbyte)vector.Value.y);
		}

		private static global::UnityEngine.Vector2Int? ReadVector2CompressedNullable(global::Mirror.NetworkReader reader)
		{
			sbyte b = global::Mirror.NetworkReaderExtensions.ReadSByte(reader);
			if (b == sbyte.MaxValue)
			{
				return null;
			}
			sbyte y = global::Mirror.NetworkReaderExtensions.ReadSByte(reader);
			return new global::UnityEngine.Vector2Int(b, y);
		}

		private static global::UnityEngine.Vector2Int ReadVector2Compressed(global::Mirror.NetworkReader reader)
		{
			return ReadVector2CompressedNullable(reader) ?? global::UnityEngine.Vector2Int.zero;
		}
	}
}
