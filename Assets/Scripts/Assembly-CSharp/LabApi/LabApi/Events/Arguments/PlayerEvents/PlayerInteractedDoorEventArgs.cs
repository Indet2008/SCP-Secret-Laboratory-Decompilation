namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractedDoorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IDoorEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Door Door { get; }

		public bool CanOpen { get; }

		public PlayerInteractedDoorEventArgs(ReferenceHub hub, global::Interactables.Interobjects.DoorUtils.DoorVariant door, bool canOpen)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			CanOpen = canOpen;
		}
	}
}
