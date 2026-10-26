using Footprinting;
using PlayerStatsSystem;
using UnityEngine;

public class SnowballDamageHandler : AttackerDamageHandler
{
	private const float UpwardsForce = 2f;

	private const float HorizontalForce = 15f;

	private readonly Vector3 _moveDirection;

	public override float Damage { get; set; }

	public override Footprint Attacker { get; protected set; }

	public override bool AllowSelfDamage => true;

	public override string ServerLogsText => "Snowballed by " + Attacker.Nickname;

	public override string RagdollInspectText => DeathTranslations.Crushed.RagdollTranslation;

	public override string DeathScreenText => string.Empty;

	public SnowballDamageHandler()
	{
		Attacker = default;
		Damage = 0f;
		_moveDirection = Vector3.zero;
	}

	public SnowballDamageHandler(Footprint attacker, float damage, Vector3 moveDirection)
	{
		Attacker = attacker;
		Damage = damage;
		_moveDirection = moveDirection;
	}

	public override HandlerOutput ApplyDamage(ReferenceHub ply)
	{
		HealthStat module = ply.playerStats.GetModule<HealthStat>();
		ProcessDamage(ply);
		if (Damage <= 0f)
		{
			return HandlerOutput.Nothing;
		}
		module.CurValue -= Damage;
		StartVelocity += _moveDirection.NormalizeIgnoreY() * 15f + Vector3.up * 2f;
		if (!(module.CurValue <= 0f))
		{
			return HandlerOutput.Damaged;
		}
		return HandlerOutput.Death;
	}
}
