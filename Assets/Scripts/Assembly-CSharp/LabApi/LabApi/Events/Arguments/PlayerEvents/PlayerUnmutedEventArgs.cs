namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUnmutedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Issuer { get; }

		public bool IsIntercom { get; }

		public PlayerUnmutedEventArgs(ReferenceHub hub, ReferenceHub issuer, bool isIntercom)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Issuer = global::LabApi.Features.Wrappers.Player.Get(issuer);
			IsIntercom = isIntercom;
		}
	}
}
