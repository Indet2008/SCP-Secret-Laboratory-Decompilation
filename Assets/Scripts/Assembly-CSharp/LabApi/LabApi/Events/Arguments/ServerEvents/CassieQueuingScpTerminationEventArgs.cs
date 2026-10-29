namespace LabApi.Events.Arguments.ServerEvents
{
	public class CassieQueuingScpTerminationEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public string Announcement { get; set; }

		public global::Subtitles.SubtitlePart[] SubtitleParts { get; set; }

		public bool IsAllowed { get; set; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; }

		public CassieQueuingScpTerminationEventArgs(ReferenceHub hub, string announcement, global::Subtitles.SubtitlePart[] subtitles, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Announcement = announcement;
			SubtitleParts = global::System.Linq.Enumerable.ToArray(subtitles);
			DamageHandler = damageHandler;
		}
	}
}
