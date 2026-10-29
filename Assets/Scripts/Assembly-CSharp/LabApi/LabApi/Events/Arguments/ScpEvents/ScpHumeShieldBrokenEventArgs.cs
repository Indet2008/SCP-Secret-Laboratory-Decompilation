namespace LabApi.Events.Arguments.ScpEvents
{
	public class ScpHumeShieldBrokenEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ScpHumeShieldBrokenEventArgs(ReferenceHub player)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
		}
	}
}
