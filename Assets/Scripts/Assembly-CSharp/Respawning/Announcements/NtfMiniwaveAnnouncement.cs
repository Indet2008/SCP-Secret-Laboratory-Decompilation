using System.Collections.Generic;
using System.Text;
using PlayerRoles;
using Subtitles;
using Utils.NonAllocLINQ;

namespace Respawning.Announcements
{
	public class NtfMiniwaveAnnouncement : WaveAnnouncementBase
	{
		public override void CreateAnnouncement(StringBuilder builder, List<ReferenceHub> spawnedPlayers, out SubtitlePart[] subtitles)
		{
			builder.Append("NINETAILEDFOXBACKUPUNIT HASENTERED ");
			List<SubtitlePart> list = new List<SubtitlePart>
			{
				new SubtitlePart(SubtitleType.NTFMiniwaveEntrance)
			};
			int num = ReferenceHub.AllHubs.Count((ReferenceHub x) => x.IsSCP(includeZombies: false));
			if (num == 0)
			{
				list.Add(new SubtitlePart(SubtitleType.ThreatRemains, (string[])null));
				builder.Append("NOSCPSLEFT");
			}
			else
			{
				builder.Append("AWAITINGRECONTAINMENT ");
				builder.Append(num);
				if (num == 1)
				{
					builder.Append(" SCPSUBJECT");
					list.Add(new SubtitlePart(SubtitleType.AwaitContainSingle, (string[])null));
				}
				else
				{
					builder.Append(" SCPSUBJECTS");
					list.Add(new SubtitlePart(SubtitleType.AwaitContainPlural, num.ToString()));
				}
			}
			subtitles = list.ToArray();
		}
	}
}
