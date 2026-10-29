namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRequestingRaPlayersInfoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		private readonly global::System.Collections.Generic.IEnumerable<ReferenceHub> _targets;

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> Targets => global::System.Linq.Enumerable.Select(_targets, global::LabApi.Features.Wrappers.Player.Get);

		public bool IsSensitiveInfo { get; set; }

		public bool HasSensitiveInfoPerms { get; set; }

		public bool HasUserIdPerms { get; set; }

		public global::System.Text.StringBuilder InfoBuilder { get; }

		public bool IsAllowed { get; set; }

		public PlayerRequestingRaPlayersInfoEventArgs(CommandSender commandSender, global::System.Collections.Generic.IEnumerable<ReferenceHub> targets, bool isSensitiveInfo, bool hasSensitiveInfoPerms, bool hasUserIdPerms, global::System.Text.StringBuilder infoBuilder)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			IsSensitiveInfo = isSensitiveInfo;
			HasSensitiveInfoPerms = hasSensitiveInfoPerms;
			HasUserIdPerms = hasUserIdPerms;
			InfoBuilder = infoBuilder;
			IsAllowed = true;
			_targets = targets;
		}
	}
}
