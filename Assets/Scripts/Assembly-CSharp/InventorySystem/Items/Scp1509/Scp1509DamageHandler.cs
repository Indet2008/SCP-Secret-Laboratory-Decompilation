using Footprinting;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509DamageHandler : AttackerDamageHandler
	{
		private const float ZombieDamageMultiplier = 2f;

		private const float UpwardsForce = 0.02f;

		private const float HorizontalForce = 0.05f;

		private readonly string _ragdollInspectText;

		private readonly Vector3 _moveDirection;

		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => false;

		public override string ServerLogsText => "Stabbed with SCP-1509 by " + Attacker.Nickname;

		public override string RagdollInspectText => _ragdollInspectText;

		public override string DeathScreenText => string.Empty;

		public Scp1509DamageHandler()
		{
			Attacker = default;
			Damage = 0f;
			_moveDirection = Vector3.zero;
			_ragdollInspectText = DeathTranslations.Scp1509.RagdollTranslation;
		}

		public Scp1509DamageHandler(ReferenceHub attacker, float damage, Vector3 moveDirection)
		{
			Attacker = new Footprint(attacker);
			Damage = damage;
			_moveDirection = moveDirection;
		}

		public override HandlerOutput ApplyDamage(ReferenceHub ply)
		{
			RoleTypeId roleId = ply.GetRoleId();
			if (roleId == RoleTypeId.Scp0492 || roleId == RoleTypeId.AlphaFlamingo || roleId == RoleTypeId.Flamingo || roleId == RoleTypeId.ZombieFlamingo)
			{
				Damage *= 2f;
			}
			HandlerOutput num = base.ApplyDamage(ply);
			StartVelocity += (_moveDirection.NormalizeIgnoreY() * 0.05f + Vector3.up * 0.02f) * (Damage / 2f);
			if (num == HandlerOutput.Death && Attacker.Hub.inventory.CurInstance != null)
			{
				(Attacker.Hub.inventory.CurInstance as Scp1509Item).ServerProcessKill(ply);
			}
			return num;
		}
	}
}
