using System;
using System.Collections.Generic;
using DrawableLine;
using Interactables;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class Scp018Projectile : TimeGrenade
	{
		private static readonly CachedLayerMask BounceHitregMask;

		private static readonly CachedLayerMask FlybyHitregMask;

		private static readonly Collider[] HitregDetections;

		private Transform _tr;

		private float _lastVelocity;

		private double _activationTime;

		private bool _bypassBounceSoundCooldown;

		private Vector3 _prevTrPos;

		private RelativePosition? _prevFlybyPos;

		private HashSet<uint> _damagedPlayersSinceLastBounce;

		[SerializeField]
		private float _radius;

		[SerializeField]
		private float _maximumVelocity;

		[SerializeField]
		private float _onBounceVelocityAddition;

		[SerializeField]
		private float _activationVelocitySqr;

		[SerializeField]
		private AnimationCurve _damageOverVelocity;

		[SerializeField]
		private float _doorDamageMultiplier;

		[SerializeField]
		private float _scpDamageMultiplier;

		[SerializeField]
		private float _friendlyFireTime;

		[SerializeField]
		private float _bounceHitregRadius;

		[SerializeField]
		private float _flybyHitregRadius;

		[SerializeField]
		private ParticleSystem _trail;

		public float CurrentDamage => _damageOverVelocity.Evaluate(_lastVelocity);

		private bool IgnoreFriendlyFire
		{
			get
			{
				if (PreviousOwner.IsSet)
				{
					return NetworkTime.time > _activationTime + (double)_friendlyFireTime;
				}
				return true;
			}
		}

		protected override float MinSoundCooldown
		{
			get
			{
				if (_bypassBounceSoundCooldown)
				{
					_bypassBounceSoundCooldown = false;
					return Time.deltaTime;
				}
				return base.MinSoundCooldown;
			}
		}

		protected override PickupPhysicsModule DefaultPhysicsModule => new PickupStandardPhysics(this, PickupStandardPhysics.FreezingMode.FreezeWhenSleeping);

		public Vector3 RecreatedVelocity { get; private set; }

		[ClientRpc]
		public void RpcPlayBounce(float velSqr)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteFloat(velSqr);
			SendRPCInternal("System.Void InventorySystem.Items.ThrowableProjectiles.Scp018Projectile::RpcPlayBounce(System.Single)", -734142472, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		protected override void ProcessCollision(Collision collision)
		{
			if (base.PhysicsModule is Scp018Physics)
			{
				return;
			}
			base.ProcessCollision(collision);
			if (NetworkServer.active)
			{
				float sqrMagnitude = collision.relativeVelocity.sqrMagnitude;
				RpcPlayBounce(sqrMagnitude);
				if (!(sqrMagnitude < _activationVelocitySqr))
				{
					SetupModule();
					ServerActivate();
					PickupSyncInfo info = Info;
					info.Locked = true;
					base.NetworkInfo = info;
				}
			}
		}

		protected override void Start()
		{
			base.Start();
			_tr = base.transform;
		}

		protected override void Update()
		{
			base.Update();
			if (!(base.PhysicsModule is Scp018Physics { Position: var position }))
			{
				return;
			}
			Vector3 vector = position - _prevTrPos;
			_tr.position = position;
			_prevTrPos = position;
			RecreatedVelocity = vector / Time.deltaTime;
			if (!NetworkServer.active)
			{
				return;
			}
			if (!_prevFlybyPos.HasValue)
			{
				_prevFlybyPos = new RelativePosition(position);
				return;
			}
			DrawableLines.GenerateSphere(position, _flybyHitregRadius);
			int num = Physics.OverlapCapsuleNonAlloc(_prevFlybyPos.Value.Position, position, _flybyHitregRadius, HitregDetections, FlybyHitregMask);
			while (num-- > 0)
			{
				if (HitregDetections[num].TryGetComponent<HitboxIdentity>(out var component) && _damagedPlayersSinceLastBounce.Add(component.NetworkId))
				{
					float num2 = CurrentDamage;
					if (component.TargetHub.IsSCP())
					{
						num2 *= _scpDamageMultiplier;
					}
					component.Damage(num2, new Scp018DamageHandler(this, num2, IgnoreFriendlyFire), position);
				}
			}
			_prevFlybyPos = new RelativePosition(position);
		}

		public override bool ServerFuseEnd()
		{
			if (!base.ServerFuseEnd())
			{
				return false;
			}
			ExplosionUtils.ServerExplode(_tr.position, PreviousOwner, ExplosionType.SCP018);
			DestroySelf();
			ServerEvents.OnProjectileExploded(new ProjectileExplodedEventArgs(this, PreviousOwner.Hub, base.transform.position));
			return true;
		}

		[ClientRpc]
		internal override void SendPhysicsModuleRpc(ArraySegment<byte> arrSeg)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteArraySegmentAndSize(arrSeg);
			SendRPCInternal("System.Void InventorySystem.Items.ThrowableProjectiles.Scp018Projectile::SendPhysicsModuleRpc(System.ArraySegment`1<System.Byte>)", 1041392993, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		internal void RegisterBounce(float velocity, Vector3 point)
		{
			_lastVelocity = velocity;
			_bypassBounceSoundCooldown = true;
			float b = velocity * velocity;
			MakeCollisionSound(Mathf.Max(10f, b));
			if (!NetworkServer.active)
			{
				return;
			}
			int num = Physics.OverlapSphereNonAlloc(point, _bounceHitregRadius, HitregDetections, BounceHitregMask);
			while (num-- > 0)
			{
				Collider collider = HitregDetections[num];
				InteractableCollider component2;
				if (collider.TryGetComponent<BreakableWindow>(out var component))
				{
					component.Damage(CurrentDamage, new Scp018DamageHandler(this, CurrentDamage, IgnoreFriendlyFire), point);
				}
				else if (collider.TryGetComponent<InteractableCollider>(out component2) && component2.Target is IDamageableDoor damageableDoor)
				{
					damageableDoor.ServerDamage(CurrentDamage * _doorDamageMultiplier, DoorDamageType.Grenade, PreviousOwner);
				}
			}
			_damagedPlayersSinceLastBounce.Clear();
		}

		private void SetupModule()
		{
			_activationTime = NetworkTime.time;
			_damagedPlayersSinceLastBounce = new HashSet<uint>();
			base.PhysicsModule.DestroyModule();
			base.PhysicsModule = new Scp018Physics(this, _trail, _radius, _maximumVelocity, _onBounceVelocityAddition);
		}

		static Scp018Projectile()
		{
			BounceHitregMask = new CachedLayerMask("Door", "Glass");
			FlybyHitregMask = new CachedLayerMask("Hitbox");
			HitregDetections = new Collider[8];
			RemoteProcedureCalls.RegisterRpc(typeof(Scp018Projectile), "System.Void InventorySystem.Items.ThrowableProjectiles.Scp018Projectile::RpcPlayBounce(System.Single)", InvokeUserCode_RpcPlayBounce__Single);
			RemoteProcedureCalls.RegisterRpc(typeof(Scp018Projectile), "System.Void InventorySystem.Items.ThrowableProjectiles.Scp018Projectile::SendPhysicsModuleRpc(System.ArraySegment`1<System.Byte>)", InvokeUserCode_SendPhysicsModuleRpc__ArraySegment_00601);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlayBounce__Single(float velSqr)
		{
			if (!NetworkServer.active)
			{
				MakeCollisionSound(velSqr);
			}
		}

		protected static void InvokeUserCode_RpcPlayBounce__Single(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlayBounce called on server.");
			}
			else
			{
				((Scp018Projectile)obj).UserCode_RpcPlayBounce__Single(reader.ReadFloat());
			}
		}

		protected override void UserCode_SendPhysicsModuleRpc__ArraySegment_00601(ArraySegment<byte> arrSeg)
		{
			if (arrSeg.Count == 19 && !(base.PhysicsModule is Scp018Physics))
			{
				SetupModule();
			}
			base.UserCode_SendPhysicsModuleRpc__ArraySegment_00601(arrSeg);
		}

		protected new static void InvokeUserCode_SendPhysicsModuleRpc__ArraySegment_00601(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC SendPhysicsModuleRpc called on server.");
			}
			else
			{
				((Scp018Projectile)obj).UserCode_SendPhysicsModuleRpc__ArraySegment_00601(reader.ReadArraySegmentAndSize());
			}
		}
	}
}
