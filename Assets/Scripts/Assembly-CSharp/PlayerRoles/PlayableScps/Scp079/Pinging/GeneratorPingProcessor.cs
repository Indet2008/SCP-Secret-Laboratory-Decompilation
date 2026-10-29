using MapGeneration.Distributors;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class GeneratorPingProcessor : IPingProcessor
	{
		public float Range => 90f;

		public LayerMask Mask => VisionInformation.VisionLayerMask;

		public int IconId => 3;

		public bool TryProcess(RaycastHit hit)
		{
			return hit.collider.GetComponentInParent<Scp079Generator>() != null;
		}
	}
}
