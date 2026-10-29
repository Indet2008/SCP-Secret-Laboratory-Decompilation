namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class ScpItemPickingObjectiveEventArgs : global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs
	{
		public global::LabApi.Features.Wrappers.Item Item { get; }

		public ScpItemPickingObjectiveEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, global::InventorySystem.Items.ItemBase item, bool sendToPlayers)
			: base(hub, faction, influenceToGrant, timeToGrant, sendToPlayers)
		{
			Item = global::LabApi.Features.Wrappers.Item.Get(item);
		}
	}
}
