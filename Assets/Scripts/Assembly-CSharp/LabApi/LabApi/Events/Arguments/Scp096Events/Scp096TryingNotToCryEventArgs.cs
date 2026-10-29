namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096TryingNotToCryEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp096TryingNotToCryEventArgs(ReferenceHub hub)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsAllowed = true;
		}
	}
}
