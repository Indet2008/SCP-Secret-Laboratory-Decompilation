using Footprinting;
using PlayerStatsSystem;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507DamageHandler : AttackerDamageHandler
	{
		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => false;

		public override string ServerLogsText => "Pecked by " + Attacker.Nickname;

		public override string RagdollInspectText => DeathTranslations.Scp1507Peck.RagdollTranslation;

		public override string DeathScreenText => string.Empty;

		public Scp1507DamageHandler(Footprint attacker, float damage)
		{
			Attacker = attacker;
			Damage = damage;
		}
	}
}
