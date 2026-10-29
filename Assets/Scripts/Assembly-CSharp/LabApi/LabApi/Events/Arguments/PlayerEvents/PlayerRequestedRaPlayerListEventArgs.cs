namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRequestedRaPlayerListEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::System.Text.StringBuilder ListBuilder { get; }

		public PlayerRequestedRaPlayerListEventArgs(CommandSender commandSender, global::System.Text.StringBuilder builder)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			ListBuilder = builder;
		}
	}
}
