namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerLeavingPocketDimensionEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.PocketTeleport? Teleport { get; }

		public bool IsSuccessful { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerLeavingPocketDimensionEventArgs(ReferenceHub hub, PocketDimensionTeleport teleport, bool isSuccessful)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Teleport = global::LabApi.Features.Wrappers.PocketTeleport.Get(teleport);
			IsSuccessful = isSuccessful;
		}
	}
}
