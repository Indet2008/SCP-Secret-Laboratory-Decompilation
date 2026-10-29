namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangedSpectatorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player OldTarget { get; }

		public global::LabApi.Features.Wrappers.Player NewTarget { get; }

		public PlayerChangedSpectatorEventArgs(ReferenceHub hub, ReferenceHub oldTarget, ReferenceHub newTarget)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldTarget = global::LabApi.Features.Wrappers.Player.Get(oldTarget);
			NewTarget = global::LabApi.Features.Wrappers.Player.Get(newTarget);
		}
	}
}
