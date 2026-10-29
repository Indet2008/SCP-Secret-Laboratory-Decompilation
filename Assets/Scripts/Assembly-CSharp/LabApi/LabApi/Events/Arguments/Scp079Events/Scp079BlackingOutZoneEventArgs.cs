namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079BlackingOutZoneEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::MapGeneration.FacilityZone Zone { get; }

		public bool IsAllowed { get; set; }

		public Scp079BlackingOutZoneEventArgs(ReferenceHub hub, global::MapGeneration.FacilityZone zone)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Zone = zone;
			IsAllowed = true;
		}
	}
}
