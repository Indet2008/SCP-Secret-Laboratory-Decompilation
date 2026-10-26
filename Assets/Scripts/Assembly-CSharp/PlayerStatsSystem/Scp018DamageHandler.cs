using Footprinting;
using InventorySystem.Items.ThrowableProjectiles;
using PlayerRoles.Ragdolls;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class Scp018DamageHandler : AttackerDamageHandler
	{
		private readonly string _deathScreenText;

		private readonly string _serverLogsText;

		private readonly string _ragdollInspectText;

		private readonly Vector3 _ballImpactVelocity;

		private const float ForceMultiplier = 0.5f;

		private const float HipMultiplier = 3f;

		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => true;

		public override string ServerLogsText => _serverLogsText;

		public override bool IgnoreFriendlyFireDetector => true;

		public override string RagdollInspectText => _ragdollInspectText;

		public override string DeathScreenText => _deathScreenText;

		public override HandlerOutput ApplyDamage(ReferenceHub ply)
		{
			HandlerOutput result = base.ApplyDamage(ply);
			StartVelocity = _ballImpactVelocity * 0.5f;
			return result;
		}

		public override void ProcessRagdoll(BasicRagdoll ragdoll)
		{
			base.ProcessRagdoll(ragdoll);
			if (!(ragdoll is DynamicRagdoll { Hitboxes: var hitboxes }))
			{
				return;
			}
			for (int i = 0; i < hitboxes.Length; i++)
			{
				HitboxData hitboxData = hitboxes[i];
				if (hitboxData.RelatedHitbox == HitboxType.Body)
				{
					hitboxData.Target.linearVelocity *= 3f;
				}
			}
		}

		public Scp018DamageHandler(Scp018Projectile ball, float dmg, bool ignoreFF)
		{
			_ragdollInspectText = DeathTranslations.Crushed.RagdollTranslation;
			_deathScreenText = DeathTranslations.Crushed.DeathscreenTranslation;
			if (dmg != 0f)
			{
				_ballImpactVelocity = ball.RecreatedVelocity;
				_serverLogsText = "SCP-018 thrown by: " + ball.PreviousOwner.Nickname;
				Attacker = ball.PreviousOwner;
				Damage = dmg;
				ForceFullFriendlyFire = ignoreFF;
			}
		}
	}
}
