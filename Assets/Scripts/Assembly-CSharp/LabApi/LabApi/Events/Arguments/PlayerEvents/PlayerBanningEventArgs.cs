namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerBanningEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player? Player { get; }

		public string PlayerId { get; }

		public global::LabApi.Features.Wrappers.Player Issuer { get; }

		public string Reason { get; set; }

		public long Duration { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerBanningEventArgs(ReferenceHub? hub, string playerId, ReferenceHub issuer, string reason, long duration)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			PlayerId = playerId;
			Issuer = global::LabApi.Features.Wrappers.Player.Get(issuer);
			Reason = reason;
			Duration = duration;
		}
	}
}
