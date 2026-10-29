namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDamagingWindowEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public BreakableWindow Window { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerDamagingWindowEventArgs(ReferenceHub hub, BreakableWindow window, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Window = window;
			DamageHandler = damageHandler;
		}
	}
}
