namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRaPlayerListAddedPlayerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public global::System.Text.StringBuilder TargetBuilder { get; }

		public PlayerRaPlayerListAddedPlayerEventArgs(CommandSender requesterHub, ReferenceHub targetHub, global::System.Text.StringBuilder builder)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(requesterHub);
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
			TargetBuilder = builder;
		}
	}
}
