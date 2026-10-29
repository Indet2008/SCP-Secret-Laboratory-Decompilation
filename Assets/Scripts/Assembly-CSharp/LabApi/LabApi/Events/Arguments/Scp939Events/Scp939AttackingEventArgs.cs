namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939AttackingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Target { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public float Damage { get; set; }

		public bool IsAllowed { get; set; }

		public Scp939AttackingEventArgs(ReferenceHub hub, ReferenceHub target, float damage)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Damage = damage;
		}
	}
}
