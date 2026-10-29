namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079RecontainingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player? Activator { get; }

		public bool IsAllowed { get; set; }

		public Scp079RecontainingEventArgs(ReferenceHub hub, ReferenceHub? activator)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Activator = global::LabApi.Features.Wrappers.Player.Get(activator);
		}
	}
}
