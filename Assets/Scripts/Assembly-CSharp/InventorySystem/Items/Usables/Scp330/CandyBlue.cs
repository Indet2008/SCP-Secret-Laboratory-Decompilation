using PlayerStatsSystem;

namespace InventorySystem.Items.Usables.Scp330
{
	public class CandyBlue : ICandy
	{
		private const int AhpInstant = 30;

		private const float AhpDecay = 0f;

		public CandyKindID Kind => CandyKindID.Blue;

		public float SpawnChanceWeight { get; private set; } = 1f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerStats.GetModule<AhpStat>().ServerAddProcess(30f).DecayRate = 0f;
		}
	}
}
