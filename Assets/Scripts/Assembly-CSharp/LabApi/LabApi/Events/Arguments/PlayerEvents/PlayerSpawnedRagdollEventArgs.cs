namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSpawnedRagdollEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRagdollEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; }

		public PlayerSpawnedRagdollEventArgs(ReferenceHub hub, global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Ragdoll = global::LabApi.Features.Wrappers.Ragdoll.Get(ragdoll);
			DamageHandler = damageHandler;
		}
	}
}
