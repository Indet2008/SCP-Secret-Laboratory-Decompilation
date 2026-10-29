namespace LabApi.Events.Arguments.WarheadEvents
{
	public class WarheadStoppingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public AlphaWarheadSyncInfo WarheadState { get; set; }

		public bool IsAllowed { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; set; }

		public WarheadStoppingEventArgs(ReferenceHub hub, AlphaWarheadSyncInfo warheadState)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			WarheadState = warheadState;
		}
	}
}
