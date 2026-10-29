namespace LabApi.Events.Arguments.ObjectiveEvents
{
	public class ObjectiveCompletedBaseEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IObjectiveEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.Faction Faction { get; }

		public float InfluenceToGrant { get; }

		public float TimeToGrant { get; }

		public bool SendToPlayers { get; }

		public ObjectiveCompletedBaseEventArgs(ReferenceHub hub, global::PlayerRoles.Faction faction, float influenceToGrant, float timeToGrant, bool sendToPlayers)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Faction = faction;
			InfluenceToGrant = influenceToGrant;
			TimeToGrant = timeToGrant;
			SendToPlayers = sendToPlayers;
		}
	}
}
