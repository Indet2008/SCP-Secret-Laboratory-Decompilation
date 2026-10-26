using System;

namespace CameraShaking
{
	[Serializable]
	public struct RecoilSettings
	{
		public float AnimationTime;

		public float ZAxis;

		public float FovKick;

		public float UpKick;

		public float SideKick;

		public RecoilSettings(float animationTime, float zAxis, float fovKick, float upKick, float sideKick)
		{
			AnimationTime = animationTime;
			ZAxis = zAxis;
			FovKick = fovKick;
			UpKick = upKick;
			SideKick = sideKick;
		}
	}
}
