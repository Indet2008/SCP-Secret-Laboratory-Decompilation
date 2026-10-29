namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangedBadgeVisibilityEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsGlobalBadge { get; }

		public bool NewVisibility { get; }

		public PlayerChangedBadgeVisibilityEventArgs(ReferenceHub hub, bool isGlobal, bool newVisibility)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsGlobalBadge = isGlobal;
			NewVisibility = newVisibility;
		}
	}
}
