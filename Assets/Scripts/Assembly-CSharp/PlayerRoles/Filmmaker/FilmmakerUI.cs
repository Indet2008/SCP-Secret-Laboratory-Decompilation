using System.Diagnostics;
using System.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Filmmaker
{
	public class FilmmakerUI : MonoBehaviour
	{
		private enum FilmmakerKey
		{
			UpdatePlayback = 32,
			JumpToBeginning = 278,
			JumpToEnd = 279,
			RemoveKeyframe = 127,
			JumpForward = 275,
			JumpBackward = 276
		}

		[SerializeField]
		private Toggle _automaticPreview;

		[SerializeField]
		private Slider _playbackSpeedPercent;

		[SerializeField]
		private TMP_Text _playbackSpeedText;

		[SerializeField]
		private TMP_Dropdown _blendModeDropdown;

		private const float ClearAllTime = 5f;

		private float _playbackSpeed = 1f;

		private Canvas _canvas;

		private readonly Stopwatch _clearStopwatch = Stopwatch.StartNew();

		private Transform CurCam => MainCameraController.CurrentCamera;

		private FilmmakerBlendPreset BlendPreset => (FilmmakerBlendPreset)_blendModeDropdown.value;

		private void Awake()
		{
			_canvas = GetComponent<Canvas>();
			_canvas.enabled = HideHUDController.IsHUDVisible;
			HideHUDController.ToggleHUD += OnHideHudChanged;
			FilmmakerKeyframesRenderer.OnTimeSet += UpdatePreviewConditionally;
			_automaticPreview.onValueChanged.AddListener(delegate(bool x)
			{
				if (x)
				{
					FilmmakerTimelineManager.UpdatePlayback();
				}
			});
			_playbackSpeedPercent.onValueChanged.AddListener(delegate(float newVal)
			{
				_playbackSpeed = newVal / 100f;
				_playbackSpeedText.text = string.Format("Playback speed: {0}%", newVal);
			});
		}

		private void OnDestroy()
		{
			HideHUDController.ToggleHUD -= OnHideHudChanged;
			FilmmakerKeyframesRenderer.OnTimeSet -= UpdatePreviewConditionally;
		}

		private void OnHideHudChanged(bool state)
		{
			_canvas.enabled = state;
		}

		private void UpdatePreviewConditionally()
		{
			if (_automaticPreview.isOn)
			{
				FilmmakerTimelineManager.UpdatePlayback();
			}
		}

		private void Update()
		{
			if (GetKey(FilmmakerKey.UpdatePlayback) && !FilmmakerFly.IsFlying)
			{
				FilmmakerTimelineManager.UpdatePlayback();
				FilmmakerTimelineManager.TimeSeconds += Time.deltaTime * _playbackSpeed;
			}
			if (GetKey(FilmmakerKey.RemoveKeyframe))
			{
				if (!_clearStopwatch.IsRunning)
				{
					_clearStopwatch.Restart();
				}
				if (_clearStopwatch.Elapsed.TotalSeconds > 5.0)
				{
					FilmmakerTimelineManager.AllTracks.ForEach(delegate(IFilmmakerTrack x)
					{
						x.ClearAll();
					});
				}
			}
			else
			{
				_clearStopwatch.Reset();
			}
			int num = UpdateTimeFrames();
			if (num >= 0)
			{
				FilmmakerTimelineManager.TimeSeconds = (float)num * 0.02f;
				if (_automaticPreview.isOn)
				{
					FilmmakerTimelineManager.UpdatePlayback();
				}
			}
		}

		// Returns the frame to jump to, or -1 when no timeline key was pressed.
		private int UpdateTimeFrames()
		{
			if (GetKeyDown(FilmmakerKey.JumpToBeginning))
			{
				return 0;
			}
			if (GetKeyDown(FilmmakerKey.JumpToEnd))
			{
				return FilmmakerTimelineManager.AllTracks.Max((IFilmmakerTrack x) => x.LastFrame);
			}
			if (GetKeyDown(FilmmakerKey.JumpForward))
			{
				int cur = FilmmakerTimelineManager.TimeFrames;
				return FilmmakerTimelineManager.AllTracks.Min((IFilmmakerTrack x) => (!x.TryGetNextFrame(cur, out var next)) ? FilmmakerTimelineManager.AllTracks.Max((IFilmmakerTrack y) => y.LastFrame) : next);
			}
			if (GetKeyDown(FilmmakerKey.JumpBackward))
			{
				return FilmmakerTimelineManager.AllTracks.Max((IFilmmakerTrack x) => x.TryGetPrevFrame(FilmmakerTimelineManager.TimeFrames, out var prev) ? prev : 0);
			}
			if (GetKeyDown(FilmmakerKey.RemoveKeyframe))
			{
				FilmmakerTimelineManager.AllTracks.ForEach(delegate(IFilmmakerTrack x)
				{
					x.ClearFrame();
				});
				return FilmmakerTimelineManager.TimeFrames;
			}
			return -1;
		}

		public void UpdatePlayback()
		{
			FilmmakerTimelineManager.UpdatePlayback();
		}

		public void SamplePosition()
		{
			FilmmakerTimelineManager.PositionTrack.AddOrReplace(CurCam.position, BlendPreset);
		}

		public void SampleRotation()
		{
			FilmmakerTimelineManager.RotationTrack.AddOrReplace(CurCam.rotation, BlendPreset);
		}

		public void SampleZoom()
		{
			FilmmakerTimelineManager.ZoomTrack.AddOrReplace(FilmmakerRole.ZoomScale, BlendPreset);
		}

		private static bool GetKey(FilmmakerKey key)
		{
			return Input.GetKey((KeyCode)key);
		}

		private static bool GetKeyDown(FilmmakerKey key)
		{
			return Input.GetKeyDown((KeyCode)key);
		}
	}
}
