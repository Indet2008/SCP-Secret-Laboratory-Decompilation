namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173AddingObserverEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Target { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp173AddingObserverEventArgs(ReferenceHub target, ReferenceHub hub)
		{
			IsAllowed = true;
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
