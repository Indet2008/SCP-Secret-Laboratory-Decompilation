namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096ChangedStateEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.PlayableScps.Scp096.Scp096RageState State { get; }

		public Scp096ChangedStateEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp096.Scp096RageState state)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			State = state;
		}
	}
}
