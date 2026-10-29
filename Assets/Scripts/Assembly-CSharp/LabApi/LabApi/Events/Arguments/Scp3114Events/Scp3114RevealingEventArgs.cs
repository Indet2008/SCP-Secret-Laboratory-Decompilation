namespace LabApi.Events.Arguments.Scp3114Events
{
	public class Scp3114RevealingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool Forced { get; }

		public bool IsAllowed { get; set; }

		public Scp3114RevealingEventArgs(ReferenceHub player, bool forced)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(player);
			Forced = forced;
			IsAllowed = true;
		}
	}
}
