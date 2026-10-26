using UnityEngine;

public static class AnimationCurveUtils
{
	public static AnimationCurve MakeLinearCurve(Keyframe[] keyframes, WrapMode preWrapMode = WrapMode.Once, WrapMode postWrapMode = WrapMode.Once)
	{
		return new AnimationCurve(MakeLinearKeyframes(keyframes))
		{
			preWrapMode = preWrapMode,
			postWrapMode = postWrapMode
		};
	}

	public static Keyframe[] MakeLinearKeyframes(params Keyframe[] keyframes)
	{
		for (int i = 0; i < keyframes.Length; i++)
		{
			keyframes[i] = MakeLinearKeyframe(keyframes[i]);
		}
		return keyframes;
	}

	public static Keyframe MakeLinearKeyframe(float time, float value)
	{
		return new Keyframe(time, value, 0f, 0f, 0f, 0f);
	}

	public static Keyframe MakeLinearKeyframe(Keyframe keyframe)
	{
		return MakeLinearKeyframe(keyframe.time, keyframe.value);
	}
}
