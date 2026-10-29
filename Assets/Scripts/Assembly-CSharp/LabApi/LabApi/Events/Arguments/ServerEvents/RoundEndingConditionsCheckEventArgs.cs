namespace LabApi.Events.Arguments.ServerEvents
{
	public class RoundEndingConditionsCheckEventArgs : global::System.EventArgs
	{
		public bool CanEnd { get; set; }

		public RoundEndingConditionsCheckEventArgs(bool canEnd)
		{
			CanEnd = canEnd;
		}
	}
}
