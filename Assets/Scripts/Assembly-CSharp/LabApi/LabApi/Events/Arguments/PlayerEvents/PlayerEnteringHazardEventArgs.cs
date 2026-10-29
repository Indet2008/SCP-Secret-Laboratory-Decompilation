namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerEnteringHazardEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IHazardEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Hazard Hazard { get; }

		public bool IsAllowed { get; set; }

		public PlayerEnteringHazardEventArgs(ReferenceHub hub, global::Hazards.EnvironmentalHazard hazard)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Hazard = global::LabApi.Features.Wrappers.Hazard.Get(hazard);
			IsAllowed = true;
		}
	}
}
