using Footprinting;
using Subtitles;

namespace PlayerStatsSystem
{
	public class MarshmallowDamageHandler : AttackerDamageHandler
	{
		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage { get; }

		public override float Damage { get; set; }

		public override string RagdollInspectText { get; } = DeathTranslations.MarshmallowMan.RagdollTranslation;

		public override string DeathScreenText { get; } = DeathTranslations.MarshmallowMan.DeathscreenTranslation;

		public override string ServerLogsText { get; } = DeathTranslations.MarshmallowMan.LogLabel;

		protected override bool ForceFullFriendlyFire => true;

		public override bool IgnoreFriendlyFireDetector => true;

		public override CassieAnnouncement CassieDeathAnnouncement
		{
			get
			{
				CassieAnnouncement cassieAnnouncement = new CassieAnnouncement();
				cassieAnnouncement.Announcement = "TERMINATED BY MARSHMALLOW MAN";
				cassieAnnouncement.SubtitleParts = new SubtitlePart[1]
				{
					new SubtitlePart(SubtitleType.TerminatedByMarshmallowMan, (string[])null)
				};
				return cassieAnnouncement;
			}
		}

		public MarshmallowDamageHandler(Footprint attacker, float damage)
		{
			Attacker = attacker;
			Damage = damage;
		}
	}
}
