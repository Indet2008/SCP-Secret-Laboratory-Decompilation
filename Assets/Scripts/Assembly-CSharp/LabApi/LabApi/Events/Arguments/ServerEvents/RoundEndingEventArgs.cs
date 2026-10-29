namespace LabApi.Events.Arguments.ServerEvents
{
	public class RoundEndingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public RoundSummary.LeadingTeam LeadingTeam { get; set; }

		public RoundEndingEventArgs(RoundSummary.LeadingTeam leadingTeam)
		{
			IsAllowed = true;
			LeadingTeam = leadingTeam;
		}
	}
}
