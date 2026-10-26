using Mirror;
using Subtitles;

namespace Cassie
{
	public readonly struct CassieTtsPayload : NetworkMessage
	{
		public enum SubtitleMode
		{
			None = 0,
			Automatic = 1,
			Custom = 2,
			FromTranslation = 3
		}

		public readonly string Content;

		public readonly SubtitleMode SubtitleSource;

		public readonly bool PlayBackground;

		private readonly SubtitleMessage _subtitleMessage;

		private readonly string _customSubtitle;

		private static readonly Subtitle CustomSubtitleSettings = new Subtitle
		{
			SubtitleCategory = CassieAnnouncementType.Normal
		};

		public void PlaySubtitleMessage()
		{
			if (!(SubtitleController.Singleton == null))
			{
				SubtitleController.Singleton.ClearSubtitles(CassieAnnouncementType.Normal);
				SubtitleController.Singleton.SetupSubtitle(_subtitleMessage.SubtitleParts);
			}
		}

		public void PlayOtherSubtitle(double duration, string valueOverride = null)
		{
			if (!(SubtitleController.Singleton == null))
			{
				SubtitleController.Singleton.ClearSubtitles(CassieAnnouncementType.Normal);
				string text = valueOverride ?? _customSubtitle;
				if (!string.IsNullOrEmpty(text))
				{
					CustomSubtitleSettings.Delay = (PlayBackground ? 2.5f : 0f);
					SubtitleController.Singleton.AddSubtitle(text, (float)duration, CustomSubtitleSettings);
				}
			}
		}

		public void WriteSelf(NetworkWriter writer)
		{
			writer.WriteString(Content);
			int num = (int)SubtitleSource;
			if (PlayBackground)
			{
				num += 127;
			}
			writer.WriteByte((byte)num);
			switch (SubtitleSource)
			{
			case SubtitleMode.Custom:
				writer.WriteString(_customSubtitle);
				break;
			case SubtitleMode.FromTranslation:
				writer.WriteSubtitleMessage(_subtitleMessage);
				break;
			}
		}

		public CassieTtsPayload(string customAnnouncement, bool autoGenerateSubtitles = true, bool playBackground = true)
		{
			_subtitleMessage = default;
			_customSubtitle = null;
			Content = customAnnouncement;
			PlayBackground = playBackground;
			SubtitleSource = (autoGenerateSubtitles ? SubtitleMode.Automatic : SubtitleMode.None);
		}

		public CassieTtsPayload(string customAnnouncement, string customSubtitles, bool playBackground = true)
		{
			_subtitleMessage = default;
			Content = customAnnouncement;
			PlayBackground = playBackground;
			SubtitleSource = SubtitleMode.Custom;
			_customSubtitle = customSubtitles;
		}

		public CassieTtsPayload(string announcement, bool playBackground, params SubtitlePart[] subtitleParts)
		{
			_customSubtitle = null;
			Content = announcement;
			PlayBackground = playBackground;
			SubtitleSource = SubtitleMode.FromTranslation;
			_subtitleMessage = new SubtitleMessage(subtitleParts);
		}

		public CassieTtsPayload(string announcement, params SubtitlePart[] subtitleParts)
			: this(announcement, playBackground: true, subtitleParts)
		{
		}

		public CassieTtsPayload(NetworkReader reader)
		{
			_subtitleMessage = default;
			_customSubtitle = null;
			Content = reader.ReadString();
			int num = reader.ReadByte();
			if (num < 127)
			{
				PlayBackground = false;
				SubtitleSource = (SubtitleMode)num;
			}
			else
			{
				PlayBackground = true;
				SubtitleSource = (SubtitleMode)(num - 127);
			}
			switch (SubtitleSource)
			{
			case SubtitleMode.Custom:
				_customSubtitle = reader.ReadString();
				break;
			case SubtitleMode.FromTranslation:
				_subtitleMessage = reader.ReadSubtitleMessage();
				break;
			}
		}

		public CassieTtsPayload(CassieTtsPayload original, string announcement)
		{
			Content = announcement;
			SubtitleSource = original.SubtitleSource;
			PlayBackground = original.PlayBackground;
			_subtitleMessage = original._subtitleMessage;
			_customSubtitle = original._customSubtitle;
		}
	}
}
