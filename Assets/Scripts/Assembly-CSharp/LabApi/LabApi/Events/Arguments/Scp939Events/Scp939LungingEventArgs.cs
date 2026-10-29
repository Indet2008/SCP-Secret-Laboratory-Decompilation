namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939LungingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public bool IsAllowed { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.PlayableScps.Scp939.Scp939LungeState LungeState { get; set; }

		public Scp939LungingEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp939.Scp939LungeState lungeState)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			LungeState = lungeState;
		}
	}
}
