namespace LabApi.Events.Arguments.WarheadEvents
{
	public class WarheadStartingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAutomatic { get; set; }

		public bool SuppressSubtitles { get; set; }

		public AlphaWarheadSyncInfo WarheadState { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; set; }

		public bool IsAllowed { get; set; }

		public WarheadStartingEventArgs(ReferenceHub hub, bool isAutomatic, bool suppressSubtitles, AlphaWarheadSyncInfo warheadState)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsAutomatic = isAutomatic;
			SuppressSubtitles = suppressSubtitles;
			WarheadState = warheadState;
		}
	}
}
