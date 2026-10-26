using InventorySystem.Drawers;
using InventorySystem.Items.Pickups;
using PlayerRoles.Ragdolls;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace InventorySystem.Items.DebugTools
{
	public class RagdollMover : ItemBase, IItemAlertDrawer, IItemDrawer, ICustomDisplayName, IItemDescription, IItemNametag
	{
		private static readonly CachedLayerMask DetectionMask = new CachedLayerMask("Default", "Ragdoll");

		private const float MaxRaycastDis = 10f;

		[SerializeField]
		private float _proportionalForce;

		[SerializeField]
		private float _maxForce;

		private Rigidbody _hitRb;

		private Vector3 _hitLocalPos;

		private float _hitDist;

		private bool _hasHit;

		public override float Weight => 1f;

		public AlertContent Alert => new AlertContent($"Press and hold ${new ReadableKeyCode(TriggerKey)}$ to move a ragdoll bone.\nClient-side only - changes are not synchronized with other players.");

		public string DisplayName => "Ragdoll Mover";

		public bool CanBeDisplayed => false;

		public string Description => "Debug Tool\n(no official support)";

		public string Name => DisplayName;

		private KeyCode TriggerKey => NewInput.GetKey(ActionName.Shoot);

		private KeyCode FreezeKey => NewInput.GetKey(ActionName.Zoom);

		private Transform Cam => base.Owner.PlayerCameraReference;

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (IsLocalPlayer)
			{
				if (Input.GetKeyDown(TriggerKey))
				{
					_hasHit = TryFind();
				}
				if (_hasHit && Input.GetKey(TriggerKey))
				{
					UpdateMoving();
				}
			}
		}

		private bool TryFind()
		{
			if (!Physics.Raycast(Cam.position, Cam.forward, out var hitInfo, 10f, DetectionMask))
			{
				return false;
			}
			_hitRb = hitInfo.rigidbody;
			if (_hitRb == null)
			{
				return false;
			}
			_hitRb.isKinematic = false;
			_hitDist = hitInfo.distance;
			_hitLocalPos = _hitRb.transform.InverseTransformPoint(hitInfo.point);
			BasicRagdoll comp;
			return _hitRb.transform.TryGetComponentInParent<BasicRagdoll>(out comp);
		}

		private void UpdateMoving()
		{
			if (_hitRb == null)
			{
				_hasHit = false;
				return;
			}
			if (Input.GetKeyDown(FreezeKey))
			{
				_hitRb.isKinematic = !_hitRb.isKinematic;
			}
			Transform transform = _hitRb.transform;
			Vector3 vector = Cam.position + Cam.forward * _hitDist;
			Vector3 vector2 = transform.TransformPoint(_hitLocalPos);
			Vector3 vector3 = vector - vector2;
			float num = vector3.magnitude * _proportionalForce;
			if (num < _maxForce)
			{
				_hitRb.AddForceAtPosition(vector3 * num, vector, ForceMode.Force);
			}
			else
			{
				transform.position += vector3;
			}
		}

		public override ItemPickupBase ServerDropItem(bool spawn)
		{
			base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
			return null;
		}
	}
}
