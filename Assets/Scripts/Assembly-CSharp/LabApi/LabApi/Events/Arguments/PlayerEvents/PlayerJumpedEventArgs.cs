namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerJumpedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public float JumpStrength { get; }

		public PlayerJumpedEventArgs(ReferenceHub hub, float jumpStrength)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			JumpStrength = jumpStrength;
		}
	}
}
