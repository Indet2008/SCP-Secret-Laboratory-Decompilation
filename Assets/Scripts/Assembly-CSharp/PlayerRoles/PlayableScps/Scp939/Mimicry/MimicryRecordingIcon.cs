using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using Utils.NonAllocLINQ;
using VoiceChat.Networking;

namespace PlayerRoles.PlayableScps.Scp939.Mimicry
{
	public class MimicryRecordingIcon : MonoBehaviour
	{
		private static readonly HashSet<MimicryRecordingIcon> FavoritedEntries = new HashSet<MimicryRecordingIcon>();

		[SerializeField]
		private GameObject _contentRoot;

		[SerializeField]
		private TextMeshProUGUI _nickname;

		[SerializeField]
		private TextMeshProUGUI _rolename;

		[SerializeField]
		private Image _removeProgress;

		[SerializeField]
		private HoldableButton _removeButton;

		[SerializeField]
		private HoldableButton _previewButton;

		[SerializeField]
		private HoldableButton _useButton;

		[SerializeField]
		private HoldableButton _stopButton;

		[SerializeField]
		private MimicryWaveform _waveformVisualizer;

		[SerializeField]
		private Image _favoriteFill;

		[SerializeField]
		private TMP_Text _favoriteLabel;

		private const KeyCode FirstKeybind = KeyCode.Alpha1;

		private MimicryPreviewPlayback _previewPlayback;

		private MimicryTransmitter _transmitter;

		private MimicryRecorder _assignedRecorder;

		private RectTransform _cachedRt;

		private bool _previewing;

		private bool _isEmpty;

		private bool _isFavorite;

		private KeyCode _assignedHotkey;

		public PlaybackBuffer VoiceRecord { get; private set; }

		public bool IsFavorite
		{
			get
			{
				return _isFavorite;
			}
			private set
			{
				if (value != IsFavorite)
				{
					_isFavorite = value;
					if (value)
					{
						FavoritedEntries.Add(this);
						StaticUnityMethods.OnUpdate += UpdateFavoriteHotkey;
					}
					else
					{
						FavoritedEntries.Remove(this);
						StaticUnityMethods.OnUpdate -= UpdateFavoriteHotkey;
					}
				}
			}
		}

		public bool IsEmpty
		{
			get
			{
				return _isEmpty;
			}
			set
			{
				_isEmpty = value;
				_contentRoot.SetActive(!_isEmpty);
				if (value)
				{
					IsFavorite = false;
				}
			}
		}

		public float Height
		{
			get
			{
				return _cachedRt.anchoredPosition.y;
			}
			set
			{
				_cachedRt.anchoredPosition = value * Vector2.up;
			}
		}

		public void Setup(MimicryRecorder recorder, int id)
		{
			MimicryRecorder.MimicryRecording mimicryRecording = recorder.SavedVoices[id];
			VoiceRecord = mimicryRecording.Buffer;
			_assignedRecorder = recorder;
			_transmitter = recorder.Transmitter;
			_previewPlayback = recorder.PreviewPlayback;
			_waveformVisualizer.Generate(VoiceRecord.Buffer, 0, VoiceRecord.Length);
			if (mimicryRecording.Owner.Role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				_nickname.text = mimicryRecording.Owner.Nickname;
				_rolename.text = result.RoleName;
				_rolename.color = result.RoleColor;
			}
		}

		private void Update()
		{
			if (!IsEmpty)
			{
				_removeProgress.fillAmount = _removeButton.HeldPercent;
				_stopButton.interactable = _waveformVisualizer.IsPlaying;
				if (_previewing && _previewPlayback.IsEmpty)
				{
					StopPlayback();
				}
			}
		}

		private void Awake()
		{
			_cachedRt = GetComponent<RectTransform>();
		}

		private void OnDestroy()
		{
			IsFavorite = false;
		}

		private void UpdateFavoriteHotkey()
		{
			if (Input.GetKeyDown(_assignedHotkey))
			{
				SendRecording();
			}
		}

		public void StartPreview()
		{
			if (_previewing)
			{
				StopPreview();
			}
			_waveformVisualizer.StartPlayback(VoiceRecord.Length, out var startSample, out var lengthSamples);
			_previewing = true;
			_transmitter.StopTransmission();
			_previewPlayback.StartPreview(VoiceRecord, startSample, lengthSamples);
		}

		public void RemoveRecording()
		{
			if (_waveformVisualizer.IsPlaying)
			{
				StopPlayback();
			}
			_assignedRecorder.RemoveVoice(VoiceRecord);
		}

		public void SendRecording()
		{
			StopPreview();
			_waveformVisualizer.StartPlayback(VoiceRecord.Length, out var startSample, out var lengthSamples);
			_transmitter.SendVoice(VoiceRecord, startSample, lengthSamples);
		}

		public void StopPlayback()
		{
			StopPreview();
			_transmitter.StopTransmission();
			_waveformVisualizer.StopPlayback();
		}

		public void ToggleFavorite()
		{
			IsFavorite = !IsFavorite;
			_favoriteFill.enabled = IsFavorite;
			_favoriteLabel.enabled = IsFavorite;
			if (IsFavorite)
			{
				_assignedHotkey = KeyCode.Alpha1;
				while (FavoritedEntries.Any((MimicryRecordingIcon x) => x.IsFavorite && x != this && x._assignedHotkey == _assignedHotkey))
				{
					_assignedHotkey++;
				}
				string arg = $"[ {(int)(_assignedHotkey - 49 + 1)} ]";
				_favoriteLabel.text = string.Format(Translations.Get(Scp939HudTranslation.HintAssignedHotkey, "Hotkey  {0}"), arg);
			}
		}

		private void StopPreview()
		{
			if (_previewing)
			{
				_previewing = false;
				_previewPlayback.StopPreview();
			}
		}
	}
}
