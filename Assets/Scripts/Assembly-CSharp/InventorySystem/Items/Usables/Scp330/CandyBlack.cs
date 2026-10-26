using System.Collections.Generic;
using System.Linq;

namespace InventorySystem.Items.Usables.Scp330
{
	public class CandyBlack : ICandy
	{
		private static readonly List<BlackCandyOutcomeBase> Outcomes = new List<BlackCandyOutcomeBase>
		{
			new DuplicationOutcome(),
			new ExplosionOutcome(),
			new RandomCandyEffectsOutcome(),
			new RandomHauntedEffectsOutcome(),
			new RandomStatusEffectsOutcome(),
			new TeleportOutcome(),
			new VanishOutcome()
		}.Where((BlackCandyOutcomeBase outcome) => outcome.IsAvailable).ToList();

		public CandyKindID Kind => CandyKindID.Black;

		public float SpawnChanceWeight { get; private set; } = 0.25f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			Outcomes.RandomItem().ServerGrant(hub);
		}
	}
}
