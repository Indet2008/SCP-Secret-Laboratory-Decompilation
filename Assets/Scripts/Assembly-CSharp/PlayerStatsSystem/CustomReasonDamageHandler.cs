using Mirror;
using Subtitles;

namespace PlayerStatsSystem
{
	public class CustomReasonDamageHandler : StandardDamageHandler
	{
		private string _deathReason;

		private readonly CassieAnnouncement _cassieAnnouncement;

		public override float Damage { get; set; }

		public override string RagdollInspectText => _deathReason;

		public override string DeathScreenText => _deathReason;

		public override CassieAnnouncement CassieDeathAnnouncement => _cassieAnnouncement;

		public override string ServerLogsText => "Killed with a custom reason - " + _deathReason;

		public CustomReasonDamageHandler(string customReason)
		{
			_deathReason = customReason;
			Damage = -1f;
			_cassieAnnouncement = new CassieAnnouncement();
		}

		public CustomReasonDamageHandler(string customReason, float damage, string customCassieAnnouncement = "")
		{
			_deathReason = customReason;
			Damage = damage;
			_cassieAnnouncement = new CassieAnnouncement();
			_cassieAnnouncement.Announcement = customCassieAnnouncement;
			_cassieAnnouncement.SubtitleParts = new SubtitlePart[1]
			{
				new SubtitlePart(SubtitleType.Custom, customCassieAnnouncement)
			};
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			writer.WriteString(_deathReason);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			_deathReason = reader.ReadString();
		}
	}
}
