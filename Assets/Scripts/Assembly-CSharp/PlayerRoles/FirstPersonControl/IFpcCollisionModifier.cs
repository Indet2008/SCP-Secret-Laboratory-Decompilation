using System;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public interface IFpcCollisionModifier
	{
		LayerMask DetectionMask { get; }

		void ProcessColliders(ArraySegment<Collider> detections);
	}
}
