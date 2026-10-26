using System;
using CameraShaking;
using Footprinting;
using Interactables;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using PlayerRoles.PlayableScps.Subroutines;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507AttackAbility : SingleTargetAttackAbility<Scp1507Role>, IShakeEffect
	{
		private const float ScpDamageMultiplier = 2f;

		private const float AttackDistance = 1.728f;

		private const float DoorDamageAmount = 20f;

		public static readonly CachedLayerMask AttackMask = new CachedLayerMask("Default", "InteractableNoPlayerCollision", "Glass", "Door");

		[SerializeField]
		private float _damage;

		[SerializeField]
		private AnimationCurve _peckShakeAngle;

		[SerializeField]
		private AnimationCurve _peckShakeFov;

		[SerializeField]
		private float _peckShakeTimeScale;

		private float _attackRandom;

		public override float DamageAmount => _damage;

		protected override float AttackDelay => 0f;

		protected override float BaseCooldown => 0.6f;

		protected override bool SelfRepeating => false;

		public event Action ServerOnDoorAttacked;

		public event Action ServerOnMissed;

		private bool TryAttackDoor()
		{
			Transform playerCameraReference = base.Owner.PlayerCameraReference;
			if (!Physics.Raycast(playerCameraReference.position, playerCameraReference.forward, out var hitInfo, 1.728f, AttackMask))
			{
				return false;
			}
			if (!hitInfo.collider.TryGetComponent<InteractableCollider>(out var component))
			{
				return false;
			}
			if (!(component.Target is DoorVariant { TargetState: false } doorVariant))
			{
				return false;
			}
			if (component.Target is IDamageableDoor damageableDoor && damageableDoor.ServerDamage(20f, DoorDamageType.Scp096))
			{
				Hitmarker.SendHitmarkerDirectly(base.Owner, 20f);
				return true;
			}
			if (doorVariant.AllowInteracting(base.Owner, component.ColliderId) && DoorLockUtils.GetMode(doorVariant).HasFlagFast(DoorLockMode.CanOpen))
			{
				doorVariant.NetworkTargetState = true;
				return true;
			}
			return false;
		}

		protected override DamageHandlerBase DamageHandler(float damage)
		{
			return new Scp1507DamageHandler(new Footprint(base.Owner), damage);
		}

		protected override void DamagePlayer(ReferenceHub hub, float damage)
		{
			if (hub.IsSCP())
			{
				damage *= 2f;
			}
			base.DamagePlayer(hub, damage);
		}

		protected override void DamagePlayers()
		{
			base.DamagePlayers();
			if (base.LastAttackResult == AttackResult.None)
			{
				if (TryAttackDoor())
				{
					ServerOnDoorAttacked?.Invoke();
				}
				else
				{
					ServerOnMissed?.Invoke();
				}
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			CameraShakeController.AddEffect(this);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_attackRandom = UnityEngine.Random.Range(-1f, 1f);
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			shakeValues = ShakeEffectValues.None;
			if (base.Role.Pooled)
			{
				return false;
			}
			if (!base.Owner.isLocalPlayer && !base.Owner.IsLocallySpectated())
			{
				return true;
			}
			float time = base.Cooldown.Readiness * _peckShakeTimeScale;
			float num = _peckShakeFov.Evaluate(time);
			float z = _attackRandom * _peckShakeAngle.Evaluate(time);
			Quaternion value = Quaternion.Euler(0f, 0f, z);
			Quaternion? rootCameraRotation = value;
			float fovPercent = num;
			shakeValues = new ShakeEffectValues(rootCameraRotation, null, null, fovPercent);
			return true;
		}
	}
}
