using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class SingleBulletHitscan : HitscanHitregModuleBase
	{
		protected override void Fire()
		{
			Ray targetRay = RandomizeRay(base.ForwardRay, base.CurrentInaccuracy);
			ServerApplyDamage(ServerPrescan(targetRay));
		}
	}
}
