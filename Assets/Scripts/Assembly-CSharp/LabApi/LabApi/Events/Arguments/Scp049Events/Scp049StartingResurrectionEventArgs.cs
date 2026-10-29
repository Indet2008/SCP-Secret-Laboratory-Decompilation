namespace LabApi.Events.Arguments.Scp049Events
{
	public class Scp049StartingResurrectionEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.IRagdollEvent
	{
		public bool CanResurrect { get; set; }

		public global::LabApi.Features.Wrappers.Ragdoll Ragdoll { get; }

		public global::LabApi.Features.Wrappers.Player? Target { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp049StartingResurrectionEventArgs(bool canResurrect, global::PlayerRoles.Ragdolls.BasicRagdoll ragdoll, ReferenceHub? target, ReferenceHub hub)
		{
			CanResurrect = canResurrect;
			Ragdoll = global::LabApi.Features.Wrappers.Ragdoll.Get(ragdoll);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsAllowed = true;
		}
	}
}
