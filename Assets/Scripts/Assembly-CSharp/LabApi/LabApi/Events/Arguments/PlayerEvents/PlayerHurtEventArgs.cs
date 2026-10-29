namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerHurtEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player? Attacker { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; }

		public PlayerHurtEventArgs(ReferenceHub? attacker, ReferenceHub victim, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(victim);
			Attacker = global::LabApi.Features.Wrappers.Player.Get(attacker);
			DamageHandler = damageHandler;
		}
	}
}
