namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939LungedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::PlayerRoles.PlayableScps.Scp939.Scp939LungeState LungeState { get; }

		public Scp939LungedEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp939.Scp939LungeState lungeState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			LungeState = lungeState;
		}
	}
}
