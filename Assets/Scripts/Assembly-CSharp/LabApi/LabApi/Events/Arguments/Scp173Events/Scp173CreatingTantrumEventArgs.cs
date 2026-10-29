namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173CreatingTantrumEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp173CreatingTantrumEventArgs(ReferenceHub hub)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
