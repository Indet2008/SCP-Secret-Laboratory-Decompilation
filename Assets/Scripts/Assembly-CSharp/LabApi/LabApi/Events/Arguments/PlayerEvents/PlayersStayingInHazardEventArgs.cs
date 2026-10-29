namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayersStayingInHazardEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IHazardEvent
	{
		public global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> AffectedPlayers { get; }

		public global::LabApi.Features.Wrappers.Hazard Hazard { get; }

		public PlayersStayingInHazardEventArgs(global::System.Collections.Generic.List<ReferenceHub> affectedPlayers, global::Hazards.EnvironmentalHazard hazard)
		{
			Hazard = global::LabApi.Features.Wrappers.Hazard.Get(hazard);
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Player>.Shared.Rent();
			AffectedPlayers = list;
			foreach (ReferenceHub affectedPlayer in affectedPlayers)
			{
				AffectedPlayers.Add(global::LabApi.Features.Wrappers.Player.Get(affectedPlayer));
			}
		}
	}
}
