using UnityEngine;

namespace PlayerRoles
{
	public interface ICameraController
	{
		Vector3 CameraPosition { get; }

		float VerticalRotation { get; }

		float HorizontalRotation { get; }
	}
}
