using Footprinting;

namespace PlayerStatsSystem
{
	public class RecontainmentDamageHandler : AttackerDamageHandler
	{
		private readonly string _ragdollinspectText;

		private readonly string _deathscreenText;

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => true;

		public override float Damage { get; set; }

		public override string RagdollInspectText => _ragdollinspectText;

		public override string DeathScreenText => _deathscreenText;

		public override string ServerLogsText => "Recontained by " + Attacker.Nickname;

		public RecontainmentDamageHandler(Footprint attacker)
		{
			Attacker = attacker;
			Damage = -1f;
			_ragdollinspectText = DeathTranslations.Recontained.RagdollTranslation;
			_deathscreenText = DeathTranslations.Recontained.DeathscreenTranslation;
		}
	}
}
