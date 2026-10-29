namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173SnappingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; set; }

		public bool IsAllowed { get; set; }

		public Scp173SnappingEventArgs(ReferenceHub hub, ReferenceHub target)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
		}
	}
}
