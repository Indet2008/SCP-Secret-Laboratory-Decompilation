namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106ChangingStalkModeEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsStalkActive { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp106ChangingStalkModeEventArgs(ReferenceHub hub, bool active)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsStalkActive = active;
		}
	}
}
