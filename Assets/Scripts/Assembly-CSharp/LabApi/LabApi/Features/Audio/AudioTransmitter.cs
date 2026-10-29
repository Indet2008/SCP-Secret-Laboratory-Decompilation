namespace LabApi.Features.Audio
{
	public class AudioTransmitter
	{
		public const int SampleRate = 48000;

		public const int FrameSize = 480;

		public const float FramePeriod = 0.01f;

		public const int MaxEncodedSize = 512;

		private const float GainCorrectionFactor = 1.4142135f;

		private static readonly float[] EmptyData = new float[480];

		private static readonly float[] TempSampleData = new float[480];

		private static readonly byte[] TempEncodedData = new byte[512];

		private readonly global::VoiceChat.Codec.OpusEncoder _opusEncoder;

		private global::MEC.CoroutineHandle _update;

		private double _targetTime;

		private bool _breakCurrent;

		private float[] _currentSamples = EmptyData;

		public byte ControllerId { get; }

		public global::System.Collections.Generic.Queue<float[]> AudioClipSamples { get; } = new global::System.Collections.Generic.Queue<float[]>();

		public global::System.Func<global::LabApi.Features.Wrappers.Player, bool>? ValidPlayers { get; set; }

		public bool Looping { get; set; }

		public int CurrentPosition { get; set; }

		public int CurrentSampleCount
		{
			get
			{
				if (_currentSamples != EmptyData)
				{
					return _currentSamples.Length;
				}
				return 0;
			}
		}

		public bool IsPlaying
		{
			get
			{
				if (_update.IsRunning)
				{
					return !IsPaused;
				}
				return false;
			}
		}

		public bool IsPaused => _update.IsAliveAndPaused;

		private bool CanLoop
		{
			get
			{
				if (AudioClipSamples.Count == 0)
				{
					return Looping;
				}
				return false;
			}
		}

		public AudioTransmitter(byte controllerId, global::VoiceChat.Codec.Enums.OpusApplicationType type = global::VoiceChat.Codec.Enums.OpusApplicationType.Audio)
		{
			ControllerId = controllerId;
			_opusEncoder = new global::VoiceChat.Codec.OpusEncoder(type);
		}

		public void Play(float[] samples, bool queue, bool loop)
		{
			if (samples.IsEmpty())
			{
				throw new global::System.InvalidOperationException("Audio clip samples must not be empty");
			}
			if (!queue)
			{
				_breakCurrent = true;
				AudioClipSamples.Clear();
				CurrentPosition = 0;
			}
			AudioClipSamples.Enqueue(samples);
			Looping = loop;
			if (!_update.IsRunning)
			{
				_update = global::MEC.Timing.RunCoroutine(Transmit(), global::MEC.Segment.Update);
			}
		}

		public void Pause()
		{
			_update.IsAliveAndPaused = true;
		}

		public void Resume()
		{
			_update.IsAliveAndPaused = false;
			_targetTime = global::Mirror.NetworkTime.time;
		}

		public void Skip(int count)
		{
			if (count != 0)
			{
				_breakCurrent = true;
				CurrentPosition = 0;
				for (int i = 1; i < count; i++)
				{
					AudioClipSamples.Dequeue();
				}
			}
		}

		public void Stop()
		{
			global::MEC.Timing.KillCoroutines(_update);
			AudioClipSamples.Clear();
			CurrentPosition = 0;
		}

		private global::System.Collections.Generic.IEnumerator<float> Transmit()
		{
			_targetTime = global::Mirror.NetworkTime.time;
			while (!AudioClipSamples.IsEmpty())
			{
				_currentSamples = AudioClipSamples.Dequeue();
				_breakCurrent = false;
				while (!_breakCurrent && (CanLoop || CurrentPosition < _currentSamples.Length))
				{
					try
					{
						while (_targetTime < global::Mirror.NetworkTime.time)
						{
							int num2;
							for (int i = 0; i != 480; i += num2)
							{
								int num = 480 - i;
								num2 = global::UnityEngine.Mathf.Max(global::UnityEngine.Mathf.Min(CurrentPosition + num, _currentSamples.Length) - CurrentPosition, 0);
								global::System.Array.Copy(_currentSamples, CurrentPosition, TempSampleData, i, num2);
								if (num == num2)
								{
									CurrentPosition += num2;
									continue;
								}
								CurrentPosition = 0;
								if (!CanLoop)
								{
									_currentSamples = (AudioClipSamples.IsEmpty() ? EmptyData : AudioClipSamples.Dequeue());
								}
							}
							for (int j = 0; j < TempSampleData.Length; j++)
							{
								TempSampleData[j] *= 1.4142135f;
							}
							int num3 = _opusEncoder.Encode(TempSampleData, TempEncodedData);
							if (num3 > 2)
							{
								global::VoiceChat.Networking.AudioMessage audioMessage = new global::VoiceChat.Networking.AudioMessage
								{
									ControllerId = ControllerId,
									DataLength = num3,
									Data = TempEncodedData
								};
								if (ValidPlayers != null)
								{
									global::Utils.Networking.NetworkUtils.SendToHubsConditionally(audioMessage, (ReferenceHub x) => x.Mode != global::CentralAuth.ClientInstanceMode.Unverified && ValidPlayers(global::LabApi.Features.Wrappers.Player.Get(x)));
								}
								else
								{
									global::Utils.Networking.NetworkUtils.SendToAuthenticated(audioMessage);
								}
							}
							_targetTime += 0.009999999776482582;
						}
					}
					catch (global::System.Exception message)
					{
						global::LabApi.Features.Console.Logger.Error(message);
						CurrentPosition = 0;
						yield break;
					}
					yield return float.NegativeInfinity;
				}
			}
			CurrentPosition = 0;
		}
	}
}
