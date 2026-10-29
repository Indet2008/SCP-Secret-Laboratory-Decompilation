namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRequestedRaPlayersInfoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		private readonly global::System.Collections.Generic.IEnumerable<ReferenceHub> _targets;

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> Targets => global::System.Linq.Enumerable.Select(_targets, global::LabApi.Features.Wrappers.Player.Get);

		public bool IsSensitiveInfo { get; }

		public bool HasUserIdPerms { get; }

		public global::System.Text.StringBuilder InfoBuilder { get; }

		public global::System.Text.StringBuilder PlayerIdBuilder { get; }

		public global::System.Text.StringBuilder IpBuilder { get; }

		public global::System.Text.StringBuilder UserIdBuilder { get; }

		public PlayerRequestedRaPlayersInfoEventArgs(CommandSender commandSender, global::System.Collections.Generic.IEnumerable<ReferenceHub> targets, bool isSensitiveInfo, bool hasUserIdPerms, global::System.Text.StringBuilder infoBuilder, global::System.Text.StringBuilder idBuilder, global::System.Text.StringBuilder ipBuilder, global::System.Text.StringBuilder userIdBuilder)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			IsSensitiveInfo = isSensitiveInfo;
			HasUserIdPerms = hasUserIdPerms;
			InfoBuilder = infoBuilder;
			PlayerIdBuilder = idBuilder;
			IpBuilder = ipBuilder;
			UserIdBuilder = userIdBuilder;
			_targets = targets;
		}
	}
}
