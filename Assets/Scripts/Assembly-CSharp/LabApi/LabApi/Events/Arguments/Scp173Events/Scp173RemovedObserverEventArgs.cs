namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173RemovedObserverEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Target { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp173RemovedObserverEventArgs(ReferenceHub target, ReferenceHub hub)
		{
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
