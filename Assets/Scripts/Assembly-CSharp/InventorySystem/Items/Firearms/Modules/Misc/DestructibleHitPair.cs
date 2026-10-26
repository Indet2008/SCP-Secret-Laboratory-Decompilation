using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public readonly struct DestructibleHitPair
	{
		public readonly IDestructible Destructible;

		public readonly HitRayPair Raycast;

		public Ray Ray => Raycast.Ray;

		public RaycastHit Hit => Raycast.Hit;

		public DestructibleHitPair(IDestructible destructible, RaycastHit hit, Ray ray)
		{
			Destructible = destructible;
			Raycast = new HitRayPair(ray, hit);
		}
	}
}
