namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173BreakneckSpeedChangedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public bool Active { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp173BreakneckSpeedChangedEventArgs(ReferenceHub hub, bool active)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Active = active;
		}
	}
}
