using System.Diagnostics;
using UnityEngine;
using UnityEngine.EventSystems;
using VoiceChat;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryWaveform : UiWaveformVisualizer, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
	{
		private static MimicryWaveform _lastWaveform;

		private readonly Stopwatch _playbackSw = new Stopwatch();

		[SerializeField]
		private RectTransform _trimIndicator;

		[SerializeField]
		private float _minCoverage;

		[SerializeField]
		private float _maxCoverage;

		[SerializeField]
		private Vector2 _trimmerOffset;

		[SerializeField]
		private RectTransform _waveformProgressBar;

		[SerializeField]
		private RectTransform _progressBarLimiter;

		private bool _isSet;

		private bool _isDragging;

		private float _beginDragTime;

		private float _endDragTime;

		private double _startPlaybackTimeOffset;

		private double _playbackTotalDuration;

		private double _playbackMaxDuration;

		private float StopwatchElapsed => (float)(_playbackSw.Elapsed.TotalSeconds + _startPlaybackTimeOffset);

		public bool IsPlaying
		{
			get
			{
				if (_playbackSw.IsRunning)
				{
					return (double)StopwatchElapsed < _playbackMaxDuration;
				}
				return false;
			}
		}

		public void StartPlayback(int totalLengthSamples, out int startSample, out int lengthSamples)
		{
			if (_lastWaveform != null)
			{
				_lastWaveform.StopPlayback();
			}
			_lastWaveform = this;
			_playbackTotalDuration = SamplesToSeconds(totalLengthSamples);
			if (_isSet)
			{
				GetStartStop(out var startTime, out var stopTime);
				startSample = (int)(startTime * (float)totalLengthSamples);
				lengthSamples = (int)(stopTime * (float)totalLengthSamples);
				_startPlaybackTimeOffset = SamplesToSeconds(startSample);
				_playbackMaxDuration = SamplesToSeconds(lengthSamples);
				lengthSamples -= startSample;
			}
			else
			{
				startSample = 0;
				lengthSamples = totalLengthSamples;
				_startPlaybackTimeOffset = 0.0;
				_playbackMaxDuration = _playbackTotalDuration;
			}
			_playbackSw.Start();
		}

		public void StopPlayback()
		{
			_playbackSw.Reset();
		}

		public void OnDrag(PointerEventData eventData)
		{
			if (_isDragging && !TryGetTime(eventData.position, out _endDragTime))
			{
				Apply();
			}
		}

		public void OnPointerUp(PointerEventData eventData)
		{
			if (_isDragging)
			{
				Apply();
			}
		}

		public void OnPointerDown(PointerEventData eventData)
		{
			_isDragging = TryGetTime(eventData.position, out _beginDragTime);
			_isSet = false;
			_endDragTime = _beginDragTime;
		}

		private void Apply()
		{
			float num = Mathf.Abs(_beginDragTime - _endDragTime);
			_isSet = num > _minCoverage && num < _maxCoverage;
			_isDragging = false;
		}

		private bool TryGetTime(Vector2 mousePos, out float percent)
		{
			Rect rect = base.rectTransform.rect;
			Vector2 vector = new Vector2(rect.width, rect.height) * MimicryMenuController.ScaleFactor;
			Vector2 vector2 = mousePos - (Vector2)base.rectTransform.position;
			float num = vector2.x / vector.x + 0.5f;
			percent = Mathf.Clamp01(num);
			if (Mathf.Abs(vector2.y * 2f) < vector.y)
			{
				return Mathf.Approximately(num, percent);
			}
			return false;
		}

		private float SamplesToSeconds(int samples)
		{
			return VoiceChatSettings.SampleToDuartionRate * (float)samples;
		}

		private void GetStartStop(out float startTime, out float stopTime)
		{
			bool flag = _beginDragTime < _endDragTime;
			startTime = (flag ? _beginDragTime : _endDragTime);
			stopTime = (flag ? _endDragTime : _beginDragTime);
		}

		private void Update()
		{
			UpdateProgressBar();
			UpdateTrimIndicator();
		}

		private void UpdateTrimIndicator()
		{
			bool flag = _isDragging || _isSet;
			_trimIndicator.gameObject.SetActive(flag);
			_progressBarLimiter.gameObject.SetActive(flag);
			if (flag)
			{
				GetStartStop(out var startTime, out var stopTime);
				float width = base.rectTransform.rect.width;
				_trimIndicator.offsetMin = startTime * width * Vector2.right - _trimmerOffset;
				_trimIndicator.offsetMax = (1f - stopTime) * width * Vector2.left + _trimmerOffset;
				_progressBarLimiter.localScale = new Vector3(1f - stopTime, 1f, 1f);
			}
		}

		private void UpdateProgressBar()
		{
			double num = (IsPlaying ? ((double)StopwatchElapsed / _playbackTotalDuration) : 1.0);
			_waveformProgressBar.localScale = new Vector3((float)num, 1f, 1f);
		}
	}
}
