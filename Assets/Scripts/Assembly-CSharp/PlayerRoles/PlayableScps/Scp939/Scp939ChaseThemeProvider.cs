using System;
using System.Collections.Generic;
using System.Diagnostics;
using AudioPooling;
using FacilitySoundtrack.ChaseThemes;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp939.Ripples;
using PlayerRoles.PlayableScps.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939ChaseThemeProvider : FpcStandardChaseThemeProvider<Scp939Role>
	{
		private enum TrackType
		{
			None = 0,
			Quiet = 1,
			MadeSound = 2,
			Detected = 3
		}

		[Serializable]
		private class Track939
		{
			public TrackType Type;

			public AudioClip Clip;

			public float MinSustain;

			public float FadeInSpeed;

			public float FadeOutSpeed;

			public float MaxVolume;

			public DesiredChaseClip GetDesiredChaseClip(TrackType curTrack)
			{
				return new DesiredChaseClip(Clip, (curTrack == Type) ? MaxVolume : 0f, FadeInSpeed, FadeOutSpeed);
			}
		}

		private readonly struct SelfReportedRipple
		{
			public readonly int Range;

			public readonly double Time;

			public double Elapsed => NetworkTime.time - Time;

			public SelfReportedRipple(int range)
			{
				Range = range;
				Time = NetworkTime.time;
			}
		}

		private const float SelfReportedTokenDuration = 3f;

		private readonly Stopwatch _trackSustain = new Stopwatch();

		private readonly List<SelfReportedRipple> _selfReportedRipples = new List<SelfReportedRipple>();

		[SerializeField]
		private StingerThresholdPair[] _stingers;

		[SerializeField]
		private Track939[] _tracks;

		private TrackType _curTrack;

		private Scp939VisibilityController _visController;

		private float _lastMinSustain;

		private int LoudestRecentlySelfReportedSound
		{
			get
			{
				int num = 0;
				foreach (SelfReportedRipple selfReportedRipple in _selfReportedRipples)
				{
					if (!(selfReportedRipple.Elapsed > 3.0))
					{
						num = Mathf.Max(num, selfReportedRipple.Range);
					}
				}
				return num;
			}
		}

		private float SqrDistanceFrom939 => base.ScpRole.SqrDistanceTo(MainCameraController.LastPosition);

		private bool WithinDetectionRange
		{
			get
			{
				float currentDetectionRange = _visController.CurrentDetectionRange;
				return SqrDistanceFrom939 <= currentDetectionRange * currentDetectionRange;
			}
		}

		private void OnSelfReportedSound(float selfReportedValue)
		{
			int num = Mathf.RoundToInt(selfReportedValue);
			int? num2 = null;
			for (int num3 = _selfReportedRipples.Count - 1; num3 >= 0; num3--)
			{
				SelfReportedRipple selfReportedRipple = _selfReportedRipples[num3];
				if (selfReportedRipple.Range == num)
				{
					num2 = num3;
				}
				else if (selfReportedRipple.Elapsed > 3.0)
				{
					_selfReportedRipples.RemoveAt(num3);
					if (num2.HasValue)
					{
						num2--;
					}
				}
			}
			if (num2.HasValue)
			{
				_selfReportedRipples[num2.Value] = new SelfReportedRipple(num);
			}
			else
			{
				_selfReportedRipples.Add(new SelfReportedRipple(num));
			}
		}

		private TrackType GetDesiredTrack()
		{
			if (WithinDetectionRange)
			{
				return TrackType.Detected;
			}
			float num = LoudestRecentlySelfReportedSound;
			bool num2 = SqrDistanceFrom939 < num * num;
			TrackType result = ((_curTrack == TrackType.Detected) ? TrackType.Detected : TrackType.MadeSound);
			if (!num2)
			{
				return TrackType.Quiet;
			}
			return result;
		}

		private void UpdateCurTrack()
		{
			TrackType desiredTrack = GetDesiredTrack();
			if (_curTrack != desiredTrack)
			{
				if (desiredTrack > _curTrack || !_trackSustain.IsRunning || _trackSustain.Elapsed.TotalSeconds > (double)_lastMinSustain)
				{
					_curTrack = desiredTrack;
					_trackSustain.Restart();
				}
			}
			else if (desiredTrack > TrackType.Quiet)
			{
				_trackSustain.Restart();
			}
		}

		private void OnDestroy()
		{
			RippleTriggerBase.OnSelfReported -= OnSelfReportedSound;
		}

		protected override void Awake()
		{
			base.Awake();
			_visController = base.ScpRole.VisibilityController as Scp939VisibilityController;
			RippleTriggerBase.OnSelfReported += OnSelfReportedSound;
		}

		public override bool UpdateChase()
		{
			UpdateCurTrack();
			base.ClipsToPlay.Clear();
			Track939[] tracks = _tracks;
			foreach (Track939 track in tracks)
			{
				base.ClipsToPlay.Add(track.GetDesiredChaseClip(_curTrack));
				if (track.Type == _curTrack)
				{
					_lastMinSustain = track.MinSustain;
				}
			}
			return base.UpdateChase();
		}

		public override void OnChaseStopped()
		{
			base.OnChaseStopped();
			_curTrack = TrackType.None;
		}

		public override AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers)
		{
			base.OnChaseStarted(alreadyPlayedStingers);
			_trackSustain.Reset();
			UpdateCurTrack();
			_selfReportedRipples.Clear();
			if (alreadyPlayedStingers.Count > 0)
			{
				return null;
			}
			if (WithinDetectionRange)
			{
				return FpcStandardChaseThemeProvider<Scp939Role>.PlayStinger(_stingers[^1].Clip);
			}
			return FpcStandardChaseThemeProvider<Scp939Role>.PlayStinger(StingerThresholdPair.GetBest(_stingers, GetPerceivedJumpscareDistance()).Clip);
		}
	}
}
