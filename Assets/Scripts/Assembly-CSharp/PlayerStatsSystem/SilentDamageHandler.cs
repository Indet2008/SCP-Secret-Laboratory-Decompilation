using System;
using PlayerStatsSystem.Modifiers;
using Subtitles;

namespace PlayerStatsSystem
{
	public class SilentDamageHandler : StandardDamageHandler, IDeathRagdollModifier, IDeathInventoryModifier
	{
		public override float Damage { get; set; } = -1f;

		public override string RagdollInspectText { get; } = string.Empty;

		public override string DeathScreenText => DeathTranslations.Unknown.DeathscreenTranslation;

		public override string ServerLogsText { get; } = "Unknown";

		public override CassieAnnouncement CassieDeathAnnouncement { get; } = new CassieAnnouncement
		{
			Announcement = string.Empty,
			SubtitleParts = Array.Empty<SubtitlePart>()
		};

		public bool PreventRagdollSpawn => true;

		public bool PreventDropInventory => true;
	}
}
