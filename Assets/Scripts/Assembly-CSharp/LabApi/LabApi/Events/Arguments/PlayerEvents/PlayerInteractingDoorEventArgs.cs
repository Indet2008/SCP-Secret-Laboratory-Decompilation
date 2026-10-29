namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractingDoorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IDoorEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Door Door { get; }

		public bool CanOpen { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerInteractingDoorEventArgs(ReferenceHub hub, global::Interactables.Interobjects.DoorUtils.DoorVariant door, bool canOpen)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			CanOpen = canOpen;
		}
	}
}
