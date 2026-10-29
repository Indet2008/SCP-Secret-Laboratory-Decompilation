namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerHurtingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player? Attacker { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerHurtingEventArgs(ReferenceHub? attacker, ReferenceHub victim, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(victim);
			Attacker = global::LabApi.Features.Wrappers.Player.Get(attacker);
			DamageHandler = damageHandler;
		}
	}
}
