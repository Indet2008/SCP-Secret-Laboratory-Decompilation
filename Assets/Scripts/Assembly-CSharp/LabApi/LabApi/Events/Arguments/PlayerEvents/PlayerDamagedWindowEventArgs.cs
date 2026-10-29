namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDamagedWindowEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public BreakableWindow Window { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; }

		public PlayerDamagedWindowEventArgs(ReferenceHub hub, BreakableWindow window, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Window = window;
			DamageHandler = damageHandler;
		}
	}
}
