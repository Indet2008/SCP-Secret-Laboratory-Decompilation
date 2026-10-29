namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerKickingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Issuer { get; }

		public string Reason { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerKickingEventArgs(ReferenceHub hub, ReferenceHub issuer, string reason)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Issuer = global::LabApi.Features.Wrappers.Player.Get(issuer);
			Reason = reason;
		}
	}
}
