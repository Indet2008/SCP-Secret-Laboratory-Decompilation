namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106ChangedStalkModeEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public bool IsStalkActive { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp106ChangedStalkModeEventArgs(ReferenceHub hub, bool active)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsStalkActive = active;
		}
	}
}
