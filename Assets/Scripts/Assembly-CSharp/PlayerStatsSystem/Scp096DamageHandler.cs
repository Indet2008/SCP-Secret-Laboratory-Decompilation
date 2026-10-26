using System.Collections.Generic;
using Footprinting;
using PlayerRoles.PlayableScps.Scp096;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class Scp096DamageHandler : ScpDamageHandler
	{
		public enum AttackType
		{
			GateKill = 0,
			SlapLeft = 1,
			SlapRight = 2,
			Charge = 3
		}

		private static readonly Dictionary<AttackType, string> LogReasons = new Dictionary<AttackType, string>
		{
			[AttackType.SlapLeft] = "Got slapped by SCP-096's left hand",
			[AttackType.SlapRight] = "Got slapped by SCP-096's right hand",
			[AttackType.Charge] = "Stood in a line of SCP-096's charge",
			[AttackType.GateKill] = "Tried to pass through a gate being breached by SCP-096"
		};

		private readonly string _ragdollInspectText;

		private readonly AttackType _attackType;

		public override float Damage { get; set; }

		public override string RagdollInspectText => _ragdollInspectText;

		public override string DeathScreenText => string.Empty;

		public override CassieAnnouncement CassieDeathAnnouncement => new CassieAnnouncement();

		public override Footprint Attacker { get; protected set; }

		public override string ServerLogsText => LogReasons[_attackType] + " (" + Attacker.Nickname + ").";

		public override bool AllowSelfDamage => false;

		public Scp096DamageHandler(Scp096Role attacker, float damage, AttackType attackType)
		{
			Damage = damage;
			if (!(attacker == null) && attacker.TryGetOwner(out var hub))
			{
				_attackType = attackType;
				Attacker = new Footprint(hub);
			}
		}

		public override HandlerOutput ApplyDamage(ReferenceHub ply)
		{
			HandlerOutput result = base.ApplyDamage(ply);
			Vector3 normalized = (ply.transform.position - Attacker.Hub.transform.position).normalized;
			switch (_attackType)
			{
			case AttackType.Charge:
				StartVelocity = normalized * 8f;
				StartVelocity.y = 3.5f;
				break;
			case AttackType.SlapLeft:
			case AttackType.SlapRight:
			{
				Vector3 right = Attacker.Hub.PlayerCameraReference.right;
				if (_attackType == AttackType.SlapLeft)
				{
					right *= -1f;
				}
				right += Attacker.Hub.transform.forward;
				right += Vector3.up;
				StartVelocity = right * (Random.value + 1.5f) * 3f;
				break;
			}
			case AttackType.GateKill:
				StartVelocity = normalized * 2f;
				StartVelocity.y = -10f;
				break;
			}
			return result;
		}

		public Scp096DamageHandler()
		{
			_ragdollInspectText = DeathTranslations.Scp096.RagdollTranslation;
		}
	}
}
