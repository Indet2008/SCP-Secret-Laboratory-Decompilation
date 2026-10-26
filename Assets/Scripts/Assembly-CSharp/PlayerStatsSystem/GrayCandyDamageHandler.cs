using Footprinting;

namespace PlayerStatsSystem
{
	public class GrayCandyDamageHandler : AttackerDamageHandler
	{
		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => false;

		public override string ServerLogsText => "Metal piped by " + Attacker.Nickname;

		public override string RagdollInspectText => "Killed by metal pipe falling, lmao.";

		public override string DeathScreenText => string.Empty;

		public GrayCandyDamageHandler()
		{
			Attacker = default;
			Damage = 0f;
		}

		public GrayCandyDamageHandler(ReferenceHub attacker, float damage)
		{
			Attacker = new Footprint(attacker);
			Damage = damage;
		}
	}
}
