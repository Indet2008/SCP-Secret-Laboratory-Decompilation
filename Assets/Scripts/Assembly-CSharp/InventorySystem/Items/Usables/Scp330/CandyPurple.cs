using CustomPlayerEffects;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class CandyPurple : ICandy
	{
		private const int ReductionDuration = 15;

		private const int ReductionIntensity = 40;

		private const bool ReductionStacking = true;

		private const float RegenerationDuration = 10f;

		private const float RegenerationPerSecond = 1.5f;

		public CandyKindID Kind => CandyKindID.Purple;

		public float SpawnChanceWeight { get; private set; } = 1f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			Scp330Bag.AddSimpleRegeneration(hub, 1.5f, 10f);
			DamageReduction effect = hub.playerEffectsController.GetEffect<DamageReduction>();
			effect.Intensity = (byte)Mathf.Max(effect.Intensity, 40);
			effect.ServerChangeDuration(15f, addDuration: true);
		}
	}
}
