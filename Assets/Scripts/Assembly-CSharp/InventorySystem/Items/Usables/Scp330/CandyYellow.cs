using CustomPlayerEffects;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class CandyYellow : ICandy
	{
		private const int InstantStamina = 25;

		private const int InvigorationDuration = 8;

		private const bool InvigorationDurationStacking = true;

		private const int BoostDuration = 8;

		private const bool BoostDurationStacking = true;

		private const int BoostIntensity = 10;

		private const bool BoostIntensityStacking = true;

		public CandyKindID Kind => CandyKindID.Yellow;

		public float SpawnChanceWeight { get; private set; } = 1f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerStats.GetModule<StaminaStat>().AddAmount(0.25f);
			hub.playerEffectsController.EnableEffect<Invigorated>(8f, addDuration: true);
			MovementBoost effect = hub.playerEffectsController.GetEffect<MovementBoost>();
			int value = effect.Intensity + 10;
			effect.Intensity = (byte)Mathf.Clamp(value, 0, 255);
			effect.ServerChangeDuration(8f, addDuration: true);
		}
	}
}
