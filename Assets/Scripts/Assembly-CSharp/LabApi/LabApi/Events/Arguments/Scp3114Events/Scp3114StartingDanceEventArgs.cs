namespace LabApi.Events.Arguments.Scp3114Events
{
	public class Scp3114StartingDanceEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public byte DanceId { get; set; }

		public bool IsAllowed { get; set; }

		public Scp3114StartingDanceEventArgs(ReferenceHub player, byte danceId)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			DanceId = danceId;
			IsAllowed = true;
		}
	}
}
