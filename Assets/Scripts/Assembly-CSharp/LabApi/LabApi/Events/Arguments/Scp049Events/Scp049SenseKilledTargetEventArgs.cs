namespace LabApi.Events.Arguments.Scp049Events
{
	public class Scp049SenseKilledTargetEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public Scp049SenseKilledTargetEventArgs(ReferenceHub hub, ReferenceHub target)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
		}
	}
}
