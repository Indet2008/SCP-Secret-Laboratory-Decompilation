using System;
using Respawning.Waves;

namespace Cassie
{
	public class CassieWaveAnnouncement : CassieAnnouncement
	{
		public readonly IAnnouncedWave Wave;

		public static event Action<CassieWaveAnnouncement> OnAnnouncementFinishedPlaying;

		public CassieWaveAnnouncement(IAnnouncedWave wave, CassieTtsPayload payload)
			: base(payload)
		{
			Wave = wave;
		}

		public override void OnFinishedPlaying()
		{
			base.OnFinishedPlaying();
			OnAnnouncementFinishedPlaying?.Invoke(this);
		}
	}
}
