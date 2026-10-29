using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class HumanPingProcessor : IPingProcessor
	{
		private const float HumanRangeSqr = 0.64f;

		private const float HumanHeight = 1.5f;

		private const int HitboxLayer = 8192;

		public float Range => 60f;

		public LayerMask Mask => VisionInformation.VisionLayerMask;

		public int IconId => 7;

		public bool TryProcess(RaycastHit hit)
		{
			ReferenceHub best;
			return TryGetHuman(hit.point, out best);
		}

		public static bool TryGetHuman(Vector3 hitPos, out ReferenceHub best)
		{
			best = null;
			float num = 0.64f;
			bool result = false;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.GetRoleId().IsHuman() && allHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					Vector3 position = fpcRole.FpcModule.Position;
					if (!(Mathf.Abs(position.y - hitPos.y) > 1.5f))
					{
						float num2 = position.x - hitPos.x;
						float num3 = position.z - hitPos.z;
						float num4 = num2 * num2 + num3 * num3;
						if (!(num4 > num))
						{
							best = allHub;
							num = num4;
							result = true;
						}
					}
				}
			}
			return result;
		}
	}
}
