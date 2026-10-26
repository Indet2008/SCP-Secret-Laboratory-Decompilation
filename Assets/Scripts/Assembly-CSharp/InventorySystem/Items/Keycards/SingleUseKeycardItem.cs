using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class SingleUseKeycardItem : KeycardItem
	{
		[SerializeField]
		private float _timeToDestroy;

		[SerializeField]
		private DoorPermissionFlags _singleUsePermissions;

		[SerializeField]
		private bool _allowClosingDoors;

		private bool _destroyed;

		public override DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			DoorPermissionFlags result = _singleUsePermissions;
			if (!_allowClosingDoors && requester is DoorVariant { TargetState: not false })
			{
				result = DoorPermissionFlags.None;
			}
			if (_destroyed || requester == null || !requester.PermissionsPolicy.CheckPermissions(_singleUsePermissions))
			{
				result = DoorPermissionFlags.None;
			}
			return result;
		}

		public override void AlwaysUpdate()
		{
			base.AlwaysUpdate();
			if (NetworkServer.active && _destroyed)
			{
				_timeToDestroy -= Time.deltaTime;
				if (_timeToDestroy <= 0f || !base.IsEquipped)
				{
					base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
				}
			}
		}

		protected override void OnUsed(IDoorPermissionRequester requester, bool success)
		{
			base.OnUsed(requester, success);
			if (success)
			{
				_destroyed = true;
			}
		}

		public override ItemPickupBase ServerDropItem(bool spawn)
		{
			if (_destroyed)
			{
				base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
				return null;
			}
			return base.ServerDropItem(spawn);
		}
	}
}
