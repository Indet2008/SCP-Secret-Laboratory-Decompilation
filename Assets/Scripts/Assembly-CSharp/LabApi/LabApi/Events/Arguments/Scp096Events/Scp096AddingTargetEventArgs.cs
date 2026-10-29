namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096AddingTargetEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool WasLooking { get; }

		public bool IsAllowed { get; set; }

		public Scp096AddingTargetEventArgs(ReferenceHub hub, ReferenceHub target, bool wasLooking)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			WasLooking = wasLooking;
			IsAllowed = true;
		}
	}
}
