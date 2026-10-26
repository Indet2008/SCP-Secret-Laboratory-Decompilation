using PlayerRoles.PlayableScps.Scp079.Cameras;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Overcons
{
	public abstract class OverconRendererBase : MonoBehaviour
	{
		internal abstract void SpawnOvercons(Scp079Camera newCamera);
	}
}
