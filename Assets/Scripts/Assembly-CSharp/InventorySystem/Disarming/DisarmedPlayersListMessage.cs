using System.Collections.Generic;
using Mirror;

namespace InventorySystem.Disarming
{
	public readonly struct DisarmedPlayersListMessage : NetworkMessage
	{
		public readonly List<DisarmedPlayers.DisarmedEntry> Entries;

		public DisarmedPlayersListMessage(List<DisarmedPlayers.DisarmedEntry> entries)
		{
			Entries = entries;
		}
	}
}
