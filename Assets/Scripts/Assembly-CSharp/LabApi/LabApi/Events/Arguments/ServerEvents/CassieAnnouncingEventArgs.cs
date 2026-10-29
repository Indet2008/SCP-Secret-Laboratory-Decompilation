namespace LabApi.Events.Arguments.ServerEvents
{
	public class CassieAnnouncingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public string Words { get; set; }

		public bool MakeHold { get; set; }

		public bool MakeNoise { get; set; }

		public bool CustomAnnouncement { get; set; }

		public string CustomSubtitles { get; set; }

		public bool IsAllowed { get; set; }

		public CassieAnnouncingEventArgs(string words, bool makeHold, bool makeNoise, bool customAnnouncement, string customSubtitles)
		{
			IsAllowed = true;
			Words = words;
			MakeHold = makeHold;
			MakeNoise = makeNoise;
			CustomAnnouncement = customAnnouncement;
			CustomSubtitles = customSubtitles;
		}
	}
}
