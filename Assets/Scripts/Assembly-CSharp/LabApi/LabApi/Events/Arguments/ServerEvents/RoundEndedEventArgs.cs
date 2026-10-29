namespace LabApi.Events.Arguments.ServerEvents
{
	public class RoundEndedEventArgs : global::System.EventArgs
	{
		public RoundSummary.LeadingTeam LeadingTeam { get; }

		public bool ShowSummary { get; set; }

		public RoundEndedEventArgs(RoundSummary.LeadingTeam leadingTeam)
		{
			ShowSummary = true;
			LeadingTeam = leadingTeam;
		}
	}
}
