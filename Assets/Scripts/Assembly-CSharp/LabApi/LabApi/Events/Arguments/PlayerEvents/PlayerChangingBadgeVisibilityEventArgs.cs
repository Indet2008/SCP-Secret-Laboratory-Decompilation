namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangingBadgeVisibilityEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsGlobalBadge { get; }

		public bool NewVisibility { get; }

		public bool IsAllowed { get; set; }

		public PlayerChangingBadgeVisibilityEventArgs(ReferenceHub hub, bool isGlobal, bool newVisibility)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsGlobalBadge = isGlobal;
			NewVisibility = newVisibility;
			IsAllowed = true;
		}
	}
}
