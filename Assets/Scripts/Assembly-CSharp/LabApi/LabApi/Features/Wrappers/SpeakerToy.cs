namespace LabApi.Features.Wrappers
{
	public class SpeakerToy : global::LabApi.Features.Wrappers.AdminToy
	{
		private static readonly global::System.Collections.Generic.Dictionary<byte, global::LabApi.Features.Audio.AudioTransmitter> TransmitterByControllerId = new global::System.Collections.Generic.Dictionary<byte, global::LabApi.Features.Audio.AudioTransmitter>();

		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.SpeakerToy, global::LabApi.Features.Wrappers.SpeakerToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.SpeakerToy, global::LabApi.Features.Wrappers.SpeakerToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.SpeakerToy> List => Dictionary.Values;

		public new global::AdminToys.SpeakerToy Base { get; }

		public byte ControllerId
		{
			get
			{
				return Base.ControllerId;
			}
			set
			{
				Base.NetworkControllerId = value;
			}
		}

		public bool IsSpatial
		{
			get
			{
				return Base.IsSpatial;
			}
			set
			{
				Base.NetworkIsSpatial = value;
			}
		}

		public float Volume
		{
			get
			{
				return Base.Volume;
			}
			set
			{
				Base.NetworkVolume = value;
			}
		}

		public float MinDistance
		{
			get
			{
				return Base.MinDistance;
			}
			set
			{
				Base.NetworkMinDistance = value;
			}
		}

		public float MaxDistance
		{
			get
			{
				return Base.MaxDistance;
			}
			set
			{
				Base.NetworkMaxDistance = value;
			}
		}

		public int CurrentPosition
		{
			get
			{
				return Transmitter.CurrentPosition;
			}
			set
			{
				Transmitter.CurrentPosition = value;
			}
		}

		public bool IsLooping
		{
			get
			{
				return Transmitter.Looping;
			}
			set
			{
				Transmitter.Looping = value;
			}
		}

		public bool IsPlaying => Transmitter.IsPlaying;

		public bool IsPaused => Transmitter.IsPaused;

		public int CurrentSampleCount => Transmitter.CurrentSampleCount;

		public float CurrentDuration => (float)CurrentSampleCount * global::VoiceChat.VoiceChatSettings.SampleToDuartionRate;

		public int CurrentRemainingSampleCount => CurrentSampleCount - CurrentPosition;

		public float CurrentRemainingDuration => (float)CurrentRemainingSampleCount * global::VoiceChat.VoiceChatSettings.SampleToDuartionRate;

		public int QueuedClipsCount => Transmitter.AudioClipSamples.Count;

		public int QueuedClipsSampleCount
		{
			get
			{
				if (!Transmitter.AudioClipSamples.IsEmpty())
				{
					return global::System.Linq.Enumerable.Sum(Transmitter.AudioClipSamples, (float[] x) => x.Length);
				}
				return 0;
			}
		}

		public float QueuedClipsDuration => (float)QueuedClipsSampleCount * global::VoiceChat.VoiceChatSettings.SampleToDuartionRate;

		public global::System.Func<global::LabApi.Features.Wrappers.Player, bool>? ValidPlayers
		{
			get
			{
				return Transmitter.ValidPlayers;
			}
			set
			{
				Transmitter.ValidPlayers = value;
			}
		}

		public global::LabApi.Features.Audio.AudioTransmitter Transmitter => GetTransmitter(ControllerId);

		public static void Play(byte controllerId, float[] samples, bool queue = true, bool loop = false)
		{
			GetTransmitter(controllerId).Play(samples, queue, loop);
		}

		public static void Pause(byte controllerId)
		{
			GetTransmitter(controllerId).Pause();
		}

		public static void Resume(byte controllerId)
		{
			GetTransmitter(controllerId).Resume();
		}

		public static void Skip(byte controllerId, int count)
		{
			GetTransmitter(controllerId).Skip(count);
		}

		public static void Stop(byte controllerId)
		{
			GetTransmitter(controllerId).Stop();
		}

		public static global::LabApi.Features.Wrappers.SpeakerToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.SpeakerToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.SpeakerToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.SpeakerToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.SpeakerToy speakerToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.SpeakerToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				speakerToy.Spawn();
			}
			return speakerToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseSpeakerToy")]
		public static global::LabApi.Features.Wrappers.SpeakerToy? Get(global::AdminToys.SpeakerToy? baseSpeakerToy)
		{
			if (baseSpeakerToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseSpeakerToy, out global::LabApi.Features.Wrappers.SpeakerToy value))
			{
				return (global::LabApi.Features.Wrappers.SpeakerToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(baseSpeakerToy);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.SpeakerToy? baseSpeakerToy, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.SpeakerToy? speakerToy)
		{
			speakerToy = Get(baseSpeakerToy);
			return speakerToy != null;
		}

		public static global::LabApi.Features.Audio.AudioTransmitter GetTransmitter(byte controllerId)
		{
			if (!TransmitterByControllerId.TryGetValue(controllerId, out global::LabApi.Features.Audio.AudioTransmitter value))
			{
				value = new global::LabApi.Features.Audio.AudioTransmitter(controllerId);
				TransmitterByControllerId.Add(controllerId, value);
			}
			return value;
		}

		internal SpeakerToy(global::AdminToys.SpeakerToy baseSpeakerToy)
			: base(baseSpeakerToy)
		{
			Base = baseSpeakerToy;
			if (base.CanCache)
			{
				Dictionary.Add(baseSpeakerToy, this);
			}
		}

		public void Play(float[] samples, bool queue = true, bool loop = false)
		{
			Transmitter.Play(samples, queue, loop);
		}

		public void Pause()
		{
			Transmitter.Pause();
		}

		public void Resume()
		{
			Transmitter.Resume();
		}

		public void Skip(int count)
		{
			Transmitter.Skip(count);
		}

		public void Stop()
		{
			Transmitter.Stop();
		}

		public override string ToString()
		{
			return $"[SpeakerToy: ControllerId={ControllerId}, IsSpatial={IsSpatial}, Volume={Volume}, MinDistance={MinDistance}, MaxDistance={MaxDistance}, IsPlaying={IsPlaying}]";
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
