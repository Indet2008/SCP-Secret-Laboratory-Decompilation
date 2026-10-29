namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerThrowingItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public global::UnityEngine.Rigidbody Rigidbody { get; }

		public bool IsAllowed { get; set; }

		public PlayerThrowingItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.Pickups.ItemPickupBase item, global::UnityEngine.Rigidbody rigidbody)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(item);
			Rigidbody = rigidbody;
		}
	}
}
