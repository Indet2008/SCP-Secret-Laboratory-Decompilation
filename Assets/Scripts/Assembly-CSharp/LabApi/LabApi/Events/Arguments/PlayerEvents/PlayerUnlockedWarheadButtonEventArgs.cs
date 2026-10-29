namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUnlockedWarheadButtonEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public PlayerUnlockedWarheadButtonEventArgs(ReferenceHub hub)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
