using System.Collections.Generic;
using MapGeneration.StaticHelpers;
using PlayerRoles;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerStatsSystem;
using UnityEngine;

public class HitboxIdentity : ModelReferencePoint, IDestructible, IBlockStaticBatching
{
	public static readonly HashSet<HitboxIdentity> Instances = new HashSet<HitboxIdentity>();

	[SerializeField]
	private HitboxType _dmgMultiplier;

	private int? _indexCache;

	private static bool AllowFriendlyFire => (ServerConfigSynchronizer.Singleton.MainBoolsSync & 1) == 1;

	public int Index
	{
		get
		{
			int valueOrDefault = _indexCache.GetValueOrDefault();
			if (!_indexCache.HasValue)
			{
				valueOrDefault = CharacterModel.Hitboxes.IndexOf(this);
				_indexCache = valueOrDefault;
				return valueOrDefault;
			}
			return valueOrDefault;
		}
	}

	public ReferenceHub TargetHub => CharacterModel.OwnerHub;

	public HitboxType HitboxType => _dmgMultiplier;

	public CharacterModel CharacterModel { get; private set; }

	public Collider[] TargetColliders { get; private set; }

	public uint NetworkId => TargetHub.inventory.netId;

	public Vector3 CenterOfMass => base.FastTr.position;

	public bool Damage(float damage, DamageHandlerBase handler, Vector3 exactPos)
	{
		if (TargetHub == null)
		{
			return false;
		}
		if (handler is StandardDamageHandler standardDamageHandler)
		{
			standardDamageHandler.Hitbox = _dmgMultiplier;
		}
		return TargetHub.playerStats.DealDamage(handler);
	}

	public void SetColliders(bool newState)
	{
		Collider[] targetColliders = TargetColliders;
		for (int i = 0; i < targetColliders.Length; i++)
		{
			targetColliders[i].enabled = newState;
		}
	}

	private void Awake()
	{
		CharacterModel = GetComponentInParent<CharacterModel>();
		TargetColliders = GetComponents<Collider>();
	}

	private void OnValidate()
	{
		Type |= RefpointType.Hitbox;
	}

	private void Reset()
	{
		Type = RefpointType.LineOfSightPoint | RefpointType.Hitbox;
	}

	private void OnDestroy()
	{
		Instances.Remove(this);
	}

	public static bool IsEnemy(ReferenceHub attacker, ReferenceHub victim)
	{
		return IsEnemy(attacker.GetTeam(), victim.GetTeam());
	}

	public static bool IsEnemy(RoleTypeId attackerRole, RoleTypeId victimRole)
	{
		Team team = attackerRole.GetTeam();
		Team team2 = victimRole.GetTeam();
		return IsEnemy(team, team2);
	}

	public static bool IsEnemy(Team attackerTeam, Team victimTeam)
	{
		if (attackerTeam == Team.Dead || victimTeam == Team.Dead)
		{
			return false;
		}
		if (attackerTeam == Team.SCPs && victimTeam == Team.SCPs)
		{
			return false;
		}
		return attackerTeam.GetFaction() != victimTeam.GetFaction();
	}

	public static bool IsDamageable(ReferenceHub attacker, ReferenceHub victim)
	{
		if (!AllowFriendlyFire)
		{
			return IsEnemy(attacker, victim);
		}
		return true;
	}

	public static bool IsDamageable(RoleTypeId attackerRole, RoleTypeId victimRole)
	{
		if (!AllowFriendlyFire)
		{
			return IsEnemy(attackerRole, victimRole);
		}
		return true;
	}

	public static bool IsDamageable(Team attackerTeam, Team victimTeam)
	{
		if (!AllowFriendlyFire)
		{
			return IsEnemy(attackerTeam, victimTeam);
		}
		if (attackerTeam == Team.Dead || victimTeam == Team.Dead)
		{
			return false;
		}
		if (attackerTeam == Team.SCPs && victimTeam == Team.SCPs)
		{
			return false;
		}
		return true;
	}
}
