namespace LabApi.Events.Arguments.ServerEvents
{
	public class LczDecontaminationAnnouncedEventArgs : global::System.EventArgs
	{
		public int Phase { get; }

		public LczDecontaminationAnnouncedEventArgs(int phase)
		{
			Phase = phase;
		}
	}
}
