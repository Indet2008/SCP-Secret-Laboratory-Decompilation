using InventorySystem.Items.ThrowableProjectiles;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class ProjectilePingProcessor : IPingProcessor
	{
		private const float Radius = 0.9f;

		private const int Detections = 8;

		private static readonly Collider[] Hit = new Collider[8];

		public float Range => 60f;

		public LayerMask Mask => VisionInformation.VisionLayerMask;

		public int IconId { get; private set; }

		public bool TryProcess(RaycastHit hit)
		{
			int num = Physics.OverlapSphereNonAlloc(hit.point, 0.9f, Hit);
			for (int i = 0; i < num; i++)
			{
				if (Hit[i].gameObject.TryGetComponent<ThrownProjectile>(out var component))
				{
					System.Type type = component.GetType();
					if (type == typeof(ExplosionGrenade))
					{
						IconId = 4;
						return true;
					}
					if (type == typeof(FlashbangGrenade))
					{
						IconId = 5;
						return true;
					}
				}
			}
			return false;
		}
	}
}
