namespace LabApi.Events.Arguments.Scp049Events
{
	public class Scp049ResurrectingBodyEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.IRagdollEvent
	{
		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; set; }

		public bool IsAllowed { get; set; }

		public Scp049ResurrectingBodyEventArgs(global::LabApi.Features.Wrappers.Ragdoll ragdoll, ReferenceHub target, ReferenceHub hub)
		{
			Ragdoll = ragdoll;
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsAllowed = true;
		}
	}
}
