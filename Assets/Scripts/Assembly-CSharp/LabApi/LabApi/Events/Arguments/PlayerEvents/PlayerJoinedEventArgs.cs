namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerJoinedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public PlayerJoinedEventArgs(ReferenceHub hub)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
