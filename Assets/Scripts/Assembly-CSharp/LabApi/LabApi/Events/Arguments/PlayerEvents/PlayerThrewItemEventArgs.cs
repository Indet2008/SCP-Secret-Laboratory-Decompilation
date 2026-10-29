namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerThrewItemEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IPickupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public global::UnityEngine.Rigidbody Rigidbody { get; }

		public PlayerThrewItemEventArgs(ReferenceHub hub, global::InventorySystem.Items.Pickups.ItemPickupBase item, global::UnityEngine.Rigidbody rigidbody)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(item);
			Rigidbody = rigidbody;
		}
	}
}
