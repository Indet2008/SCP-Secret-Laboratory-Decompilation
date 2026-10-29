namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerReportingCheaterEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public string Reason { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerReportingCheaterEventArgs(ReferenceHub hub, ReferenceHub target, string reason)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Reason = reason;
		}
	}
}
