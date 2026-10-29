namespace LabApi.Events.Arguments.WarheadEvents
{
	public class WarheadStartedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public bool IsAutomatic { get; }

		public bool SuppressSubtitles { get; }

		public AlphaWarheadSyncInfo WarheadState { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public WarheadStartedEventArgs(ReferenceHub hub, bool isAutomatic, bool suppressSubtitles, AlphaWarheadSyncInfo warheadState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsAutomatic = isAutomatic;
			SuppressSubtitles = suppressSubtitles;
			WarheadState = warheadState;
		}
	}
}
