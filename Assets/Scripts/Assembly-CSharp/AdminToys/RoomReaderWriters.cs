using MapGeneration;
using Mirror;
using UnityEngine;

namespace AdminToys
{
	public static class RoomReaderWriters
	{
		public static void WriteRoomIdentifier(this NetworkWriter writer, RoomIdentifier room)
		{
			Vector3Int mainCoords = room.MainCoords;
			writer.WriteSByte((sbyte)mainCoords.x);
			writer.WriteSByte((sbyte)mainCoords.y);
			writer.WriteSByte((sbyte)mainCoords.z);
		}

		public static RoomIdentifier ReadRoomIdentifier(this NetworkReader reader)
		{
			sbyte x = reader.ReadSByte();
			sbyte y = reader.ReadSByte();
			sbyte z = reader.ReadSByte();
			if (!RoomIdentifier.RoomsByCoords.TryGetValue(new Vector3Int(x, y, z), out var value))
			{
				return null;
			}
			return value;
		}
	}
}
