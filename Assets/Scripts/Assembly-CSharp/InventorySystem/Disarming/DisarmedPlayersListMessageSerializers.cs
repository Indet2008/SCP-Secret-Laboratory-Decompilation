using System.Collections.Generic;
using Mirror;

namespace InventorySystem.Disarming
{
	public static class DisarmedPlayersListMessageSerializers
	{
		public static void Serialize(this NetworkWriter writer, DisarmedPlayersListMessage value)
		{
			writer.WriteByte((byte)value.Entries.Count);
			foreach (DisarmedPlayers.DisarmedEntry entry in value.Entries)
			{
				writer.WriteUInt(entry.DisarmedPlayer);
				writer.WriteUInt(entry.Disarmer);
			}
		}

		public static DisarmedPlayersListMessage Deserialize(this NetworkReader reader)
		{
			List<DisarmedPlayers.DisarmedEntry> list = new List<DisarmedPlayers.DisarmedEntry>();
			int num = reader.ReadByte();
			for (int i = 0; i < num; i++)
			{
				uint disarmedPlayer = reader.ReadUInt();
				uint disarmer = reader.ReadUInt();
				list.Add(new DisarmedPlayers.DisarmedEntry(disarmedPlayer, disarmer));
			}
			return new DisarmedPlayersListMessage(list);
		}
	}
}
