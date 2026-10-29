namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRaPlayerListAddingPlayerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public global::System.Text.StringBuilder TargetBuilder { get; }

		public string Prefix { get; set; }

		public bool InOverwatch { get; set; }

		public bool IsMuted { get; set; }

		public string Body { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerRaPlayerListAddingPlayerEventArgs(CommandSender commandSender, ReferenceHub targetHub, global::System.Text.StringBuilder builder, string prefix, bool inOverwatch, bool isMuted, string body)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
			TargetBuilder = builder;
			Prefix = prefix;
			InOverwatch = inOverwatch;
			IsMuted = isMuted;
			Body = body;
			IsAllowed = true;
		}
	}
}
