using System;
using UnityEngine;

namespace Hints
{
	public static class HintEffectPresets
	{
		public static Keyframe[] CreateBumpKeyframes(float floorValue, float bumpValue, int count, float duration = 1f)
		{
			Keyframe[] array = new Keyframe[count * 2 + 1];
			float num = duration / (float)array.Length;
			float num2 = 0f;
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = new Keyframe(num2, (i % 2 == 0) ? floorValue : bumpValue);
				num2 += num;
			}
			return array;
		}

		public static AnimationCurve CreateBumpCurve(float floorValue, float bumpValue, int count, float duration = 1f)
		{
			return new AnimationCurve(CreateBumpKeyframes(floorValue, bumpValue, count, duration))
			{
				postWrapMode = WrapMode.Loop
			};
		}

		public static AnimationCurve CreateTrailingBumpCurve(float floorValue, float bumpValue, int count, float startTrailPercent, float duration = 1f)
		{
			Keyframe[] array = CreateBumpKeyframes(floorValue, bumpValue, count, duration * startTrailPercent);
			Array.Resize(ref array, array.Length + 1);
			array[^1] = new Keyframe(duration, floorValue);
			return new AnimationCurve(array)
			{
				postWrapMode = WrapMode.Loop
			};
		}

		public static AlphaCurveHintEffect FadeIn(float durationScalar = 1f, float startScalar = 0f, float iterations = 1f)
		{
			AnimationCurve animationCurve = AnimationCurve.EaseInOut(0f, 0f, iterations, 1f);
			animationCurve.postWrapMode = WrapMode.Loop;
			return new AlphaCurveHintEffect(animationCurve, startScalar, durationScalar);
		}

		public static AlphaCurveHintEffect FadeOut(float durationScalar = 1f, float startScalar = 0f, float iterations = 1f)
		{
			AnimationCurve animationCurve = AnimationCurve.EaseInOut(0f, 1f, iterations, 0f);
			animationCurve.postWrapMode = WrapMode.Loop;
			return new AlphaCurveHintEffect(animationCurve, startScalar, durationScalar);
		}

		public static HintEffect[] FadeInAndOut(float window, float durationScalar = 1f, float startScalar = 0f)
		{
			float num = (durationScalar - window) / 2f;
			return new HintEffect[2]
			{
				FadeIn(num, startScalar),
				FadeOut(num, startScalar + durationScalar - num)
			};
		}

		public static AlphaCurveHintEffect PulseAlpha(float floorValue, float peakValue, float iterationScalar = 1f, float startOffset = 0f)
		{
			return new AlphaCurveHintEffect(CreateBumpCurve(floorValue, peakValue, 1, iterationScalar), startOffset);
		}

		public static AlphaCurveHintEffect TrailingPulseAlpha(float floorValue, float peakValue, float startTrailScalar, float iterationScalar = 1f, float startScalar = 0f, int count = 1)
		{
			return new AlphaCurveHintEffect(CreateTrailingBumpCurve(floorValue, peakValue, count, startTrailScalar, iterationScalar), startScalar);
		}
	}
}
