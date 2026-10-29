namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerLeftHazardEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IHazardEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Hazard Hazard { get; }

		public PlayerLeftHazardEventArgs(ReferenceHub hub, global::Hazards.EnvironmentalHazard hazard)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Hazard = global::LabApi.Features.Wrappers.Hazard.Get(hazard);
		}
	}
}
