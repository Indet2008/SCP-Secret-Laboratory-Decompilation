using Footprinting;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.ShotEvents;
using Mirror;
using PlayerRoles;
using PlayerRoles.Ragdolls;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class DisruptorDamageHandler : AttackerDamageHandler, DisintegrateDeathAnimation.IDisintegrateDamageHandler
	{
		private const float ZombieDamageMultiplier = 2f;

		private const float RagdollVelocity = 15f;

		private const float VerticalVelocity = 2f;

		private const float HumePenetration = 0.5f;

		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => true;

		public override string ServerLogsText => "Molecularly disrupted by " + Attacker.Nickname;

		public override string RagdollInspectText => "Molecularly disrupted.";

		public override string DeathScreenText => string.Empty;

		public DisruptorActionModule.FiringState FiringState { get; private set; }

		public bool Disintegrate => FiringState == DisruptorActionModule.FiringState.FiringSingle;

		public DisruptorDamageHandler(DisruptorShotEvent shotEvent, Vector3 flyDirection, float damage)
		{
			Damage = damage;
			if (shotEvent == null)
			{
				Attacker = default;
				FiringState = DisruptorActionModule.FiringState.None;
			}
			else
			{
				Attacker = shotEvent.HitregFootprint;
				FiringState = shotEvent.State;
			}
			StartVelocity = flyDirection.NormalizeIgnoreY() * 15f;
			StartVelocity.y = 2f;
		}

		public override HandlerOutput ApplyDamage(ReferenceHub ply)
		{
			if (ply.GetRoleId() == RoleTypeId.Scp0492)
			{
				Damage *= 2f;
			}
			switch (FiringState)
			{
			case DisruptorActionModule.FiringState.FiringRapid:
			{
				Vector3 startVelocity = StartVelocity;
				HandlerOutput result = base.ApplyDamage(ply);
				StartVelocity = startVelocity;
				return result;
			}
			case DisruptorActionModule.FiringState.FiringSingle:
			{
				float damage = Damage;
				Damage *= 0.5f;
				HandlerOutput handlerOutput = base.ApplyDamage(ply);
				if (handlerOutput == HandlerOutput.Death)
				{
					return handlerOutput;
				}
				Damage = damage * 0.5f;
				HealthStat module = ply.playerStats.GetModule<HealthStat>();
				ProcessDamage(ply);
				if (Damage <= 0f)
				{
					return handlerOutput;
				}
				base.DealtHealthDamage += Mathf.Min(module.CurValue, Damage);
				module.CurValue -= Damage;
				if (!(module.CurValue <= 0f))
				{
					return HandlerOutput.Damaged;
				}
				return HandlerOutput.Death;
			}
			default:
				return HandlerOutput.Nothing;
			}
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			writer.WriteByte((byte)FiringState);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			FiringState = (DisruptorActionModule.FiringState)reader.ReadByte();
		}

		public override void ProcessRagdoll(BasicRagdoll ragdoll)
		{
			if (FiringState == DisruptorActionModule.FiringState.FiringRapid)
			{
				base.ProcessRagdoll(ragdoll);
			}
		}
	}
}
