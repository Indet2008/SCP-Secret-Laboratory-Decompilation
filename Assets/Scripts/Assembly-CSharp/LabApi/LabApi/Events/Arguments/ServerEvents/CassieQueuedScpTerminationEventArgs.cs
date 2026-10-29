namespace LabApi.Events.Arguments.ServerEvents
{
	public class CassieQueuedScpTerminationEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public string Announcement { get; }

		public global::Subtitles.SubtitlePart[] SubtitleParts { get; }

		public global::PlayerStatsSystem.DamageHandlerBase DamageHandler { get; }

		public CassieQueuedScpTerminationEventArgs(ReferenceHub hub, string announcement, global::Subtitles.SubtitlePart[] subtitles, global::PlayerStatsSystem.DamageHandlerBase damageHandler)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Announcement = announcement;
			SubtitleParts = subtitles;
			DamageHandler = damageHandler;
		}
	}
}
