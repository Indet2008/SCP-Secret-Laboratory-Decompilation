using Mirror;

namespace InventorySystem.Items.Autosync
{
	public class AutosyncCmd : AutosyncWriterBase
	{
		public AutosyncCmd(ItemIdentifier item, out NetworkWriter writer)
			: base(item, out writer)
		{
		}

		public AutosyncCmd(ItemIdentifier item)
			: base(item, out var _)
		{
		}

		protected override void HandleSending(AutosyncMessage msg)
		{
			if (NetworkClient.ready && NetworkClient.active)
			{
				NetworkClient.Send(msg);
			}
		}
	}
}
