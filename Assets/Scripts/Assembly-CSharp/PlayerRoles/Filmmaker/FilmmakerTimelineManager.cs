using System;
using System.Collections.Generic;
using UnityEngine;

namespace PlayerRoles.Filmmaker
{
	public static class FilmmakerTimelineManager
	{
		public const float FrameRate = 50f;

		public const float InvFrameRate = 0.02f;

		public static readonly FilmmakerTrack<Vector3> PositionTrack = new FilmmakerTrack<Vector3>(Vector3.up * 1001f);

		public static readonly FilmmakerTrack<Quaternion> RotationTrack = new FilmmakerTrack<Quaternion>(Quaternion.identity);

		public static readonly FilmmakerTrack<float> ZoomTrack = new FilmmakerTrack<float>(1f);

		public static readonly IFilmmakerTrack[] AllTracks = new IFilmmakerTrack[3] { PositionTrack, RotationTrack, ZoomTrack };

		private static readonly Dictionary<FilmmakerBlendPreset, AnimationCurve> BlendPresets = new Dictionary<FilmmakerBlendPreset, AnimationCurve>
		{
			[FilmmakerBlendPreset.Linear] = AnimationCurve.Linear(0f, 0f, 1f, 1f),
			[FilmmakerBlendPreset.Smooth] = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f),
			[FilmmakerBlendPreset.Hold] = AnimationCurve.Constant(0f, 1f, 0f),
			[FilmmakerBlendPreset.FetchNext] = AnimationCurve.Constant(0f, 1f, 1f)
		};

		public static float TimeSeconds { get; set; }

		public static int TimeFrames
		{
			get
			{
				return Mathf.RoundToInt(TimeSeconds * 50f);
			}
			set
			{
				TimeSeconds = (float)value * 0.02f;
			}
		}

		public static void UpdatePlayback()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is FilmmakerRole filmmakerRole)
			{
				filmmakerRole.CameraPosition = EvaluateParam(PositionTrack, Vector3.Lerp);
				filmmakerRole.CameraRotation = EvaluateParam(RotationTrack, Quaternion.Lerp);
				FilmmakerRole.ZoomScale = EvaluateParam(ZoomTrack, Mathf.Lerp);
			}
		}

		private static T EvaluateParam<T>(FilmmakerTrack<T> selector, Func<T, T, float, T> lerp) where T : struct
		{
			FilmmakerKeyframe<T>[] keyframes = selector.Keyframes;
			FilmmakerKeyframe<T> filmmakerKeyframe = null;
			FilmmakerKeyframe<T> filmmakerKeyframe2 = null;
			int timeFrames = TimeFrames;
			for (int num = keyframes.Length - 1; num >= 0; num--)
			{
				if (keyframes[num].TimeFrames <= timeFrames)
				{
					filmmakerKeyframe = keyframes[num];
					break;
				}
			}
			for (int i = 0; i < keyframes.Length; i++)
			{
				if (keyframes[i].TimeFrames >= timeFrames)
				{
					filmmakerKeyframe2 = keyframes[i];
					break;
				}
			}
			if (filmmakerKeyframe == null)
			{
				filmmakerKeyframe = filmmakerKeyframe2;
			}
			if (filmmakerKeyframe2 == null)
			{
				filmmakerKeyframe2 = filmmakerKeyframe;
			}
			if (filmmakerKeyframe2 == null || filmmakerKeyframe == null)
			{
				return selector.DefaultValue;
			}
			AnimationCurve animationCurve = BlendPresets[filmmakerKeyframe.BlendCurve];
			float a = (float)filmmakerKeyframe.TimeFrames * 0.02f;
			float b = (float)filmmakerKeyframe2.TimeFrames * 0.02f;
			float time = Mathf.InverseLerp(a, b, TimeSeconds);
			return lerp(filmmakerKeyframe.Value, filmmakerKeyframe2.Value, animationCurve.Evaluate(time));
		}
	}
}
