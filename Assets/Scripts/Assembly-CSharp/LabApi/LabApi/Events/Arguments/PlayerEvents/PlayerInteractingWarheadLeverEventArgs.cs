namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractingWarheadLeverEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool Enabled { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerInteractingWarheadLeverEventArgs(ReferenceHub player, bool enabled)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Enabled = enabled;
			IsAllowed = true;
		}
	}
}
