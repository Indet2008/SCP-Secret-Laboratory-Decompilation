using Footprinting;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class TimedGrenadePickup : CollisionDetectionPickup, IExplosionTrigger
	{
		private bool _replaceNextFrame;

		private Footprint _attacker;

		private const float ActivationRange = 0.4f;

		private void Update()
		{
			if (_replaceNextFrame && InventoryItemLoader.AvailableItems.TryGetValue(Info.ItemId, out var value) && value is ThrowableItem throwableItem)
			{
				ThrownProjectile thrownProjectile = Object.Instantiate(throwableItem.Projectile);
				if (thrownProjectile.PhysicsModule is PickupStandardPhysics pickupStandardPhysics && base.PhysicsModule is PickupStandardPhysics pickupStandardPhysics2)
				{
					Rigidbody rb = pickupStandardPhysics.Rb;
					Rigidbody rb2 = pickupStandardPhysics2.Rb;
					rb.position = rb2.position;
					rb.rotation = rb2.rotation;
					rb.linearVelocity = rb2.linearVelocity;
					rb.angularVelocity = rb2.angularVelocity;
				}
				Info.Locked = true;
				thrownProjectile.NetworkInfo = Info;
				thrownProjectile.PreviousOwner = _attacker;
				NetworkServer.Spawn(thrownProjectile.gameObject);
				thrownProjectile.ServerActivate();
				DestroySelf();
				_replaceNextFrame = false;
			}
		}

		public void OnExplosionDetected(Footprint attacker, Vector3 source, float range)
		{
			if (!(Vector3.Distance(base.transform.position, source) / range > 0.4f) && !Physics.Linecast(base.transform.position, source, ThrownProjectile.HitBlockerMask))
			{
				_replaceNextFrame = true;
				_attacker = attacker;
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
