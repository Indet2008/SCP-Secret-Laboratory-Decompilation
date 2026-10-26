using MapGeneration;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public class TeslaOverconRenderer : PooledOverconRenderer
	{
		private static readonly Vector3 Offset = new Vector3(0f, 2.2f, 0f);

		internal override void SpawnOvercons(Scp079Camera newCamera)
		{
			ReturnAll();
			foreach (TeslaGate allGate in TeslaGate.AllGates)
			{
				Vector3 position = allGate.transform.position;
				if (newCamera.Position.CompareCoords(position))
				{
					TeslaOvercon fromPool = GetFromPool<TeslaOvercon>();
					fromPool.transform.position = position + Offset;
					fromPool.Rescale(newCamera);
				}
			}
		}
	}
}
