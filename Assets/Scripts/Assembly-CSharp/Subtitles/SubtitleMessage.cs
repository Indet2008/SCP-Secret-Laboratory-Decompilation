using Mirror;

namespace Subtitles
{
	public struct SubtitleMessage : NetworkMessage
	{
		public SubtitlePart[] SubtitleParts;

		public SubtitleMessage(params SubtitlePart[] subtitleParts)
		{
			SubtitleParts = subtitleParts;
		}
	}
}
