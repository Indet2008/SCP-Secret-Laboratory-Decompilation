namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUsingIntercomEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.Voice.IntercomState State { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerUsingIntercomEventArgs(ReferenceHub hub, global::PlayerRoles.Voice.IntercomState state)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			State = state;
		}
	}
}
