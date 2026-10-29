namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractedElevatorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IElevatorEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Elevator Elevator { get; }

		public global::Interactables.Interobjects.ElevatorPanel Panel { get; }

		public PlayerInteractedElevatorEventArgs(ReferenceHub hub, global::Interactables.Interobjects.ElevatorChamber elevator, global::Interactables.Interobjects.ElevatorPanel panel)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Elevator = global::LabApi.Features.Wrappers.Elevator.Get(elevator);
			Panel = panel;
		}
	}
}
