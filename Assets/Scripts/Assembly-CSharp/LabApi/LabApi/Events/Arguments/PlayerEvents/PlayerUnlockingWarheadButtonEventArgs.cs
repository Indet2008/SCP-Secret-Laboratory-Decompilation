namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUnlockingWarheadButtonEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public PlayerUnlockingWarheadButtonEventArgs(ReferenceHub hub)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsAllowed = true;
		}
	}
}
