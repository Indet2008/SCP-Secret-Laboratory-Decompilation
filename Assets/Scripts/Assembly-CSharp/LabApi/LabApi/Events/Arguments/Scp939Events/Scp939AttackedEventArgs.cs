namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939AttackedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public float Damage { get; set; }

		public Scp939AttackedEventArgs(ReferenceHub hub, ReferenceHub target, float damage)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			Damage = damage;
		}
	}
}
