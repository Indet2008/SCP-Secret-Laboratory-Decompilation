using System.Collections.Generic;
using Interactables;
using Interactables.Verification;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

namespace MapGeneration.Spawnables
{
	[RequireComponent(typeof(AudioSource))]
	public class AudioLog : NetworkBehaviour, IServerInteractable, IInteractable
	{
		private const double BaseCooldown = 3.0;

		public static readonly List<AudioLog> Instances;

		[SerializeField]
		[Min(0f)]
		private float _clipSkipSeconds;

		[SerializeField]
		[Min(0f)]
		private double _audioDuration;

		[SerializeField]
		private AudioSource _audioSource;

		private Transform _audioTransform;

		private double _triggerTimestamp;

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public bool IsPlaying
		{
			get
			{
				if (!_audioSource.isPlaying)
				{
					return _triggerTimestamp + 3.0 > NetworkTime.time;
				}
				return true;
			}
		}

		public float MaxHearingRange => _audioSource.maxDistance;

		public float ClipDuration => (float)_audioDuration - _clipSkipSeconds;

		public Vector3 PlayingLocation => _audioTransform.position;

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!IsPlaying)
			{
				RpcPlayLog(_clipSkipSeconds);
				_triggerTimestamp = NetworkTime.time + (double)ClipDuration;
			}
		}

		[ClientRpc]
		private void RpcPlayLog(float playTime)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteFloat(playTime);
			SendRPCInternal("System.Void MapGeneration.Spawnables.AudioLog::RpcPlayLog(System.Single)", 1831593247, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private void ClientPlayAudio(float playTime = 0f)
		{
			if (playTime > 0f)
			{
				_audioSource.time = playTime;
			}
			_audioSource.Play();
		}

		private void ServerSyncClip(ReferenceHub hub)
		{
			if (IsPlaying)
			{
				double num = _triggerTimestamp - (double)ClipDuration;
				float num2 = (float)(NetworkTime.time - num);
				if (!(num2 >= ClipDuration))
				{
					RpcPlayLog(num2);
				}
			}
		}

		private void Awake()
		{
			_audioTransform = _audioSource.transform;
			Instances.Add(this);
			if (NetworkServer.active)
			{
				ReferenceHub.OnPlayerAdded += ServerSyncClip;
			}
		}

		private void OnDestroy()
		{
			Instances.Remove(this);
			if (NetworkServer.active)
			{
				ReferenceHub.OnPlayerAdded -= ServerSyncClip;
			}
		}

		static AudioLog()
		{
			Instances = new List<AudioLog>();
			RemoteProcedureCalls.RegisterRpc(typeof(AudioLog), "System.Void MapGeneration.Spawnables.AudioLog::RpcPlayLog(System.Single)", InvokeUserCode_RpcPlayLog__Single);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlayLog__Single(float playTime)
		{
		}

		protected static void InvokeUserCode_RpcPlayLog__Single(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlayLog called on server.");
			}
			else
			{
				((AudioLog)obj).UserCode_RpcPlayLog__Single(reader.ReadFloat());
			}
		}
	}
}
