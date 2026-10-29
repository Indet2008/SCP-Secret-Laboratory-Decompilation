namespace LabApi.Events.Arguments.Scp3114Events
{
	public class Scp3114StrangleAbortedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public Scp3114StrangleAbortedEventArgs(ReferenceHub scp3114Hub, ReferenceHub targetHub)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(scp3114Hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(targetHub);
		}
	}
}
