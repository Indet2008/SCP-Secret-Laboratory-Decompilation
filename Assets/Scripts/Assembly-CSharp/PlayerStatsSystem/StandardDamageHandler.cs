using CustomPlayerEffects;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Ragdolls;
using UnityEngine;

namespace PlayerStatsSystem
{
	public abstract class StandardDamageHandler : DamageHandlerBase
	{
		public const float KillValue = -1f;

		public HitboxType Hitbox;

		protected Vector3 StartVelocity;

		private short _velX;

		private short _velY;

		private short _velZ;

		public abstract float Damage { get; set; }

		public float DealtHealthDamage { get; protected set; }

		public float AbsorbedAhpDamage { get; protected set; }

		public float AbsorbedHumeDamage { get; protected set; }

		public float TotalDamageDealt => DealtHealthDamage + AbsorbedAhpDamage + AbsorbedHumeDamage;

		public override string ServerMetricsText => string.Empty;

		public override HandlerOutput ApplyDamage(ReferenceHub ply)
		{
			StartVelocity = ply.GetVelocity();
			StartVelocity.y = Mathf.Max(StartVelocity.y, 0f);
			PlayerStats playerStats = ply.playerStats;
			if (ply.roleManager.CurrentRole is IHealthbarRole healthbarRole && healthbarRole.TargetStats != playerStats)
			{
				return HandlerOutput.Nothing;
			}
			AhpStat module = playerStats.GetModule<AhpStat>();
			HealthStat module2 = playerStats.GetModule<HealthStat>();
			HumeShieldStat module3 = playerStats.GetModule<HumeShieldStat>();
			if (Damage == -1f)
			{
				module.CurValue = 0f;
				module2.CurValue = 0f;
				return HandlerOutput.Death;
			}
			ProcessDamage(ply);
			if (Damage <= 0f)
			{
				return HandlerOutput.Nothing;
			}
			float curValue = module2.CurValue;
			float num = module.ServerProcessDamage(Damage);
			AbsorbedAhpDamage = Damage - num;
			AbsorbedHumeDamage = Mathf.Min(module3.CurValue, num);
			float num2 = module3.CurValue - num;
			if (num2 < 0f)
			{
				module2.CurValue += num2;
			}
			module3.CurValue = num2;
			DealtHealthDamage = curValue - module2.CurValue;
			if (!(module2.CurValue <= 0f))
			{
				return HandlerOutput.Damaged;
			}
			return HandlerOutput.Death;
		}

		protected virtual void ProcessDamage(ReferenceHub ply)
		{
			StatusEffectBase[] allEffects = ply.playerEffectsController.AllEffects;
			for (int i = 0; i < allEffects.Length; i++)
			{
				if (allEffects[i] is IDamageModifierEffect { DamageModifierActive: not false } damageModifierEffect)
				{
					Damage *= damageModifierEffect.GetDamageModifier(Damage, this, Hitbox);
				}
			}
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			_velX = (short)Mathf.RoundToInt(StartVelocity.x * 100f);
			_velY = (short)Mathf.RoundToInt(StartVelocity.y * 100f);
			_velZ = (short)Mathf.RoundToInt(StartVelocity.z * 100f);
			writer.WriteShort(_velX);
			writer.WriteShort(_velY);
			writer.WriteShort(_velZ);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			_velX = reader.ReadShort();
			_velY = reader.ReadShort();
			_velZ = reader.ReadShort();
		}

		public override void ProcessRagdoll(BasicRagdoll ragdoll)
		{
			base.ProcessRagdoll(ragdoll);
			if (ragdoll is DynamicRagdoll dynamicRagdoll)
			{
				Vector3 linearVelocity = new Vector3(_velX, _velY, _velZ) / 100f;
				Rigidbody[] linkedRigidbodies = dynamicRagdoll.LinkedRigidbodies;
				for (int i = 0; i < linkedRigidbodies.Length; i++)
				{
					linkedRigidbodies[i].linearVelocity = linearVelocity;
				}
			}
		}
	}
}
