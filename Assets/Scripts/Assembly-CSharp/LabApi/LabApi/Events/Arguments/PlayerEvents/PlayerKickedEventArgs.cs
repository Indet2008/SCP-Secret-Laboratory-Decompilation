namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerKickedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Issuer { get; }

		public string Reason { get; }

		public PlayerKickedEventArgs(ReferenceHub hub, ReferenceHub issuer, string reason)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Issuer = global::LabApi.Features.Wrappers.Player.Get(issuer);
			Reason = reason;
		}
	}
}
