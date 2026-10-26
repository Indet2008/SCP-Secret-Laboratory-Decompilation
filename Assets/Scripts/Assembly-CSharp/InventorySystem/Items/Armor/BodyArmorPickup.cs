using System.Collections.Generic;
using InventorySystem.Items.Pickups;
using InventorySystem.Searching;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Armor
{
	public class BodyArmorPickup : ItemPickupBase
	{
		private static readonly RigidbodyConstraints StartConstraints = (RigidbodyConstraints)80;

		private static readonly Quaternion StartRotation = Quaternion.Euler(0f, 0f, -90f);

		private readonly HashSet<ushort> _alreadyMovedPickups = new HashSet<ushort>();

		private const float ReleaseVelocity = 0.1f;

		private const float ReleaseDelay = 0.15f;

		private const float DotProductThreshold = -0.8f;

		private const float HeightOffset = 0.16f;

		private const float WeightLimit = 2.1f;

		private const int PickupLayer = 9;

		private float _remainingReleaseTime;

		private bool _released;

		private Rigidbody _rb;

		private bool IsAffected
		{
			get
			{
				if (!_released && NetworkServer.active)
				{
					return PreviousOwner.IsSet;
				}
				return false;
			}
		}

		public override PickupSearchCompletor GetPickupSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			if (!InventoryItemLoader.TryGetItem<ItemBase>(Info.ItemId, out var result))
			{
				return null;
			}
			return new ArmorSearchCompletor(coordinator.Hub, this, result, sqrDistance);
		}

		protected override void Start()
		{
			base.Start();
			if (IsAffected && !(PreviousOwner.Hub == null))
			{
				_remainingReleaseTime = 0.15f;
				_rb = (base.PhysicsModule as PickupStandardPhysics).Rb;
				_rb.rotation = PreviousOwner.Hub.transform.rotation * StartRotation;
				_rb.constraints = StartConstraints;
			}
		}

		private void OnTriggerStay(Collider other)
		{
			if (other.gameObject.layer == 9 && !(Vector3.Dot(Vector3.up, base.transform.right) > -0.8f) && other.transform.root.TryGetComponent<ItemPickupBase>(out var component) && !(component.Info.WeightKg > 2.1f) && _alreadyMovedPickups.Add(component.Info.Serial) && InventoryItemLoader.AvailableItems.TryGetValue(component.Info.ItemId, out var value) && value.Category != ItemCategory.Armor)
			{
				float num = base.transform.position.y - component.transform.position.y;
				component.transform.position += Vector3.up * (num * 2f + 0.16f);
			}
		}

		private void Update()
		{
			if (IsAffected && !(Mathf.Abs(_rb.linearVelocity.y) > 0.1f))
			{
				_remainingReleaseTime -= Time.deltaTime;
				if (_remainingReleaseTime <= 0f)
				{
					_released = true;
					_rb.constraints = RigidbodyConstraints.None;
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
