namespace LabApi.Events.Arguments.Interfaces
{
	public interface IObjectiveEvent
	{
		global::LabApi.Features.Wrappers.Player Player { get; }

		global::PlayerRoles.Faction Faction { get; }

		float InfluenceToGrant { get; }

		float TimeToGrant { get; }

		bool SendToPlayers { get; }
	}
}
