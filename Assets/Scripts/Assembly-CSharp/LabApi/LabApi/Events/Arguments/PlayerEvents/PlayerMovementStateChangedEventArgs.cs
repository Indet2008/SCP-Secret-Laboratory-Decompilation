namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerMovementStateChangedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.FirstPersonControl.PlayerMovementState OldState { get; }

		public global::PlayerRoles.FirstPersonControl.PlayerMovementState NewState { get; }

		public PlayerMovementStateChangedEventArgs(ReferenceHub hub, global::PlayerRoles.FirstPersonControl.PlayerMovementState oldState, global::PlayerRoles.FirstPersonControl.PlayerMovementState newState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldState = oldState;
			NewState = newState;
		}
	}
}
