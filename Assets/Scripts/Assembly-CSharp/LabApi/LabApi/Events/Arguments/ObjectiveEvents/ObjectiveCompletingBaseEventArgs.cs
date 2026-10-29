namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public abstract class ObjectiveCompletingBaseEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IObjectiveEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; set; }

		public global::PlayerRoles.Faction Faction { get; set; }

		public float InfluenceToGrant { get; set; }

		public float TimeToGrant { get; set; }

		public bool SendToPlayers { get; set; }

		public bool IsAllowed { get; set; }

		public ObjectiveCompletingBaseEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, bool sendToPlayers)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Faction = faction;
			InfluenceToGrant = influenceToGrant;
			TimeToGrant = timeToGrant;
			SendToPlayers = sendToPlayers;
			IsAllowed = true;
		}
	}
}
