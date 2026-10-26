using Mirror;

namespace PlayerStatsSystem
{
	public class UniversalDamageHandler : StandardDamageHandler
	{
		private string _ragdollInspectText;

		private string _deathscreenText;

		private string _logsText;

		private readonly CassieAnnouncement _cassieAnnouncement;

		public readonly byte TranslationId;

		public override float Damage { get; set; }

		public override string RagdollInspectText => _ragdollInspectText;

		public override string DeathScreenText => _deathscreenText;

		public override CassieAnnouncement CassieDeathAnnouncement => _cassieAnnouncement;

		public override string ServerLogsText => _logsText;

		public override string ServerMetricsText
		{
			get
			{
				byte translationId = TranslationId;
				return translationId.ToString();
			}
		}

		public UniversalDamageHandler()
		{
			TranslationId = 0;
			_cassieAnnouncement = CassieAnnouncement.Default;
		}

		public UniversalDamageHandler(float damage, DeathTranslation deathReason, CassieAnnouncement cassieAnnouncement = null)
		{
			Damage = damage;
			ApplyTranslation(deathReason);
			TranslationId = deathReason.Id;
			_cassieAnnouncement = cassieAnnouncement ?? CassieAnnouncement.Default;
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			writer.WriteByte(TranslationId);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			if (DeathTranslations.TranslationsById.TryGetValue(reader.ReadByte(), out var value))
			{
				ApplyTranslation(value);
			}
		}

		private void ApplyTranslation(DeathTranslation translation)
		{
			_ragdollInspectText = translation.RagdollTranslation;
			_deathscreenText = translation.DeathscreenTranslation;
			_logsText = translation.LogLabel;
		}
	}
}
