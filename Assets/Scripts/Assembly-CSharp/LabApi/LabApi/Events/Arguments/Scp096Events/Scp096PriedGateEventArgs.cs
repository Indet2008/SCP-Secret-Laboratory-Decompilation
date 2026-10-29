namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096PriedGateEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IGateEvent, global::LabApi.Events.Arguments.Interfaces.IDoorEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Gate Gate { get; }

		public Scp096PriedGateEventArgs(ReferenceHub hub, global::Interactables.Interobjects.PryableDoor gate)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Gate = global::LabApi.Features.Wrappers.Gate.Get(gate);
		}
	}
}
