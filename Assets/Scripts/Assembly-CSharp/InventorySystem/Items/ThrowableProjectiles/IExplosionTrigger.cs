using Footprinting;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public interface IExplosionTrigger
	{
		void OnExplosionDetected(Footprint attacker, Vector3 source, float range);
	}
}
