using System.Collections.Generic;
using InventorySystem.Items.Pickups;
using Mirror;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class PickupRippleTrigger : RippleTriggerBase
	{
		private const float MinVelSqr = 8.5f;

		private const float SoundRangeMin = 4f;

		private const float SoundRangeKg = 0.75f;

		private RelativePosition _syncPos;

		private readonly RateLimiter _rateLimiter = new RateLimiter(0f, 8, 0.2f);

		private static bool _anyInstances;

		private static readonly HashSet<PickupRippleTrigger> ActiveInstances = new HashSet<PickupRippleTrigger>();

		public override void SpawnObject()
		{
			base.SpawnObject();
			ActiveInstances.Add(this);
			_anyInstances = true;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			RemoveSelf();
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteRelativePosition(_syncPos);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (base.IsLocalOrSpectated)
			{
				base.Player.Play(reader.ReadRelativePosition().Position, Color.red);
			}
		}

		private void OnDestroy()
		{
			RemoveSelf();
		}

		private void RemoveSelf()
		{
			if (ActiveInstances.Remove(this))
			{
				_anyInstances = ActiveInstances.Count > 0;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ItemPickupBase.OnPickupAdded += OnPickupAdded;
		}

		private static void OnPickupAdded(ItemPickupBase ipb)
		{
			CollisionDetectionPickup cdp = ipb as CollisionDetectionPickup;
			if ((object)cdp != null && NetworkServer.active)
			{
				cdp.OnCollided += (Collision col) =>
				{
					OnCollided(cdp, col);
				};
			}
		}

		private static void OnCollided(CollisionDetectionPickup cdp, Collision collision)
		{
			if (!_anyInstances || !NetworkServer.active)
			{
				return;
			}
			float sqrMagnitude = collision.relativeVelocity.sqrMagnitude;
			if (sqrMagnitude < 8.5f || collision.contactCount == 0)
			{
				return;
			}
			float a = Mathf.Max(4f, cdp.Info.WeightKg * 0.75f);
			a = Mathf.Max(a, cdp.GetRangeOfCollisionVelocity(sqrMagnitude));
			foreach (PickupRippleTrigger activeInstance in ActiveInstances)
			{
				if (activeInstance._rateLimiter.RateReady)
				{
					Vector3 point = collision.GetContact(0).point;
					if (!((point - activeInstance.CastRole.FpcModule.Position).sqrMagnitude >= a * a))
					{
						activeInstance._rateLimiter.RegisterInput();
						activeInstance._syncPos = new RelativePosition(point);
						activeInstance.ServerSendRpcToObservers();
					}
				}
			}
		}
	}
}
