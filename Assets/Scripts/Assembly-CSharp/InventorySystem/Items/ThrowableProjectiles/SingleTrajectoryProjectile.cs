using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class SingleTrajectoryProjectile : ThrownProjectile
	{
		[SerializeField]
		private LayerMask _collisionMask;

		[SerializeField]
		private GameObject _destroyedObject;

		[SerializeField]
		private float _destroyTime;

		[field: SerializeField]
		public float ProjectileRadius { get; private set; }

		protected override PickupPhysicsModule DefaultPhysicsModule => new TrajectoryPhysics(this);

		protected TrajectoryPhysics TrajPhysics => base.PhysicsModule as TrajectoryPhysics;

		protected virtual bool AlreadyCollided => TrajPhysics.DestinationReached;

		protected override void Awake()
		{
			base.Awake();
			if (NetworkServer.active)
			{
				TrajPhysics.ServerSetup(base.Position, Vector3.zero, ProjectileRadius, _collisionMask);
			}
		}

		public override void ServerOnThrown(Vector3 torque, Vector3 velocity)
		{
			base.ServerOnThrown(torque, velocity);
			TrajPhysics.ServerSetup(base.Position, velocity, ProjectileRadius, _collisionMask);
		}

		protected virtual void Update()
		{
			if (!AlreadyCollided)
			{
				return;
			}
			if (!_destroyedObject.activeSelf)
			{
				_destroyedObject.SetActive(value: true);
				ToggleRenderers(state: false);
				Vector3 fragmentVel = Vector3.ClampMagnitude(TrajPhysics.LastVelocity, 3f);
				_destroyedObject.ForEachComponentInChildren((Rigidbody rb) =>
				{
					rb.linearVelocity = fragmentVel;
				}, includeInactive: false);
			}
			if (NetworkServer.active)
			{
				_destroyTime -= Time.deltaTime;
				if (!(_destroyTime > 0f))
				{
					NetworkServer.Destroy(base.gameObject);
				}
			}
		}

		public override void ToggleRenderers(bool state)
		{
			if (_destroyedObject.activeSelf)
			{
				state = false;
			}
			base.ToggleRenderers(state);
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
