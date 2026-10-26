using PlayerRoles;
using Respawning.Announcements;
using Respawning.Config;

namespace Respawning.Waves
{
	public class NtfMiniWave : MiniWaveBase<NtfSpawnWave, ChaosMiniWave>, IAnimatedWave, IAnnouncedWave
	{
		public override Faction TargetFaction => Faction.FoundationStaff;

		public float AnimationDuration => 17.95f;

		public bool IsAnimationPlaying { get; set; }

		public WaveAnnouncementBase Announcement { get; } = new NtfMiniwaveAnnouncement();

		public override IWaveConfig Configuration { get; } = new StandardWaveConfig<NtfMiniWave>();

		public override RoleTypeId DefaultRole { get; set; } = RoleTypeId.NtfPrivate;

		public override RoleTypeId SpecialRole { get; set; } = RoleTypeId.NtfSergeant;
	}
}
