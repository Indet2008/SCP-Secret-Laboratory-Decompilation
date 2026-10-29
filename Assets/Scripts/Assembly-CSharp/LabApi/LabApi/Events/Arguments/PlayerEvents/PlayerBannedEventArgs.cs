namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerBannedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player? Player { get; }

		public string PlayerId { get; }

		public global::LabApi.Features.Wrappers.Player Issuer { get; }

		public string Reason { get; }

		public long Duration { get; }

		public PlayerBannedEventArgs(ReferenceHub? hub, string playerId, ReferenceHub issuer, string reason, long duration)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			PlayerId = playerId;
			Issuer = global::LabApi.Features.Wrappers.Player.Get(issuer);
			Reason = reason;
			Duration = duration;
		}
	}
}
