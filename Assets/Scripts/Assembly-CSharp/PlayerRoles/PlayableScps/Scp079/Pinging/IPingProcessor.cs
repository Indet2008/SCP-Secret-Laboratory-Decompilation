using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public interface IPingProcessor
	{
		float Range { get; }

		LayerMask Mask { get; }

		int IconId { get; }

		bool TryProcess(RaycastHit hit);
	}
}
