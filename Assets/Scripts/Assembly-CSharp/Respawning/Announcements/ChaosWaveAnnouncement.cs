using System.Collections.Generic;
using System.Text;
using Subtitles;

namespace Respawning.Announcements
{
	public class ChaosWaveAnnouncement : WaveAnnouncementBase
	{
		public override void CreateAnnouncement(StringBuilder builder, List<ReferenceHub> spawnedPlayers, out SubtitlePart[] subtitles)
		{
			builder.Append("ATTENTIONALLPERSONNEL . DETECTED ");
			builder.Append(spawnedPlayers.Count);
			builder.Append(" CHAOSINSURGENCY FORCES AT GATE A . LETHALFORCEAUTHORIZED");
			subtitles = new SubtitlePart[1]
			{
				new SubtitlePart(SubtitleType.ChaosEntrance, spawnedPlayers.Count.ToString())
			};
		}
	}
}
