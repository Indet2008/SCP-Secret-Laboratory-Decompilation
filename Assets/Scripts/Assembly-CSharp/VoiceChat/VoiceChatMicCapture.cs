using System;
using System.Threading;
using PlayerRoles.Voice;
using UnityEngine;
using UserSettings;
using UserSettings.AudioSettings;
using VoiceChat.CaressNoiseReduction;
using VoiceChat.Networking;

namespace VoiceChat
{
	public class VoiceChatMicCapture : MonoBehaviour
	{
		private static VoiceChatMicCapture _singleton;

		private static bool _singletonSet;

		private static string _selectedMic;

		private Action<bool> _noiseReductionUpdater;

		private NoiseReducer _noiseReducer;

		private PlaybackBuffer _recordBuffer;

		private PlaybackBuffer _sendBuffer;

		private AudioSource _micSource;

		private VoiceChatChannel _channel;

		private float[] _noiseReductionBuffer;

		private float[] _samples;

		private int _lastSample;

		private int _samplesCount;

		private bool _micStarted;

		private static bool MicCaptureDenied => (VoiceChatPrivacySettings.PrivacyFlags & VcPrivacyFlags.AllowMicCapture) == 0;

		public static bool IsSpeaking { get; private set; }

		public static float Loudness { get; private set; }

		private void Awake()
		{
			if (_singleton != null)
			{
				throw new InvalidOperationException("More than one 'VoiceChatMicCapture'' detected on scene!");
			}
			_singleton = this;
			_singletonSet = true;
			_noiseReductionUpdater = (bool enabled) =>
			{
				NoiseReducer value = null;
				if (enabled)
				{
					if (_noiseReducer != null)
					{
						return;
					}
					try
					{
						value = new NoiseReducer(VoiceChatSettings.NoiseReductionSettings);
						Debug.Log("Noise reducer enabled");
					}
					catch (Exception ex)
					{
						Debug.LogWarning("Noise reducer error: " + ex.Message);
					}
				}
				Interlocked.Exchange(ref _noiseReducer, value)?.Dispose();
			};
			UserSetting<bool>.AddListener(OtherAudioSetting.NoiseReduction, _noiseReductionUpdater);
			_noiseReductionUpdater(UserSetting<bool>.Get(OtherAudioSetting.NoiseReduction));
			_noiseReductionBuffer = new float[480];
			_recordBuffer = new PlaybackBuffer();
			_sendBuffer = new PlaybackBuffer();
			_micSource = base.gameObject.AddComponent<AudioSource>();
			_micSource.volume = 0f;
			_micSource.loop = true;
			_micSource.bypassEffects = true;
			_micSource.bypassListenerEffects = true;
			_micSource.bypassReverbZones = true;
			_micSource.priority = 0;
			VoiceChatPrivacySettings.OnUserFlagsChanged += OnPrivacySettingsUpdated;
		}

		private void OnDestroy()
		{
			UserSetting<bool>.RemoveListener(OtherAudioSetting.NoiseReduction, _noiseReductionUpdater);
			VoiceChatPrivacySettings.OnUserFlagsChanged -= OnPrivacySettingsUpdated;
			StopAllMicrophones();
			_noiseReductionUpdater(obj: false);
			_singletonSet = false;
		}

		private void Update()
		{
			UpdateRecording();
		}

		private void OnPrivacySettingsUpdated(ReferenceHub hub)
		{
			if (hub.isLocalPlayer && (!_micStarted || MicCaptureDenied))
			{
				RestartRecording();
			}
		}

		private void UpdateRecording()
		{
			Loudness = 0f;
			IsSpeaking = false;
			if (!ReferenceHub.TryGetLocalHub(out var hub) || !(hub.roleManager.CurrentRole is IVoiceRole voiceRole))
			{
				return;
			}
			_channel = voiceRole.VoiceModule.GetUserInput();
			bool flag = _channel == VoiceChatChannel.None;
			IsSpeaking = !flag && MicCaptureDenied;
			if (!_micStarted)
			{
				return;
			}
			int position = Microphone.GetPosition(_selectedMic);
			_micSource.clip.GetData(_samples, 0);
			int num = position - _lastSample;
			if (num < 0)
			{
				num += _samplesCount;
			}
			if (flag)
			{
				_lastSample = position;
				return;
			}
			for (int i = 0; i < num; i++)
			{
				float num2 = _samples[(_lastSample + i) % _samplesCount];
				if (num2 > Loudness)
				{
					Loudness = num2;
				}
				_recordBuffer.Write(num2);
			}
			_lastSample = position;
			int num3 = 480;
			while (_recordBuffer.Length >= num3)
			{
				_recordBuffer.ReadTo(_noiseReductionBuffer, num3, 0L);
				if (_noiseReducer != null)
				{
					_noiseReducer.ReduceNoise(_noiseReductionBuffer);
				}
				_sendBuffer.Write(_noiseReductionBuffer, num3);
				VoiceTransceiver.ClientSendData(_sendBuffer, _channel);
			}
			IsSpeaking = true;
		}

		public static void StopAllMicrophones()
		{
			if (!_singletonSet || !_singleton._micStarted)
			{
				return;
			}
			string[] devices = Microphone.devices;
			foreach (string deviceName in devices)
			{
				if (Microphone.IsRecording(deviceName))
				{
					Microphone.End(deviceName);
				}
			}
			_singleton._micStarted = false;
		}

		public static void StartRecording()
		{
			if (_singletonSet && !_singleton._micStarted)
			{
				RestartRecording();
			}
		}

		public static void RestartRecording()
		{
			if (!_singletonSet || !VoiceChatMicrophoneSelector.TryGetPreferredMicrophone(out var mic))
			{
				return;
			}
			if (MicCaptureDenied)
			{
				StopAllMicrophones();
				return;
			}
			if (_singleton._micStarted && _selectedMic != mic)
			{
				StopAllMicrophones();
				_selectedMic = mic;
			}
			AudioSource micSource = _singleton._micSource;
			micSource.clip = Microphone.Start(_selectedMic, loop: true, 1, 48000);
			if (micSource.clip == null)
			{
				_singleton._micStarted = false;
				Debug.LogError("Microphone '" + _selectedMic + "' failed to start recording.");
				return;
			}
			_singleton._recordBuffer.Clear();
			_singleton._sendBuffer.Clear();
			_singleton._micStarted = true;
			int samples = micSource.clip.samples;
			_singleton._lastSample = 0;
			if (samples != _singleton._samplesCount)
			{
				_singleton._samplesCount = samples;
				_singleton._samples = new float[samples];
			}
			micSource.Play();
		}

		public static VoiceChatChannel GetCurrentChannel()
		{
			if (!_singletonSet)
			{
				return VoiceChatChannel.None;
			}
			return _singleton._channel;
		}
	}
}
