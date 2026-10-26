using Interactables.Interobjects.DoorButtons;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class KeycardPickup : CollisionDetectionPickup
	{
		[SerializeField]
		private Transform _gfxSpawnPoint;

		private bool _openDoorsOnCollision;

		protected override void Start()
		{
			base.Start();
			if (Info.ItemId.TryGetTemplate<KeycardItem>(out var item))
			{
				Object.Instantiate(item.KeycardGfx, _gfxSpawnPoint);
				if (NetworkServer.active)
				{
					_openDoorsOnCollision = item.OpenDoorsOnThrow;
					KeycardDetailSynchronizer.ServerProcessPickup(this);
				}
			}
		}

		protected override void ProcessCollision(Collision collision)
		{
			base.ProcessCollision(collision);
			if (NetworkServer.active && _openDoorsOnCollision && collision.collider.TryGetComponent<KeycardButton>(out var component) && component.Target is DoorVariant { ActiveLocks: 0 } doorVariant && doorVariant.AllowInteracting(null, component.ColliderId) && Info.ItemId.TryGetTemplate<KeycardItem>(out var item))
			{
				if (doorVariant.CheckPermissions(item, out var callback))
				{
					doorVariant.NetworkTargetState = !doorVariant.TargetState;
					callback?.Invoke(doorVariant, success: true);
				}
				else
				{
					callback?.Invoke(doorVariant, success: false);
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
