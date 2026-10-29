namespace LabApi.Events.Arguments.Scp3114Events
{
	public class Scp3114StartedDanceEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public byte DanceId { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp3114StartedDanceEventArgs(ReferenceHub player, byte danceId)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			DanceId = danceId;
		}
	}
}
