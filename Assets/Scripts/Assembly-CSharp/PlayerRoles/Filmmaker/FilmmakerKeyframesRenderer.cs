using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Filmmaker
{
	public class FilmmakerKeyframesRenderer : MonoBehaviour
	{
		[Serializable]
		private class Track
		{
			public Color TrackColor;

			public Transform Parent;

			private int _instanceCount;

			private readonly List<RectTransform> _instancesTr = new List<RectTransform>();

			private readonly List<Button> _instancesButtons = new List<Button>();

			private void EnsureIndex(int index, GameObject template)
			{
				for (int i = _instanceCount; i <= index; i++)
				{
					GameObject gameObject = UnityEngine.Object.Instantiate(template, Parent);
					gameObject.GetComponentInChildren<Image>().color = TrackColor;
					_instancesTr.Add(gameObject.GetComponent<RectTransform>());
					_instancesButtons.Add(gameObject.GetComponentInChildren<Button>());
					_instanceCount++;
				}
			}

			public void GetInstance(int index, GameObject template, out Button button, out RectTransform transform)
			{
				EnsureIndex(index, template);
				button = _instancesButtons[index];
				transform = _instancesTr[index];
			}

			public void DisableRest(int firstIndex)
			{
				for (int i = firstIndex; i < _instanceCount; i++)
				{
					_instancesTr[i].gameObject.SetActive(value: false);
				}
			}
		}

		[SerializeField]
		private float _leftMargin;

		[SerializeField]
		private float _minTimelineWidth;

		[SerializeField]
		private GameObject _keyframeTemplate;

		[SerializeField]
		private Track _posTrack;

		[SerializeField]
		private Track _rotTrack;

		[SerializeField]
		private Track _zoomTrack;

		[SerializeField]
		private RectTransform _scalableTransform;

		[SerializeField]
		private RawImage _secondsIndicator;

		[SerializeField]
		private RawImage _framesIndicator;

		[SerializeField]
		private float _secondsOnTimeline;

		[SerializeField]
		private List<TextMeshProUGUI> _gridIndicators;

		[SerializeField]
		private RectTransform _timeIndicator;

		[SerializeField]
		private RectTransform _setTimeArea;

		[SerializeField]
		private Scrollbar _zoomSlider;

		[SerializeField]
		private Scrollbar _offsetSlider;

		[SerializeField]
		private TextMeshProUGUI _selectionInfo;

		[SerializeField]
		private Button _removeButton;

		[SerializeField]
		private TMP_Dropdown _specificTransitionMode;

		[SerializeField]
		private TMP_Dropdown _defaultTransitionMode;

		[SerializeField]
		private GameObject _detailsGroup;

		private float _frameToNodePosition;

		private float _secondsToNodePosition;

		private float _timelineSize;

		private bool _draggingTime;

		private Canvas _canvas;

		public static event Action OnTimeSet;

		private void Awake()
		{
			_canvas = GetComponentInParent<Canvas>();
			PrepDropdown(_specificTransitionMode);
			PrepDropdown(_defaultTransitionMode);
		}

		private void PrepDropdown(TMP_Dropdown dd)
		{
			dd.ClearOptions();
			for (int i = 0; i <= 3; i++)
			{
				FilmmakerBlendPreset filmmakerBlendPreset = (FilmmakerBlendPreset)i;
				string text = filmmakerBlendPreset.ToString();
				dd.options.Add(new TMP_Dropdown.OptionData(text));
			}
		}

		private void Update()
		{
			UpdateTimelineScaleAndOffset();
			UpdateGrid();
			UpdateTime();
			UpdateTrack(_posTrack, FilmmakerTimelineManager.PositionTrack);
			UpdateTrack(_rotTrack, FilmmakerTimelineManager.RotationTrack);
			UpdateTrack(_zoomTrack, FilmmakerTimelineManager.ZoomTrack);
			_detailsGroup.SetActive(!string.IsNullOrEmpty(_selectionInfo.text));
		}

		private void UpdateTimelineScaleAndOffset()
		{
			_timelineSize = Mathf.Lerp(_minTimelineWidth, _minTimelineWidth * Mathf.Max(1f, _secondsOnTimeline), _zoomSlider.value);
			_scalableTransform.sizeDelta = new Vector2(_timelineSize, _scalableTransform.sizeDelta.y);
			_scalableTransform.anchoredPosition = (_timelineSize - _minTimelineWidth) * _offsetSlider.value * Vector2.left;
		}

		private void UpdateGrid()
		{
			float num = _secondsOnTimeline * 50f;
			_secondsIndicator.uvRect = new Rect(0f, 0f, _secondsOnTimeline, 1f);
			_framesIndicator.uvRect = new Rect(0f, 0f, num, 1f);
			_frameToNodePosition = (_scalableTransform.rect.width - _leftMargin) / num;
			_secondsToNodePosition = _frameToNodePosition * 50f;
			int i;
			for (i = 0; (float)i < _secondsOnTimeline; i++)
			{
				while (i >= _gridIndicators.Count)
				{
					TextMeshProUGUI textMeshProUGUI = _gridIndicators[0];
					_gridIndicators.Add(UnityEngine.Object.Instantiate(textMeshProUGUI, textMeshProUGUI.transform.parent));
				}
				TextMeshProUGUI textMeshProUGUI2 = _gridIndicators[i];
				textMeshProUGUI2.text = $" {i}s \t";
				textMeshProUGUI2.enabled = true;
				textMeshProUGUI2.rectTransform.sizeDelta = new Vector2(_secondsToNodePosition, textMeshProUGUI2.rectTransform.sizeDelta.y);
			}
			while (i < _gridIndicators.Count)
			{
				_gridIndicators[i++].enabled = false;
			}
		}

		private void UpdateTrack<T>(Track track, FilmmakerTrack<T> timeline) where T : struct
		{
			int num = timeline.Keyframes.Length;
			for (int i = 0; i < num; i++)
			{
				track.GetInstance(i, _keyframeTemplate, out var button, out var rectTransform);
				FilmmakerKeyframe<T> kf = timeline.Keyframes[i];
				rectTransform.gameObject.SetActive(value: true);
				rectTransform.anchoredPosition = _frameToNodePosition * (float)kf.TimeFrames * Vector3.right;
				button.onClick.RemoveAllListeners();
				button.onClick.AddListener(() =>
				{
					_selectionInfo.color = track.TrackColor;
					float num2 = (float)kf.TimeFrames / 50f;
					_selectionInfo.text = $"Time: {num2:0.00}s ({kf.TimeFrames} frames)" + $"\nValue: {kf.Value} ({typeof(T).Name})";
					_removeButton.onClick.RemoveAllListeners();
					_removeButton.onClick.AddListener(() =>
					{
						timeline.ClearFrame(kf.TimeFrames);
					});
					_removeButton.onClick.AddListener(() =>
					{
						_selectionInfo.text = string.Empty;
					});
					_specificTransitionMode.SetValueWithoutNotify((int)kf.BlendCurve);
					_specificTransitionMode.onValueChanged.RemoveAllListeners();
					_specificTransitionMode.onValueChanged.AddListener((int val) =>
					{
						kf.BlendCurve = (FilmmakerBlendPreset)val;
						_selectionInfo.text = string.Empty;
					});
				});
			}
			track.DisableRest(num);
		}

		private void UpdateTime()
		{
			_timeIndicator.anchoredPosition = _secondsToNodePosition * FilmmakerTimelineManager.TimeSeconds * Vector2.right;
			if (_draggingTime)
			{
				if (!Input.GetKey(KeyCode.Mouse0))
				{
					_draggingTime = false;
					return;
				}
			}
			else if (!Input.GetKeyDown(KeyCode.Mouse0))
			{
				return;
			}
			Rect rect = _setTimeArea.rect;
			Vector2 vector = (Input.mousePosition - _setTimeArea.position) / _canvas.scaleFactor;
			bool flag = true;
			if (vector.y > 0f || 0f - vector.y > rect.height / 2f)
			{
				flag = false;
				if (!_draggingTime)
				{
					return;
				}
			}
			float num = (vector.x + rect.width / 2f) / rect.width;
			if (!(num < 0f) && !(num > 1f))
			{
				_draggingTime |= flag;
				FilmmakerTimelineManager.TimeFrames = Mathf.RoundToInt(num * _secondsOnTimeline * 50f);
				OnTimeSet?.Invoke();
			}
		}
	}
}
