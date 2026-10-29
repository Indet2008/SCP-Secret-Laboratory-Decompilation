namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRequestingRaPlayerInfoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool IsSensitiveInfo { get; set; }

		public bool HasSensitiveInfoPerms { get; set; }

		public bool HasUserIdPerms { get; set; }

		public global::System.Text.StringBuilder InfoBuilder { get; }

		public bool IsAllowed { get; set; }

		public PlayerRequestingRaPlayerInfoEventArgs(CommandSender commandSender, ReferenceHub targetHub, bool isSensitiveInfo, bool hasSensitiveInfoPerms, bool hasUserIdPerms, global::System.Text.StringBuilder infoBuilder)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
			IsSensitiveInfo = isSensitiveInfo;
			HasSensitiveInfoPerms = hasSensitiveInfoPerms;
			HasUserIdPerms = hasUserIdPerms;
			InfoBuilder = infoBuilder;
			IsAllowed = true;
		}
	}
}
