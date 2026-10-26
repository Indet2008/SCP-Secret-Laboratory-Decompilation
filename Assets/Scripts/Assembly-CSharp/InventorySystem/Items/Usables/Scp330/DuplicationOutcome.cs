using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class DuplicationOutcome : BlackCandyOutcomeBase
	{
		public override void ServerGrant(ReferenceHub target)
		{
			if (!(target.inventory.CurInstance is Scp330Bag scp330Bag))
			{
				Debug.LogError("SCP330-DuplicationOutcome: Target player does not have a SCP-330 bag equipped.");
				return;
			}
			scp330Bag.TryAddSpecific(CandyKindID.Black);
			scp330Bag.TryAddSpecific(CandyKindID.Black);
		}
	}
}
