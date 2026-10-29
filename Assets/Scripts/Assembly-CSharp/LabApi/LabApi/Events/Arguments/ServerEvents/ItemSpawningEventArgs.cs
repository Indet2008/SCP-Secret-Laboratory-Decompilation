namespace LabApi.Events.Arguments.ServerEvents
{
	public class ItemSpawningEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public ItemType ItemType { get; set; }

		public bool IsAllowed { get; set; }

		public ItemSpawningEventArgs(ItemType type)
		{
			IsAllowed = true;
			ItemType = type;
		}
	}
}
