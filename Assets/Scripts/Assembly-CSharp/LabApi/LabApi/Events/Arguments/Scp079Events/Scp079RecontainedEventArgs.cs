namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079RecontainedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player? Activator { get; }

		public Scp079RecontainedEventArgs(ReferenceHub hub, ReferenceHub? activator)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Activator = global::LabApi.Features.Wrappers.Player.Get(activator);
		}
	}
}
