using System.Collections.Generic;
using Mirror;

namespace InventorySystem.Items.Usables.Scp330
{
	public struct SyncScp330Message : NetworkMessage
	{
		public ushort Serial;

		public List<CandyKindID> Candies;
	}
}
