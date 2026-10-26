using Footprinting;
using InventorySystem.Items.Armor;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class ExplosionDamageHandler : AttackerDamageHandler
	{
		private readonly string _deathScreenText;

		private readonly string _serverLogsText;

		private readonly string _ragdollInspectText;

		private readonly Vector3 _force;

		private const float ForceMultiplier = 1.3f;

		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => true;

		public override string ServerLogsText => _serverLogsText;

		public override string RagdollInspectText => _ragdollInspectText;

		public override string DeathScreenText => _deathScreenText;

		public ExplosionType ExplosionType { get; private set; }

		public override string ServerMetricsText => base.ServerMetricsText + "," + ExplosionType;

		public override HandlerOutput ApplyDamage(ReferenceHub ply)
		{
			HandlerOutput result = base.ApplyDamage(ply);
			StartVelocity += _force * 1.3f;
			return result;
		}

		public ExplosionDamageHandler(Footprint attacker, Vector3 force, float damage, int armorPenetration, ExplosionType explosionType)
		{
			if (armorPenetration != 0)
			{
				Attacker = attacker;
				ExplosionType = explosionType;
				_force = force;
				_serverLogsText = DeathTranslations.Explosion.LogLabel + " caused by " + attacker.Nickname;
				Damage = BodyArmorUtils.ProcessDamage((attacker.Hub != null && attacker.Hub.inventory.TryGetBodyArmor(out var bodyArmor)) ? bodyArmor.VestEfficacy : 0, damage, armorPenetration);
			}
		}
	}
}
