using System.Collections.Generic;
using System.Text;
using MapGeneration.Holidays;
using PlayerRoles;
using Respawning.NamingRules;
using Subtitles;
using Utils.NonAllocLINQ;

namespace Respawning.Announcements
{
	public class NtfWaveAnnouncement : WaveAnnouncementBase
	{
		private readonly Team _team;

		public NtfWaveAnnouncement(Team team)
		{
			_team = team;
		}

		public override void CreateAnnouncement(StringBuilder builder, List<ReferenceHub> spawnedPlayers, out SubtitlePart[] subtitles)
		{
			if (!NamingRulesManager.TryGetNamingRule(_team, out var rule))
			{
				subtitles = null;
				return;
			}
			List<SubtitlePart> list = new List<SubtitlePart>();
			list.Add(new SubtitlePart(SubtitleType.NTFEntrance, rule.LastGeneratedName));
			List<SubtitlePart> list2 = list;
			string lastGeneratedName = rule.LastGeneratedName;
			int num = ReferenceHub.AllHubs.Count((ReferenceHub x) => x.IsSCP(includeZombies: false));
			string value = rule.TranslateToCassie(lastGeneratedName);
			if (HolidayUtils.IsHolidayActive(HolidayType.Christmas))
			{
				builder.Append("XMAS_EPSILON11 ");
				builder.Append(value);
				builder.Append(" XMAS_HASENTERED ");
				builder.Append(num);
				builder.Append(" XMAS_SCPSUBJECTS");
			}
			else
			{
				builder.Append("MTFUNIT EPSILON 11 DESIGNATED ");
				builder.Append(value);
				builder.Append(" HASENTERED ALLREMAINING ");
				if (num == 0)
				{
					builder.Append("NOSCPSLEFT");
					list2.Add(new SubtitlePart(SubtitleType.ThreatRemains, (string[])null));
				}
				else
				{
					builder.Append("AWAITINGRECONTAINMENT ");
					builder.Append(num);
					if (num == 1)
					{
						builder.Append(" SCPSUBJECT");
						list2.Add(new SubtitlePart(SubtitleType.AwaitContainSingle, (string[])null));
					}
					else
					{
						builder.Append(" SCPSUBJECTS");
						list2.Add(new SubtitlePart(SubtitleType.AwaitContainPlural, num.ToString()));
					}
				}
			}
			subtitles = list2.ToArray();
		}
	}
}
