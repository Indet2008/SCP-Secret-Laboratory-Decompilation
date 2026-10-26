using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using Footprinting;
using Interactables;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class ExplosionGrenade : EffectGrenade
	{
		[Header("Hitreg")]
		public LayerMask DetectionMask;

		public float MaxRadius;

		public float ScpDamageMultiplier;

		[Header("Curves")]
		[SerializeField]
		private AnimationCurve _playerDamageOverDistance;

		[SerializeField]
		private AnimationCurve _effectDurationOverDistance;

		[SerializeField]
		private AnimationCurve _doorDamageOverDistance;

		[SerializeField]
		private AnimationCurve _shakeOverDistance;

		[Header("Player Effects")]
		[SerializeField]
		private float _burnedDuration;

		[SerializeField]
		private float _deafenedDuration;

		[SerializeField]
		private float _concussedDuration;

		[SerializeField]
		private float _minimalDuration;

		[Header("Physics")]
		[SerializeField]
		private float _rigidbodyBaseForce;

		[SerializeField]
		private float _rigidbodyLiftForce;

		[SerializeField]
		private float _humeShieldMultipler;

		private const float MinimalMass = 0.5f;

		private const float MaxMass = 10f;

		private const float MassFactor = 3f;

		public static event Action<Footprint, Vector3, ExplosionGrenade> OnExploded = (Footprint attacker, Vector3 position, ExplosionGrenade settingsReference) =>
		{
		};

		public override void PlayExplosionEffects(Vector3 pos)
		{
			base.PlayExplosionEffects(pos);
			if (MainCameraController.InstanceActive)
			{
				float time = Vector3.Distance(MainCameraController.CurrentCamera.position, pos);
				ExplosionCameraShake.singleton.Shake(_shakeOverDistance.Evaluate(time));
				if (NetworkServer.active)
				{
					Explode(PreviousOwner, pos, this, ExplosionType.Grenade);
				}
			}
		}

		public override bool ServerFuseEnd()
		{
			if (!base.ServerFuseEnd())
			{
				return false;
			}
			Explode(PreviousOwner, base.transform.position, this, ExplosionType.Grenade);
			ServerEvents.OnProjectileExploded(new ProjectileExplodedEventArgs(this, PreviousOwner.Hub, base.transform.position));
			return true;
		}

		public static void Explode(Footprint attacker, Vector3 position, ExplosionGrenade settingsReference, ExplosionType explosionType)
		{
			bool destroyDoors = true;
			ExplosionSpawningEventArgs e = new ExplosionSpawningEventArgs(attacker.Hub, position, settingsReference, explosionType, destroyDoors);
			ServerEvents.OnExplosionSpawning(e);
			if (!e.IsAllowed)
			{
				return;
			}
			position = e.Position;
			settingsReference = e.Settings;
			destroyDoors = e.DestroyDoors;
			explosionType = e.ExplosionType;
			if (attacker.Hub != e.Player?.ReferenceHub)
			{
				attacker = new Footprint(e.Player?.ReferenceHub);
			}
			SetHostHitboxes(state: true);
			HashSet<uint> hashSet = HashSetPool<uint>.Shared.Rent();
			HashSet<uint> hashSet2 = HashSetPool<uint>.Shared.Rent();
			float maxRadius = settingsReference.MaxRadius;
			Collider[] array = Physics.OverlapSphere(position, maxRadius, settingsReference.DetectionMask);
			DoorVariant doorVariant = default;
			foreach (Collider collider in array)
			{
				if (NetworkServer.active)
				{
					if (collider.TryGetComponent<IExplosionTrigger>(out var component))
					{
						component.OnExplosionDetected(attacker, position, maxRadius);
					}
					if (collider.TryGetComponent<IDestructible>(out var component2))
					{
						if (!hashSet.Contains(component2.NetworkId) && ExplodeDestructible(component2, attacker, position, settingsReference, explosionType))
						{
							hashSet.Add(component2.NetworkId);
						}
					}
					else
					{
						int num;
						if (collider.TryGetComponent<InteractableCollider>(out var component3))
						{
							doorVariant = component3.Target as DoorVariant;
							num = (((object)doorVariant != null) ? 1 : 0);
						}
						else
						{
							num = 0;
						}
						if (((uint)num & (destroyDoors ? 1u : 0u)) != 0 && hashSet2.Add(doorVariant.netId))
						{
							ExplodeDoor(doorVariant, position, settingsReference, attacker);
						}
					}
				}
				if (collider.attachedRigidbody != null)
				{
					ExplodeRigidbody(collider.attachedRigidbody, position, maxRadius, settingsReference);
				}
			}
			HashSetPool<uint>.Shared.Return(hashSet);
			HashSetPool<uint>.Shared.Return(hashSet2);
			OnExploded?.Invoke(attacker, position, settingsReference);
			ServerEvents.OnExplosionSpawned(new ExplosionSpawnedEventArgs(attacker.Hub, position, settingsReference, explosionType, destroyDoors));
			SetHostHitboxes(state: false);
		}

		private static void SetHostHitboxes(bool state)
		{
			if (NetworkServer.active && ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				HitboxIdentity[] hitboxes = fpcRole.FpcModule.CharacterModelInstance.Hitboxes;
				for (int i = 0; i < hitboxes.Length; i++)
				{
					hitboxes[i].SetColliders(state);
				}
			}
		}

		private static void ExplodeRigidbody(Rigidbody rb, Vector3 pos, float radius, ExplosionGrenade setts)
		{
			if (!rb.isKinematic && !Physics.Linecast(rb.gameObject.transform.position, pos, ThrownProjectile.HitBlockerMask))
			{
				float num = Mathf.Clamp01(Mathf.InverseLerp(0.5f, 10f, rb.mass)) * 3f + 1f;
				rb.AddExplosionForce(setts._rigidbodyBaseForce / num, pos, radius, setts._rigidbodyLiftForce / num, ForceMode.VelocityChange);
			}
		}

		private static bool ExplodeDestructible(IDestructible dest, Footprint attacker, Vector3 pos, ExplosionGrenade setts, ExplosionType explosionType)
		{
			if (Physics.Linecast(dest.CenterOfMass, pos, ThrownProjectile.HitBlockerMask))
			{
				return false;
			}
			Vector3 vector = dest.CenterOfMass - pos;
			float magnitude = vector.magnitude;
			float num = setts._playerDamageOverDistance.Evaluate(magnitude);
			bool flag = ReferenceHub.TryGetHubNetID(dest.NetworkId, out var hub);
			if (flag && hub.GetRoleId().GetTeam() == Team.SCPs)
			{
				num *= setts.ScpDamageMultiplier;
				if (hub.playerStats.TryGetModule<HumeShieldStat>(out var module))
				{
					num = ((!(num * setts._humeShieldMultipler < module.CurValue)) ? (num + module.CurValue / setts._humeShieldMultipler) : (num * setts._humeShieldMultipler));
				}
			}
			Vector3 force = (1f - magnitude / setts.MaxRadius) * (vector / magnitude) * setts._rigidbodyBaseForce + Vector3.up * setts._rigidbodyLiftForce;
			if ((num > 0f && dest.Damage(num, new ExplosionDamageHandler(attacker, force, num, 50, explosionType), dest.CenterOfMass)) & flag)
			{
				float num2 = setts._effectDurationOverDistance.Evaluate(magnitude);
				bool flag2 = attacker.Hub == hub;
				if (num2 > 0f && (flag2 || HitboxIdentity.IsDamageable(attacker.Role, hub.GetRoleId())))
				{
					float minimalDuration = setts._minimalDuration;
					TriggerEffect<Burned>(hub, num2 * setts._burnedDuration, minimalDuration);
					TriggerEffect<Deafened>(hub, num2 * setts._deafenedDuration, minimalDuration);
					TriggerEffect<Concussed>(hub, num2 * setts._concussedDuration, minimalDuration);
				}
				if (!flag2 && attacker.Hub != null)
				{
					Hitmarker.SendHitmarkerDirectly(attacker.Hub, 1f);
				}
			}
			return true;
		}

		private static void ExplodeDoor(DoorVariant dv, Vector3 pos, ExplosionGrenade setts, Footprint attacker)
		{
			if (dv is IDamageableDoor damageableDoor)
			{
				float time = Vector3.Distance(dv.transform.position, pos);
				damageableDoor.ServerDamage(setts._doorDamageOverDistance.Evaluate(time), DoorDamageType.Grenade, attacker);
			}
		}

		private static void TriggerEffect<T>(ReferenceHub hub, float duration, float minimal) where T : StatusEffectBase
		{
			if (!(duration < minimal))
			{
				hub.playerEffectsController.EnableEffect<T>(duration, addDuration: true);
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
