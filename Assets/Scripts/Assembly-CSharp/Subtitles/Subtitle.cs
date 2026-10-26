using System;

namespace Subtitles
{
	[Serializable]
	public class Subtitle
	{
		public SubtitleType SubtitleTypeValue = SubtitleType.None;

		public CassieAnnouncementType SubtitleCategory = CassieAnnouncementType.Normal;

		public string DefaultValue;

		public float Duration;

		public bool RequestSpace = true;

		public float Delay = 2.5f;

		public bool ConvertNumbers;
	}
}
