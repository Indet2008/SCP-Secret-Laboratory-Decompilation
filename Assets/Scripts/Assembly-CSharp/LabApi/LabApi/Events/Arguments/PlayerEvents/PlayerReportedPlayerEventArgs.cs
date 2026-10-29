namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerReportedPlayerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public string Reason { get; }

		public PlayerReportedPlayerEventArgs(ReferenceHub hub, ReferenceHub target, string reason)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Reason = reason;
		}
	}
}
