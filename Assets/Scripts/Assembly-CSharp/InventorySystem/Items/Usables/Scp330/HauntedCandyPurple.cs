using System;
using CustomPlayerEffects;
using PlayerStatsSystem;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyPurple : ICandy
	{
		public const int EffectDuration = 40;

		private const float AhpAmount = 330f;

		private const float AhpDecayRate = 8.25f;

		private const float AhpEfficiency = 1f;

		public CandyKindID Kind => CandyKindID.Purple;

		public float SpawnChanceWeight { get; private set; } = 11f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.EnableEffect<SlowMetabolism>(40f);
			if (!hub.playerStats.TryGetModule<AhpStat>(out var module))
			{
				throw new Exception("Could not find the AhpStat module.");
			}
			module.ServerAddProcess(330f, 330f, 8.25f, 1f, 0f, persistant: false);
		}
	}
}
