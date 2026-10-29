namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079BlackedOutZoneEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::MapGeneration.FacilityZone Zone { get; }

		public Scp079BlackedOutZoneEventArgs(ReferenceHub hub, global::MapGeneration.FacilityZone zone)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Zone = zone;
		}
	}
}
