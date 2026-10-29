namespace LabApi.Events.Arguments.ServerEvents
{
	public class ElevatorSequenceChangedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IElevatorEvent
	{
		public global::LabApi.Features.Wrappers.Elevator Elevator { get; }

		public global::Interactables.Interobjects.ElevatorChamber.ElevatorSequence OldSequence { get; }

		public global::Interactables.Interobjects.ElevatorChamber.ElevatorSequence NewSequence { get; }

		public ElevatorSequenceChangedEventArgs(global::Interactables.Interobjects.ElevatorChamber elevator, global::Interactables.Interobjects.ElevatorChamber.ElevatorSequence oldSequence, global::Interactables.Interobjects.ElevatorChamber.ElevatorSequence newSequence)
		{
			Elevator = global::LabApi.Features.Wrappers.Elevator.Get(elevator);
			OldSequence = oldSequence;
			NewSequence = newSequence;
		}
	}
}
