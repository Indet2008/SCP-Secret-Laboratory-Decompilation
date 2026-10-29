namespace LabApi.Events.Arguments.Scp049Events
{
	public class Scp049AttackedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool InstantKill { get; }

		public bool IsSenseTarget { get; }

		public Scp049AttackedEventArgs(ReferenceHub hub, ReferenceHub target, bool instantKill, bool isSenseTarget)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			InstantKill = instantKill;
			IsSenseTarget = isSenseTarget;
		}
	}
}
