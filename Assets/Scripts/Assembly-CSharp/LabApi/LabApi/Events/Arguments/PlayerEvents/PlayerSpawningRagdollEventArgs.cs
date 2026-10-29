namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSpawningRagdollEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		[global::System.Obsolete("use RagdollPrefab instead.")]
		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll => RagdollPrefab;

		public global::LabApi.Features.Wrappers.Ragdoll RagdollPrefab { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerSpawningRagdollEventArgs(ReferenceHub hub, global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			RagdollPrefab = global::LabApi.Features.Wrappers.Ragdoll.Get(ragdoll);
			DamageHandler = damageHandler;
		}
	}
}
