namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUsedIntercomEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player? Player { get; }

		public global::PlayerRoles.Voice.IntercomState State { get; }

		public PlayerUsedIntercomEventArgs(ReferenceHub? hub, global::PlayerRoles.Voice.IntercomState state)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			State = state;
		}
	}
}
