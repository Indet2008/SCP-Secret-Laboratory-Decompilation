using System;
using UnityEngine;

namespace PlayerRoles.Ragdolls
{
	[Serializable]
	public struct HitboxData
	{
		public Rigidbody Target;

		public HitboxType RelatedHitbox;
	}
}
