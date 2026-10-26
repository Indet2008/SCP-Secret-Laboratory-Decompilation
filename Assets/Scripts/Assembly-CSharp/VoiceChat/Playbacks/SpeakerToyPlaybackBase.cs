using System.Collections.Generic;
using UnityEngine;
using VoiceChat.Codec;
using VoiceChat.Networking;

namespace VoiceChat.Playbacks
{
	public class SpeakerToyPlaybackBase : VoiceChatPlaybackBase
	{
		public static readonly HashSet<SpeakerToyPlaybackBase> AllInstances = new HashSet<SpeakerToyPlaybackBase>();

		private static float[] _receiveBuffer;

		private static bool _receiveBufferSet;

		private OpusDecoder _decoder = new OpusDecoder();

		public byte ControllerId;

		public PlaybackBuffer Buffer;

		public Vector3 LastPosition { get; private set; }

		public bool Culled { get; private set; }

		public override int MaxSamples => Buffer.Length;

		public void DecodeSamples(AudioMessage msg)
		{
			if (!_receiveBufferSet)
			{
				_receiveBufferSet = true;
				_receiveBuffer = new float[24000];
			}
			RegisterInput();
			int length = _decoder.Decode(msg.Data, msg.DataLength, _receiveBuffer);
			Buffer.Write(_receiveBuffer, length);
		}

		protected override void Awake()
		{
			base.Awake();
			Buffer = new PlaybackBuffer();
		}

		protected override void OnEnable()
		{
			base.OnEnable();
			AllInstances.Add(this);
		}

		protected override void OnDisable()
		{
			base.OnDisable();
			AllInstances.Remove(this);
		}

		protected override void Update()
		{
			base.Update();
			LastPosition = base.transform.position;
		}

		private void OnDestroy()
		{
			_decoder.Dispose();
		}

		protected override float ReadSample()
		{
			return Buffer.Read();
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnLateUpdate += OnLateUpdate;
		}

		private static void OnLateUpdate()
		{
			if (!MainCameraController.InstanceActive)
			{
				return;
			}
			Vector3 position = MainCameraController.CurrentCamera.position;
			foreach (SpeakerToyPlaybackBase allInstance in AllInstances)
			{
				allInstance.Culled = true;
				ValidatePlayback(position, allInstance);
			}
		}

		private static void ValidatePlayback(Vector3 cameraPosition, SpeakerToyPlaybackBase playback)
		{
			float sqrMagnitude = (playback.LastPosition - cameraPosition).sqrMagnitude;
			float maxDistance = playback.Source.maxDistance;
			if (!(sqrMagnitude > maxDistance * maxDistance))
			{
				playback.Culled = false;
			}
		}
	}
}
