namespace LabApi.Events.Arguments.ServerEvents
{
	public class CassieAnnouncedEventArgs : global::System.EventArgs
	{
		public string Words { get; }

		public bool MakeHold { get; }

		public bool MakeNoise { get; }

		public bool CustomAnnouncement { get; }

		public string CustomSubtitles { get; }

		public CassieAnnouncedEventArgs(string words, bool makeHold, bool makeNoise, bool customAnnouncement, string customSubtitles)
		{
			Words = words;
			MakeHold = makeHold;
			MakeNoise = makeNoise;
			CustomAnnouncement = customAnnouncement;
			CustomSubtitles = customSubtitles;
		}
	}
}
