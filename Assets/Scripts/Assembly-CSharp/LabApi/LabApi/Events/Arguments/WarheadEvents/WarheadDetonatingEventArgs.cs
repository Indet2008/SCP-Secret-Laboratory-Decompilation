namespace LabApi.Events.Arguments.WarheadEvents
{
	public class WarheadDetonatingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; set; }

		public WarheadDetonatingEventArgs(ReferenceHub hub)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
