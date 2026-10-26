using Mirror;
using PlayerRoles;
using PlayerStatsSystem;

namespace Achievements.Handlers
{
	public class GeneralDamageHandler : AchievementHandlerBase
	{
		private const float WalkItOffThreshHold = 0.5f;

		internal override void OnInitialize()
		{
			PlayerStats.OnAnyPlayerDamaged += AnyDamage;
		}

		private static void AnyDamage(ReferenceHub ply, DamageHandlerBase handler)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			HealthStat module = ply.playerStats.GetModule<HealthStat>();
			if (handler is UniversalDamageHandler universalDamageHandler && universalDamageHandler.TranslationId == DeathTranslations.Falldown.Id && module.CurValue > 0f)
			{
				float num = module.CurValue + universalDamageHandler.Damage;
				if (num > 0f && module.CurValue / num < 0.5f)
				{
					AchievementHandlerBase.ServerAchieve(ply.connectionToClient, AchievementName.WalkItOff);
				}
			}
			if (handler is StandardDamageHandler standardDamageHandler && ply.IsHuman() && module.CurValue > 0f && module.CurValue - standardDamageHandler.AbsorbedAhpDamage <= 0f)
			{
				AchievementHandlerBase.ServerAchieve(ply.networkIdentity.connectionToClient, AchievementName.DidntEvenFeelThat);
			}
		}
	}
}
