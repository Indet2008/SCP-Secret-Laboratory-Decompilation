namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096AddedTargetEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool WasLooking { get; }

		public Scp096AddedTargetEventArgs(ReferenceHub hub, ReferenceHub target, bool wasLooking)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			WasLooking = wasLooking;
		}
	}
}
