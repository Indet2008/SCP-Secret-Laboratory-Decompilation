namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDetectedByScp1344EventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; set; }

		public PlayerDetectedByScp1344EventArgs(ReferenceHub player, ReferenceHub target)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
		}
	}
}
