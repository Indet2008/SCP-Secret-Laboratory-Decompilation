namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerGroupChangedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IGroupEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public UserGroup Group { get; }

		public PlayerGroupChangedEventArgs(ReferenceHub hub, UserGroup group)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Group = group;
		}
	}
}
