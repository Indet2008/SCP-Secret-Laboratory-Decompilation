using System.Collections.Generic;
using System.Text;
using Cassie;
using NorthwoodLib.Pools;
using Respawning.Waves;
using Subtitles;

namespace Respawning.Announcements
{
	public abstract class WaveAnnouncementBase
	{
		public abstract void CreateAnnouncement(StringBuilder builder, List<ReferenceHub> spawnedPlayers, out SubtitlePart[] subtitles);

		public virtual void PlayAnnouncement(List<ReferenceHub> spawnedPlayers, IAnnouncedWave wave)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			CreateAnnouncement(stringBuilder, spawnedPlayers, out var subtitles);
			string announcement = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			CassieTtsPayload payload = new CassieTtsPayload(announcement, subtitles);
			new CassieWaveAnnouncement(wave, payload).AddToQueue();
		}
	}
}
