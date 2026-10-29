using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class DefaultPingProcessor : IPingProcessor
	{
		public float Range => 60f;

		public LayerMask Mask => VisionInformation.VisionLayerMask | LayerMask.GetMask("Glass");

		public int IconId => 0;

		public bool TryProcess(RaycastHit hit)
		{
			return true;
		}
	}
}
