namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939CreatingAmnesticCloudEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp939CreatingAmnesticCloudEventArgs(ReferenceHub hub)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
