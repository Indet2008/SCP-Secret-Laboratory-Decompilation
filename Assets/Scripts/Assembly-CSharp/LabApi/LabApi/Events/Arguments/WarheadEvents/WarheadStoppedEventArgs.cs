namespace LabApi.Events.Arguments.WarheadEvents
{
	public class WarheadStoppedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public AlphaWarheadSyncInfo WarheadState { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public WarheadStoppedEventArgs(ReferenceHub hub, AlphaWarheadSyncInfo warheadState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			WarheadState = warheadState;
		}
	}
}
