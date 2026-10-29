namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUncuffingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool CanUnDetainAsScp { get; }

		public bool IsAllowed { get; set; }

		public PlayerUncuffingEventArgs(ReferenceHub hub, ReferenceHub target, bool canUnDetainAsScp)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			CanUnDetainAsScp = canUnDetainAsScp;
		}
	}
}
