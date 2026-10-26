using PlayerRoles;
using Respawning.Announcements;
using Respawning.Config;

namespace Respawning.Waves
{
	public class ChaosMiniWave : MiniWaveBase<ChaosSpawnWave, NtfMiniWave>, IAnimatedWave, IAnnouncedWave
	{
		public override Faction TargetFaction => Faction.FoundationEnemy;

		public float AnimationDuration => 13.49f;

		public bool IsAnimationPlaying { get; set; }

		public WaveAnnouncementBase Announcement { get; } = new ChaosMiniwaveAnnouncement();

		public override IWaveConfig Configuration { get; } = new StandardWaveConfig<ChaosMiniWave>();

		public override RoleTypeId DefaultRole { get; set; } = RoleTypeId.ChaosRifleman;

		public override RoleTypeId SpecialRole { get; set; } = RoleTypeId.ChaosMarauder;
	}
}
