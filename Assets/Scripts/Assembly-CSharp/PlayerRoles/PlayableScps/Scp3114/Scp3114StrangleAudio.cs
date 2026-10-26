using AudioPooling;
using CustomPlayerEffects;
using Mirror;
using PlayerRoles.Subroutines;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114StrangleAudio : StandardSubroutine<Scp3114Role>
	{
		private enum RpcType
		{
			ChokeSync = 0,
			Kill = 1
		}

		private Scp3114Strangle _strangle;

		private bool _isChoking;

		private RpcType _rpcType;

		private double _syncKillTime;

		private readonly AbilityCooldown _syncCooldown = new AbilityCooldown();

		[SerializeField]
		private AudioSource _chokeSource;

		[SerializeField]
		private AudioClip _killSoundClip;

		[SerializeField]
		private float _killSoundRange;

		[SerializeField]
		private float _volumeAdjustSpeed;

		[SerializeField]
		private float _killEventTimeSeconds;

		[SerializeField]
		private float _minPitchAdjust;

		[SerializeField]
		private float _maxPitchAdjust;

		private const float MinSyncCooldownSeconds = 0.2f;

		private double _samplesToSeconds;

		private double _secondsToSamples;

		public bool LocallyStrangled
		{
			get
			{
				if (!ReferenceHub.TryGetPovHub(out var hub))
				{
					return false;
				}
				Strangled effect = hub.playerEffectsController.GetEffect<Strangled>();
				if (effect.IsEnabled && effect.TryUpdateAttacker(out var attacker))
				{
					return attacker == base.Owner;
				}
				return false;
			}
		}

		private void ServerSendRpc(RpcType rpcType)
		{
			_rpcType = rpcType;
			ServerSendRpc(toAll: true);
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				UpdateServer();
			}
			_chokeSource.mute = !base.Role.IsLocalPlayer && !LocallyStrangled;
			_chokeSource.volume = Mathf.MoveTowards(_chokeSource.volume, _isChoking ? 1 : 0, Time.deltaTime * _volumeAdjustSpeed);
		}

		private void UpdateServer()
		{
			if (!_strangle.SyncTarget.HasValue)
			{
				if (_isChoking)
				{
					_isChoking = false;
					ServerSendRpc(RpcType.ChokeSync);
				}
			}
			else if (_syncCooldown.IsReady)
			{
				Strangled effect = _strangle.SyncTarget.Value.Target.playerEffectsController.GetEffect<Strangled>();
				_isChoking = true;
				_syncKillTime = NetworkTime.time + (double)effect.EstimatedTimeToKill;
				ServerSendRpc(RpcType.ChokeSync);
				_syncCooldown.Trigger(0.20000000298023224);
			}
		}

		private void ResyncAudio()
		{
			double num = _syncKillTime - NetworkTime.time;
			if (num <= 0.0)
			{
				return;
			}
			if (!_chokeSource.isPlaying)
			{
				_chokeSource.Play();
			}
			float num2 = (float)(((double)_killEventTimeSeconds - (double)_chokeSource.timeSamples * _samplesToSeconds) / num);
			float num3 = Mathf.Abs(1f - num2);
			if (!(num3 < _minPitchAdjust))
			{
				if (num3 > _maxPitchAdjust)
				{
					double num4 = (double)_killEventTimeSeconds - num;
					_chokeSource.timeSamples = (int)(num4 * _secondsToSamples);
					_chokeSource.pitch = 1f;
				}
				else
				{
					_chokeSource.pitch = num2;
				}
			}
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp3114Strangle>(out _strangle);
			_secondsToSamples = (float)_chokeSource.clip.samples / _chokeSource.clip.length;
			_samplesToSeconds = 1.0 / _secondsToSamples;
			_strangle.ServerOnKill += () =>
			{
				ServerSendRpc(RpcType.Kill);
			};
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_rpcType);
			switch (_rpcType)
			{
			case RpcType.Kill:
				writer.WriteRelativePosition(new RelativePosition(base.CastRole.FpcModule.Position));
				break;
			case RpcType.ChokeSync:
				writer.WriteDouble(_isChoking ? _syncKillTime : 0.0);
				break;
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.Kill:
				AudioSourcePoolManager.PlayAtPosition(_killSoundClip, reader.ReadRelativePosition(), _killSoundRange, 1f, FalloffType.Exponential, MixerChannel.NoDucking);
				break;
			case RpcType.ChokeSync:
				_syncKillTime = reader.ReadDouble();
				_isChoking = _syncKillTime != 0.0;
				ResyncAudio();
				break;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_syncCooldown.Clear();
			_chokeSource.Stop();
			_isChoking = false;
			_chokeSource.volume = 0f;
			_chokeSource.mute = true;
		}
	}
}
