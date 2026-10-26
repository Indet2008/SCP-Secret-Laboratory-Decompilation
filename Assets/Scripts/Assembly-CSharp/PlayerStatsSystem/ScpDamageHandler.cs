using Footprinting;
using Mirror;

namespace PlayerStatsSystem
{
	public class ScpDamageHandler : AttackerDamageHandler
	{
		private string _ragdollInspectText;

		private readonly byte _translationId;

		public override float Damage { get; set; }

		public override string RagdollInspectText => _ragdollInspectText;

		public override string DeathScreenText => string.Empty;

		public override CassieAnnouncement CassieDeathAnnouncement => new CassieAnnouncement();

		public override Footprint Attacker { get; protected set; }

		public override string ServerLogsText => "Died to SCP (" + Attacker.Nickname + ", " + Attacker.Role.ToString() + ")";

		public override bool AllowSelfDamage => false;

		public ScpDamageHandler()
		{
		}

		public ScpDamageHandler(ReferenceHub attacker, float damage, DeathTranslation deathReason)
		{
			Attacker = new Footprint(attacker);
			Damage = damage;
			_translationId = deathReason.Id;
			_ragdollInspectText = deathReason.RagdollTranslation;
		}

		public ScpDamageHandler(ReferenceHub attacker, DeathTranslation deathReason)
		{
			Attacker = new Footprint(attacker);
			Damage = -1f;
			_translationId = deathReason.Id;
			_ragdollInspectText = deathReason.RagdollTranslation;
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			writer.WriteByte(_translationId);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			DeathTranslations.TranslationsById.TryGetValue(reader.ReadByte(), out var _);
		}
	}
}
