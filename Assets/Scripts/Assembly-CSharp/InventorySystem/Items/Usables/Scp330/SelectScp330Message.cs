using Mirror;

namespace InventorySystem.Items.Usables.Scp330
{
	public struct SelectScp330Message : NetworkMessage
	{
		public ushort Serial;

		public int CandyID;

		public bool Drop;
	}
}
