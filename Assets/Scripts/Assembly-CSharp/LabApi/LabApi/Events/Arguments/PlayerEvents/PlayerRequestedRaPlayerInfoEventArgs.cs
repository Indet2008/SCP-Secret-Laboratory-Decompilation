namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRequestedRaPlayerInfoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool IsSensitiveInfo { get; }

		public bool HasUserIdPerms { get; }

		public global::System.Text.StringBuilder InfoBuilder { get; }

		public global::System.Text.StringBuilder PlayerIdBuilder { get; }

		public global::System.Text.StringBuilder IpBuilder { get; }

		public global::System.Text.StringBuilder UserIdBuilder { get; }

		public PlayerRequestedRaPlayerInfoEventArgs(CommandSender commandSender, ReferenceHub targetHub, bool isSensitiveInfo, bool hasUserIdPerms, global::System.Text.StringBuilder infoBuilder, global::System.Text.StringBuilder idBuilder, global::System.Text.StringBuilder ipBuilder, global::System.Text.StringBuilder userIdBuilder)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
			IsSensitiveInfo = isSensitiveInfo;
			HasUserIdPerms = hasUserIdPerms;
			InfoBuilder = infoBuilder;
			PlayerIdBuilder = idBuilder;
			IpBuilder = ipBuilder;
			UserIdBuilder = userIdBuilder;
		}
	}
}
