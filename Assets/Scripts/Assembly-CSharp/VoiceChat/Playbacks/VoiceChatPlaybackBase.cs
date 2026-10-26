using System;
using UnityEngine;

namespace VoiceChat.Playbacks
{
	[RequireComponent(typeof(AudioSource))]
	public abstract class VoiceChatPlaybackBase : MonoBehaviour
	{
		public float VolumeScale = 1f;

		public int Channels = 1;

		private int _isPlayingSustainRemFrames;

		private float _collectedLoudness;

		private int _collectedSamples;

		private float _targetLoudness;

		private const int LoudnessCollectorThreshold = 1200;

		private const float LoudnessCollectorMultiplier = 5f;

		private const float LoudnessLerpSpeed = 40f;

		private const int IsPlayingSustainFrames = 15;

		private static int _flatlinePcmLen = 0;

		private static float[] _flatlinePcm = Array.Empty<float>();

		public AudioSource Source { get; private set; }

		public float Loudness { get; private set; }

		public abstract int MaxSamples { get; }

		private AudioClip Flatline
		{
			get
			{
				int num = 48000;
				return AudioClip.Create(string.Empty, num, Channels, num, stream: true, (float[] buf) =>
				{
					int num2 = buf.Length;
					if (_flatlinePcmLen < num2)
					{
						_flatlinePcm = new float[num2];
						for (int i = 0; i < num2; i++)
						{
							_flatlinePcm[i] = 1f;
						}
						_flatlinePcmLen = num2;
					}
					Array.Copy(_flatlinePcm, buf, num2);
				});
			}
		}

		private void OnAudioFilterRead(float[] data, int channels)
		{
			int num = MaxSamples * channels;
			int num2 = data.Length;
			if (num <= 0)
			{
				Array.Clear(data, 0, num2);
				return;
			}
			int num3 = 0;
			bool flag = num < num2;
			int num4 = (flag ? num : num2);
			while (num3 < num4)
			{
				float num5 = ReadSample();
				for (int i = 0; i < channels; i++)
				{
					data[num3] *= num5 * VolumeScale;
					num3++;
				}
				_collectedLoudness += Mathf.Abs(num5);
			}
			if (flag)
			{
				Array.Clear(data, num, num2 - num);
			}
			_collectedSamples += num2;
		}

		private void UpdateLoudnessMeter()
		{
			if (_collectedSamples >= 1200)
			{
				float num = _collectedLoudness * 5f;
				_targetLoudness = Mathf.Sqrt(num / (float)_collectedSamples);
				_collectedLoudness = 0f;
				_collectedSamples = 0;
			}
			Loudness = Mathf.Lerp(Loudness, _targetLoudness, Time.deltaTime * 40f);
		}

		protected virtual void OnEnable()
		{
		}

		protected virtual void OnDisable()
		{
			_isPlayingSustainRemFrames = 0;
			Source.Stop();
		}

		protected virtual void Awake()
		{
			Source = GetComponent<AudioSource>();
			Source.clip = Flatline;
			Source.loop = true;
			Source.bypassReverbZones = true;
			Source.priority = 0;
		}

		protected virtual void Update()
		{
			UpdateLoudnessMeter();
			if (_isPlayingSustainRemFrames <= 0)
			{
				if (MaxSamples > 0)
				{
					if (!Source.isPlaying)
					{
						Source.Play();
					}
					Debug.LogError("Buffer " + base.gameObject.name + " (" + GetType().Name + ") is playing on low priority.");
				}
				UpdatePlayback(isPlaying: false, prevPlaying: false);
			}
			else
			{
				if (MaxSamples > 0)
				{
					_isPlayingSustainRemFrames = 15;
				}
				else
				{
					_isPlayingSustainRemFrames--;
				}
				UpdatePlayback(_isPlayingSustainRemFrames > 0, prevPlaying: true);
			}
		}

		protected virtual void UpdatePlayback(bool isPlaying, bool prevPlaying)
		{
			if (isPlaying == prevPlaying)
			{
				return;
			}
			if (isPlaying)
			{
				if (!Source.isPlaying)
				{
					Source.Play();
				}
			}
			else
			{
				Source.Pause();
			}
		}

		protected abstract float ReadSample();

		public void RegisterInput()
		{
			bool num = _isPlayingSustainRemFrames > 0;
			_isPlayingSustainRemFrames = 15;
			if (!num)
			{
				UpdatePlayback(isPlaying: true, prevPlaying: false);
			}
		}
	}
}
