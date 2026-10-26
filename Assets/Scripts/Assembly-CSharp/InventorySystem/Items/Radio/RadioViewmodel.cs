using System;
using CameraShaking;
using InventorySystem.Items.SwayControllers;
using PlayerRoles.Voice;
using TMPro;
using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.UI;
using VoiceChat.Playbacks;

namespace InventorySystem.Items.Radio
{
	public class RadioViewmodel : AnimatedViewmodelBase
	{
		[Header("World-space User Interface")]
		[SerializeField]
		private GameObject _panelNoBattery;

		[Header("World-space User Interface")]
		[SerializeField]
		private GameObject _panelMain;

		[Header("World-space User Interface")]
		[SerializeField]
		private GameObject _panelRoot;

		[SerializeField]
		private TMP_Text _textModeShort;

		[SerializeField]
		private TMP_Text _textModeFull;

		[SerializeField]
		private TMP_Text _textBatteryLevel;

		[SerializeField]
		private TMP_Text _textVolume;

		[SerializeField]
		private TMP_Text _textTime;

		[SerializeField]
		private GameObject _txOn;

		[SerializeField]
		private GameObject _txOff;

		[SerializeField]
		private GameObject _rxOn;

		[SerializeField]
		private GameObject _rxOff;

		[SerializeField]
		private RawImage _rangeIndicator;

		[SerializeField]
		private RawImage _noBatteryIndicator;

		[SerializeField]
		private Image[] _batteryLevels;

		[Header("Audio")]
		[SerializeField]
		private AudioMixer _voicechatMixer;

		[SerializeField]
		private AudioSource _audioSource;

		[SerializeField]
		private AudioClip _clipTurnOn;

		[SerializeField]
		private AudioClip _clipTurnOff;

		[SerializeField]
		private AudioClip _clipCircleRange;

		[Header("Tracker")]
		[SerializeField]
		private Transform _cameraTrackerSource;

		[SerializeField]
		private Vector3 _cameraTrackerOffset;

		[SerializeField]
		private float _cameraTrackerIntensity;

		[Header("Other")]
		[SerializeField]
		private Transform _swayPivot;

		[SerializeField]
		private MeshRenderer _radioRenderer;

		[SerializeField]
		private Material _enabledMat;

		[SerializeField]
		private Material _disabledMat;

		private static readonly int IsTransmittingHash = Animator.StringToHash("IsTransmitting");

		private const string RadioChannelName = "AudioSettings_VoiceChat";

		private const string KeypadEmissionChannelName = "_EmissionColor";

		private const float BatteryFlashRate = 2.5f;

		private GoopSway _goopSway;

		private float _batteryFlashTimer;

		private int _prevRange = -1;

		public override IItemSwayController SwayController => _goopSway;

		public override float ViewmodelCameraFOV => 50f;

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			OnEquipped();
			if (wasEquipped)
			{
				GetComponent<AudioSource>().Stop();
				AnimatorForceUpdate(base.SkipEquipTime);
			}
		}

		internal override void OnEquipped()
		{
			CameraShakeController.AddEffect(new TrackerShake(_cameraTrackerSource, Quaternion.Euler(_cameraTrackerOffset), _cameraTrackerIntensity));
			RefreshKeypadColor(_panelRoot.activeSelf);
		}

		private void Start()
		{
			_goopSway = new GoopSway(new GoopSway.GoopSwaySettings(_swayPivot, 0.65f, 0.0035f, 0.04f, 7f, 6.5f, 0.03f, 1.6f, invertSway: false), base.Hub);
		}

		private void Update()
		{
			if (_panelMain.activeSelf && _panelRoot.activeSelf)
			{
				_textVolume.text = "-" + (_voicechatMixer.GetFloat("AudioSettings_VoiceChat", out var value) ? Mathf.Abs(Mathf.RoundToInt(value)) : 0);
				_textTime.text = DateTime.Now.ToString("HH:mm:ss");
				GetTxRx(out var tx, out var rx);
				_txOn.SetActive(tx);
				_txOff.SetActive(!tx);
				_rxOn.SetActive(rx);
				_rxOff.SetActive(!rx);
				AnimatorSetBool(IsTransmittingHash, tx);
			}
			else if (_panelNoBattery.activeSelf)
			{
				_batteryFlashTimer += Time.deltaTime;
				if (_batteryFlashTimer > 0.4f)
				{
					_batteryFlashTimer = 0f;
					_noBatteryIndicator.enabled = !_noBatteryIndicator.enabled;
				}
			}
			UpdateNetwork();
		}

		private void UpdateNetwork()
		{
			if (!RadioMessages.SyncedRangeLevels.TryGetValue(base.Hub.netId, out var value))
			{
				return;
			}
			SetBattery(value.Battery);
			if (value.Battery != 0)
			{
				if (value.Range == RadioMessages.RadioRangeLevel.RadioDisabled)
				{
					SetState(state: false);
					return;
				}
				SetState(state: true);
				SetRange((int)value.Range);
			}
		}

		private void GetTxRx(out bool tx, out bool rx)
		{
			tx = false;
			rx = false;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is IVoiceRole voiceRole && PersonalRadioPlayback.IsTransmitting(allHub))
				{
					if (allHub == base.Hub)
					{
						tx = true;
					}
					else if (!(voiceRole.VoiceModule as IRadioVoiceModule).RadioPlayback.Source.mute)
					{
						rx = true;
					}
				}
			}
		}

		private void SetBattery(byte percent)
		{
			_panelMain.SetActive(percent > 0);
			_panelNoBattery.SetActive(percent == 0);
			if (percent > 0)
			{
				_textBatteryLevel.text = percent + "%";
				float num = (float)_batteryLevels.Length / 100f;
				for (int i = 0; i < _batteryLevels.Length; i++)
				{
					_batteryLevels[i].enabled = Mathf.Round((float)(int)percent * num) >= (float)(i + 1);
				}
			}
			else
			{
				AnimatorSetBool(IsTransmittingHash, val: false);
			}
		}

		private void SetRange(int rangeId)
		{
			if (_prevRange != rangeId)
			{
				if (base.gameObject.activeInHierarchy)
				{
					_audioSource.PlayOneShot(_clipCircleRange);
				}
				_prevRange = rangeId;
			}
			if (InventoryItemLoader.TryGetItem<RadioItem>(ItemType.Radio, out var result))
			{
				RadioRangeMode[] ranges = result.Ranges;
				rangeId = Mathf.Clamp(rangeId, 0, ranges.Length - 1);
				_textModeShort.text = ranges[rangeId].ShortName;
				_textModeFull.text = ranges[rangeId].FullName;
				_rangeIndicator.texture = ranges[rangeId].SignalTexture;
			}
		}

		private void SetState(bool state)
		{
			if (_panelRoot.activeSelf != state)
			{
				RefreshKeypadColor(state);
				_panelRoot.SetActive(state);
				_audioSource.PlayOneShot(state ? _clipTurnOn : _clipTurnOff);
				if (!state)
				{
					AnimatorSetBool(IsTransmittingHash, val: false);
				}
			}
		}

		private void RefreshKeypadColor(bool state)
		{
			Material sharedMaterial = _radioRenderer.sharedMaterial;
			if (!(sharedMaterial != _enabledMat) || !(sharedMaterial != _disabledMat))
			{
				_radioRenderer.sharedMaterial = (state ? _enabledMat : _disabledMat);
			}
		}
	}
}
