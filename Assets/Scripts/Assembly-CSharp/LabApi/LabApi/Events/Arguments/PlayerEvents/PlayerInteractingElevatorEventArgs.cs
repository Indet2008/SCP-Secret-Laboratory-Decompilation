namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractingElevatorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IElevatorEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Elevator Elevator { get; }

		public global::Interactables.Interobjects.ElevatorPanel Panel { get; }

		public bool IsAllowed { get; set; }

		public PlayerInteractingElevatorEventArgs(ReferenceHub hub, global::Interactables.Interobjects.ElevatorChamber elevator, global::Interactables.Interobjects.ElevatorPanel panel)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Elevator = global::LabApi.Features.Wrappers.Elevator.Get(elevator);
			Panel = panel;
		}
	}
}
