namespace LabApi.Events.Arguments.Scp049Events
{
	public class Scp049AttackingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool InstantKill { get; set; }

		public bool IsSenseTarget { get; set; }

		public float CooldownTime { get; set; }

		public bool IsAllowed { get; set; }

		public Scp049AttackingEventArgs(ReferenceHub hub, ReferenceHub target, bool instantKill, bool isSenseTarget, float cooldownTime)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			InstantKill = instantKill;
			IsSenseTarget = isSenseTarget;
			CooldownTime = cooldownTime;
			IsAllowed = true;
		}
	}
}
