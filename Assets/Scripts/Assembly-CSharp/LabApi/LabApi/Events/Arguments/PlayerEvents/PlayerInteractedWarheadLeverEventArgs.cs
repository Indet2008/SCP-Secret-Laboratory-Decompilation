namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractedWarheadLeverEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool Enabled { get; }

		public PlayerInteractedWarheadLeverEventArgs(ReferenceHub player, bool enabled)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Enabled = enabled;
		}
	}
}
