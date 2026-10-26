using PlayerStatsSystem;

namespace InventorySystem.Items.Usables.Scp330
{
	public class VanishOutcome : BlackCandyOutcomeBase
	{
		public override void ServerGrant(ReferenceHub target)
		{
			target.playerStats.DealDamage(new SilentDamageHandler());
		}
	}
}
