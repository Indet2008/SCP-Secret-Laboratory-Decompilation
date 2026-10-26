using Achievements;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Usables
{
	public class Scp500 : Consumable
	{
		[SerializeField]
		private AnimationCurve _healProgress;

		private const int InstantHealth = 100;

		private const float TotalRegenerationTime = 10f;

		private const int TotalHpToRegenerate = 100;

		private const float AchievementMaxHp = 20f;

		protected override void OnEffectsActivated()
		{
			HealthStat module = base.Owner.playerStats.GetModule<HealthStat>();
			if (module.CurValue < 20f)
			{
				AchievementHandlerBase.ServerAchieve(base.Owner.networkIdentity.connectionToClient, AchievementName.CrisisAverted);
			}
			module.ServerHeal(100f);
			ServerAddRegeneration(_healProgress, 0.1f, 100f);
			base.Owner.playerEffectsController.UseMedicalItem(this);
		}
	}
}
