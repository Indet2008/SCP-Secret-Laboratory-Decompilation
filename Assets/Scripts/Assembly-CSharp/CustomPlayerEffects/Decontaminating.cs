using Mirror;
using PlayerRoles;
using PlayerStatsSystem;
using Subtitles;

namespace CustomPlayerEffects
{
	public class Decontaminating : TickingEffectBase
	{
		private const string CassieAnnouncement = "LOST IN DECONTAMINATION SEQUENCE";

		private float numberOfTicks;

		public float FogFadeInSpeed;

		public float FogFadeOutSpeed;

		public override bool AllowEnabling => true;

		protected override void OnTick()
		{
			if (NetworkServer.active && base.Hub.roleManager.CurrentRole is IHealthbarRole healthbarRole)
			{
				float damage = healthbarRole.MaxHealth / 10f + 5f * numberOfTicks;
				numberOfTicks++;
				DamageHandlerBase.CassieAnnouncement cassieAnnouncement = new DamageHandlerBase.CassieAnnouncement();
				cassieAnnouncement.Announcement = "LOST IN DECONTAMINATION SEQUENCE";
				cassieAnnouncement.SubtitleParts = new SubtitlePart[1]
				{
					new SubtitlePart(SubtitleType.LostInDecontamination, (string[])null)
				};
				DamageHandlerBase.CassieAnnouncement cassieAnnouncement2 = cassieAnnouncement;
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(damage, DeathTranslations.Decontamination, cassieAnnouncement2));
			}
		}

		// Client half restored from the client build: decontamination fog for the local/spectated player.
		protected override void Enabled()
		{
			base.Enabled();
			if (IsPOV)
			{
				CustomRendering.FogController.EnableFogType(CustomRendering.FogType.Decontamination, FogFadeInSpeed);
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			numberOfTicks = 0f;
			if (IsPOV)
			{
				CustomRendering.FogController.DisableFogType(CustomRendering.FogType.Decontamination, FogFadeOutSpeed);
			}
		}

		public override void OnBeginSpectating()
		{
			base.OnBeginSpectating();
			if (IsEnabled)
			{
				CustomRendering.FogController.EnableFogType(CustomRendering.FogType.Decontamination);
			}
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			CustomRendering.FogController.DisableFogType(CustomRendering.FogType.Decontamination);
		}
	}
}
