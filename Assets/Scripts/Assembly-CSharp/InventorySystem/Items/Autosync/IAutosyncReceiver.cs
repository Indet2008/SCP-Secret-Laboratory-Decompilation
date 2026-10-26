using Mirror;

namespace InventorySystem.Items.Autosync
{
	public interface IAutosyncReceiver
	{
		void ServerProcessCmd(NetworkReader reader);

		void ClientProcessRpcTemplate(NetworkReader reader, ushort serial);

		void ClientProcessRpcInstance(NetworkReader reader);
	}
}
