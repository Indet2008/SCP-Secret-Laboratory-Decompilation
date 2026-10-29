namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDyingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player? Attacker { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerDyingEventArgs(ReferenceHub hub, ReferenceHub? attacker, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Attacker = global::LabApi.Features.Wrappers.Player.Get(attacker);
			DamageHandler = damageHandler;
		}
	}
}
