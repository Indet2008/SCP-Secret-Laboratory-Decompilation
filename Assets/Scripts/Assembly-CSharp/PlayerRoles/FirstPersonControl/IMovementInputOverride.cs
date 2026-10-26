using UnityEngine;

namespace PlayerRoles.FirstPersonControl
{
	public interface IMovementInputOverride
	{
		bool MovementOverrideActive { get; }

		Vector3 MovementOverrideDirection { get; }
	}
}
