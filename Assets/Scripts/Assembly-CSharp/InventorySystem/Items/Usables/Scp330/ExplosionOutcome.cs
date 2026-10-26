using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class ExplosionOutcome : BlackCandyOutcomeBase
	{
		public override void ServerGrant(ReferenceHub target)
		{
			if (!Scp330Candies.CandiesById.TryGetValue(CandyKindID.Pink, out var value))
			{
				Debug.LogError("SCP330-ExplosionOutcome: ExplosionOutcome: Pink candy not found in candy registry.");
			}
			else
			{
				value.ServerApplyEffects(target);
			}
		}
	}
}
