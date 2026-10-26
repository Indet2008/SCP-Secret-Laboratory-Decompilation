using Mirror;
using PlayerRoles.Ragdolls;
using PlayerRoles.Spectating;
using Subtitles;

namespace PlayerStatsSystem
{
	public abstract class DamageHandlerBase
	{
		public class CassieAnnouncement
		{
			public static readonly CassieAnnouncement Default = new CassieAnnouncement
			{
				Announcement = "SUCCESSFULLY TERMINATED . TERMINATION CAUSE UNSPECIFIED",
				SubtitleParts = new SubtitlePart[1]
				{
					new SubtitlePart(SubtitleType.TerminationCauseUnspecified, (string[])null)
				}
			};

			public string Announcement;

			public SubtitlePart[] SubtitleParts;
		}

		public enum HandlerOutput : byte
		{
			Nothing = 0,
			Damaged = 1,
			Death = 2
		}

		public abstract string RagdollInspectText { get; }

		public abstract string DeathScreenText { get; }

		public abstract string ServerLogsText { get; }

		public abstract string ServerMetricsText { get; }

		public abstract CassieAnnouncement CassieDeathAnnouncement { get; }

		public virtual void WriteDeathScreen(NetworkWriter writer)
		{
			writer.WriteSpawnReason(SpectatorSpawnReason.Other);
			writer.WriteUInt(0u);
			writer.WriteDamageHandler(this);
		}

		public virtual void WriteAdditionalData(NetworkWriter writer)
		{
		}

		public virtual void ReadAdditionalData(NetworkReader reader)
		{
		}

		public virtual void ProcessRagdoll(BasicRagdoll ragdoll)
		{
		}

		public abstract HandlerOutput ApplyDamage(ReferenceHub ply);
	}
}
