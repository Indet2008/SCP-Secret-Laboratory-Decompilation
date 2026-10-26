using System.Collections.Generic;
using System.Text;
using Subtitles;

namespace Respawning.Announcements
{
	public class ChaosMiniwaveAnnouncement : WaveAnnouncementBase
	{
		public override void CreateAnnouncement(StringBuilder builder, List<ReferenceHub> spawnedPlayers, out SubtitlePart[] subtitles)
		{
			builder.Append("ACQUIRED ");
			builder.Append(spawnedPlayers.Count);
			builder.Append(" ADDITIONAL HOSTILEFORCES AT GATE A . DEFENSEMODULEUPDATED");
			subtitles = new SubtitlePart[1]
			{
				new SubtitlePart(SubtitleType.ChaosMiniwaveEntrance, spawnedPlayers.Count.ToString())
			};
		}
	}
}
