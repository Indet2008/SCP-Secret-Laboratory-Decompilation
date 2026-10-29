namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096ChangingStateEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.PlayableScps.Scp096.Scp096RageState State { get; set; }

		public bool IsAllowed { get; set; }

		public Scp096ChangingStateEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp096.Scp096RageState state)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			State = state;
			IsAllowed = true;
		}
	}
}
