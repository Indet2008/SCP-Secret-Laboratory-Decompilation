using System;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class ThrownProjectile : CollisionDetectionPickup
	{
		public static readonly CachedLayerMask HitBlockerMask = new CachedLayerMask("Default", "Glass", "CCTV", "Door");

		[SerializeField]
		private GameObject _renderersRoot;

		public static event Action<ThrownProjectile> OnProjectileSpawned = (ThrownProjectile thrownProjectile) =>
		{
		};

		protected override void Start()
		{
			base.Start();
			OnProjectileSpawned?.Invoke(this);
		}

		public virtual void ToggleRenderers(bool state)
		{
			_renderersRoot.SetActive(state);
		}

		public virtual void ServerOnThrown(Vector3 torque, Vector3 velocity)
		{
		}

		public virtual void ServerActivate()
		{
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
