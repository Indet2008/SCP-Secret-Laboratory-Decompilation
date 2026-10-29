namespace LabApi.Events.Arguments.Scp3114Events
{
	public class Scp3114RevealedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool Forced { get; }

		public Scp3114RevealedEventArgs(ReferenceHub player, bool forced)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Forced = forced;
		}
	}
}
