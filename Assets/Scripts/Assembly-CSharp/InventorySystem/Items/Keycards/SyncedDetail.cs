using Mirror;

namespace InventorySystem.Items.Keycards
{
	public abstract class SyncedDetail : DetailBase
	{
		public abstract void WriteNewPickup(KeycardPickup pickup, NetworkWriter writer);

		public abstract void WriteNewItem(KeycardItem item, NetworkWriter writer);

		public abstract void WriteDefault(NetworkWriter writer);

		protected abstract void ApplyDetail(KeycardGfx target, NetworkReader reader, KeycardItem template);

		public sealed override void ApplyDetail(KeycardGfx target, KeycardItem template)
		{
			ApplyDetail(target, KeycardDetailSynchronizer.PayloadReader, template);
		}
	}
}
