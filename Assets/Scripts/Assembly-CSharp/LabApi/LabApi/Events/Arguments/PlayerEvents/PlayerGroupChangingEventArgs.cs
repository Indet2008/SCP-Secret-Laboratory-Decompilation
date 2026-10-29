namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerGroupChangingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IGroupEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public UserGroup? Group { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerGroupChangingEventArgs(ReferenceHub hub, UserGroup? group)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Group = group;
			IsAllowed = true;
		}
	}
}
