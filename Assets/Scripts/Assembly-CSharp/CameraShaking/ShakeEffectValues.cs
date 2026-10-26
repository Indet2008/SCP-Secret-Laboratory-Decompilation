using UnityEngine;

namespace CameraShaking
{
	public readonly struct ShakeEffectValues
	{
		public static readonly ShakeEffectValues None = new ShakeEffectValues(null, null, null, 1f, 0f, 0f);

		public readonly Quaternion RootCameraRotation;

		public readonly Quaternion ViewmodelCameraRotation;

		public readonly Vector3 RootCameraPositionOffset;

		public readonly float FovPercent;

		public readonly float VerticalMouseLook;

		public readonly float HorizontalMouseLook;

		public ShakeEffectValues(Quaternion? rootCameraRotation = null, Quaternion? viewmodelCameraRotation = null, Vector3? rootCameraPositionOffset = null, float fovPercent = 1f, float verticalLook = 0f, float horizontalLook = 0f)
		{
			RootCameraRotation = rootCameraRotation ?? Quaternion.identity;
			ViewmodelCameraRotation = viewmodelCameraRotation ?? Quaternion.identity;
			RootCameraPositionOffset = rootCameraPositionOffset ?? Vector3.zero;
			FovPercent = fovPercent;
			VerticalMouseLook = verticalLook;
			HorizontalMouseLook = horizontalLook;
		}
	}
}
