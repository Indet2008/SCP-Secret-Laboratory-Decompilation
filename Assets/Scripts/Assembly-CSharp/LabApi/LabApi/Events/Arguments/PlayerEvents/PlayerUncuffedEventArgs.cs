namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUncuffedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool CanUnDetainAsScp { get; }

		public PlayerUncuffedEventArgs(ReferenceHub hub, ReferenceHub target, bool canUnDetainAsScp)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			CanUnDetainAsScp = canUnDetainAsScp;
		}
	}
}
