namespace LabApi.Events.Arguments.ServerEvents
{
	public class ExplosionSpawnedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player? Player { get; }

		public global::UnityEngine.Vector3 Position { get; }

		public global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade Settings { get; }

		public ExplosionType ExplosionType { get; }

		public bool DestroyDoors { get; }

		public ExplosionSpawnedEventArgs(ReferenceHub? hub, global::UnityEngine.Vector3 position, global::InventorySystem.Items.ThrowableProjectiles.ExplosionGrenade settingsReference, ExplosionType explosionType, bool destroyDoors)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Position = position;
			Settings = settingsReference;
			ExplosionType = explosionType;
			DestroyDoors = destroyDoors;
		}
	}
}
