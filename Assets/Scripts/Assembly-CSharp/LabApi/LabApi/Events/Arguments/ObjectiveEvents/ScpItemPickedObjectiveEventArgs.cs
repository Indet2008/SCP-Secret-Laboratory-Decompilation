namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class ScpItemPickedObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Item Item { get; }

		public ScpItemPickedObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, bool sendToPlayers, global::InventorySystem.Items.ItemBase item)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Item = global::LabApi.Features.Wrappers.Item.Get(item);
		}
	}
}
