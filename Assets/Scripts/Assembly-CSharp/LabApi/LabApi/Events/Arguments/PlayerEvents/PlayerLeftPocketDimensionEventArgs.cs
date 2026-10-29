namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerLeftPocketDimensionEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.PocketTeleport? Teleport { get; }

		public bool IsSuccessful { get; }

		public PlayerLeftPocketDimensionEventArgs(ReferenceHub hub, PocketDimensionTeleport teleport, bool isSuccessful)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Teleport = global::LabApi.Features.Wrappers.PocketTeleport.Get(teleport);
			IsSuccessful = isSuccessful;
		}
	}
}
