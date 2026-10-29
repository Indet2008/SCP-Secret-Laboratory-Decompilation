namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173BreakneckSpeedChangingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool Active { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp173BreakneckSpeedChangingEventArgs(ReferenceHub hub, bool active)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Active = active;
		}
	}
}
