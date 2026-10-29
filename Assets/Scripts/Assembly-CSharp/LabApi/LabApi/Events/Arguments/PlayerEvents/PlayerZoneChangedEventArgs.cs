namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerZoneChangedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::MapGeneration.FacilityZone OldZone { get; }

		public global::MapGeneration.FacilityZone NewZone { get; }

		public PlayerZoneChangedEventArgs(ReferenceHub player, global::MapGeneration.FacilityZone oldZone, global::MapGeneration.FacilityZone newZone)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			OldZone = oldZone;
			NewZone = newZone;
		}
	}
}
