namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUnmutingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Issuer { get; }

		public bool IsIntercom { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerUnmutingEventArgs(ReferenceHub hub, ReferenceHub issuer, bool isIntercom)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Issuer = global::LabApi.Features.Wrappers.Player.Get(issuer);
			IsIntercom = isIntercom;
		}
	}
}
