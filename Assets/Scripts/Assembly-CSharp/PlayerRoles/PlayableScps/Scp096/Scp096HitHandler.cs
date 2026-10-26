using System;
using System.Collections.Generic;
using Footprinting;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096HitHandler
	{
		private static readonly Collider[] Hits = new Collider[32];

		private static readonly CachedLayerMask SolidObjectMask = new CachedLayerMask("Default", "Door", "Glass");

		private static readonly CachedLayerMask AttackHitMask = new CachedLayerMask("Hitbox", "Door", "Glass");

		private readonly Scp096TargetsTracker _targetCounter;

		private readonly HashSet<uint> _hitNetIDs;

		private readonly Scp096Role _scpRole;

		private readonly float _windowDamage;

		private readonly float _doorDamage;

		private readonly float _humanTargetDamage;

		private readonly float _humanNontargetDamage;

		private readonly Scp096DamageHandler.AttackType _damageType;

		public Scp096HitResult HitResult { get; private set; }

		public event Action<ReferenceHub> OnPlayerHit;

		public event Action<BreakableWindow> OnWindowHit;

		public event Action<IDamageableDoor> OnDoorHit;

		public Scp096HitHandler(Scp096Role scpRole, Scp096DamageHandler.AttackType damageType, float windowDamage, float doorDamage, float humanTargetDamage, float humanNontargetDamage)
		{
			_scpRole = scpRole;
			_damageType = damageType;
			_windowDamage = windowDamage;
			_doorDamage = doorDamage;
			_humanTargetDamage = humanTargetDamage;
			_humanNontargetDamage = humanNontargetDamage;
			HitResult = Scp096HitResult.None;
			_hitNetIDs = new HashSet<uint>();
			_scpRole.SubroutineModule.TryGetSubroutine<Scp096TargetsTracker>(out _targetCounter);
		}

		public void Clear()
		{
			_hitNetIDs.Clear();
			HitResult = Scp096HitResult.None;
		}

		public Scp096HitResult DamageSphere(Vector3 position, float radius)
		{
			return ProcessHits(Physics.OverlapSphereNonAlloc(position, radius, Hits, AttackHitMask));
		}

		public Scp096HitResult DamageBox(Vector3 position, Vector3 halfExtents, Quaternion orientation)
		{
			return ProcessHits(Physics.OverlapBoxNonAlloc(position, halfExtents, Hits, orientation, AttackHitMask));
		}

		private Scp096HitResult ProcessHits(int count)
		{
			Scp096HitResult scp096HitResult = Scp096HitResult.None;
			Footprint attacker = default;
			if (_scpRole.TryGetOwner(out var hub))
			{
				attacker = new Footprint(hub);
			}
			for (int i = 0; i < count; i++)
			{
				Collider collider = Hits[i];
				CheckDoorHit(collider, attacker);
				if (!collider.TryGetComponent<IDestructible>(out var component))
				{
					continue;
				}
				int layerMask = (int)SolidObjectMask & ~(1 << collider.gameObject.layer);
				if (Physics.Linecast(_scpRole.CameraPosition, component.CenterOfMass, layerMask) || !_hitNetIDs.Add(component.NetworkId))
				{
					continue;
				}
				if (component is BreakableWindow breakableWindow)
				{
					if (DealDamage(breakableWindow, _windowDamage))
					{
						scp096HitResult |= Scp096HitResult.Window;
						OnWindowHit?.Invoke(breakableWindow);
					}
				}
				else
				{
					if (!(component is HitboxIdentity hitboxIdentity) || !HitboxIdentity.IsEnemy(Team.SCPs, hitboxIdentity.TargetHub.GetTeam()))
					{
						continue;
					}
					ReferenceHub targetHub = hitboxIdentity.TargetHub;
					bool flag = _targetCounter.HasTarget(targetHub);
					if (DealDamage(hitboxIdentity, flag ? _humanTargetDamage : _humanNontargetDamage))
					{
						scp096HitResult |= Scp096HitResult.Human;
						OnPlayerHit?.Invoke(targetHub);
						if (!targetHub.IsAlive())
						{
							scp096HitResult |= Scp096HitResult.Lethal;
						}
					}
				}
			}
			HitResult |= scp096HitResult;
			return scp096HitResult;
		}

		private bool DealDamage(IDestructible target, float dmg)
		{
			if (dmg <= 0f)
			{
				return false;
			}
			Scp096DamageHandler handler = new Scp096DamageHandler(_scpRole, dmg, _damageType);
			return target.Damage(dmg, handler, _scpRole.FpcModule.Position);
		}

		private void CheckDoorHit(Collider col, Footprint attacker)
		{
			IDamageableDoor componentInParent = col.GetComponentInParent<IDamageableDoor>();
			if (componentInParent != null && componentInParent is NetworkBehaviour networkBehaviour && _hitNetIDs.Add(networkBehaviour.netId) && componentInParent.ServerDamage(_doorDamage, DoorDamageType.Scp096, attacker))
			{
				HitResult |= Scp096HitResult.Door;
				OnDoorHit?.Invoke(componentInParent);
			}
		}
	}
}
