namespace LabApi.Events.Arguments.ServerEvents
{
	public class ExplosionSpawningEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player? Player { get; set; }

		public global::UnityEngine.Vector3 Position { get; set; }

		public global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade Settings { get; set; }

		public ExplosionType ExplosionType { get; set; }

		public bool DestroyDoors { get; set; }

		public bool IsAllowed { get; set; }

		public ExplosionSpawningEventArgs(ReferenceHub? hub, global::UnityEngine.Vector3 position, global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade settingsReference, ExplosionType explosionType, bool destroyDoors)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Position = position;
			Settings = settingsReference;
			ExplosionType = explosionType;
			DestroyDoors = destroyDoors;
			IsAllowed = true;
		}
	}
}
