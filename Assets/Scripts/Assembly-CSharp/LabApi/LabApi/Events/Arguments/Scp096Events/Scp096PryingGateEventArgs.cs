namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096PryingGateEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IGateEvent, global::LabApi.Events.Arguments.Interfaces.IDoorEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Gate Gate { get; }

		public bool IsAllowed { get; set; }

		public Scp096PryingGateEventArgs(ReferenceHub hub, global::Interactables.Interobjects.PryableDoor gate)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Gate = global::LabApi.Features.Wrappers.Gate.Get(gate);
			IsAllowed = true;
		}
	}
}
