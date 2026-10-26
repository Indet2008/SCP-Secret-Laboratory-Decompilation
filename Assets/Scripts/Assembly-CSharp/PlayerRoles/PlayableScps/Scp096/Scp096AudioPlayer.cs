using System;
using System.Collections.Generic;
using AudioPooling;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096AudioPlayer : StandardSubroutine<Scp096Role>
	{
		[Serializable]
		public class Scp096StateAudio
		{
			public AudioClip Audio;

			public Scp096RageState State;

			public FalloffType Falloff;

			public float MaxDistance;
		}

		[SerializeField]
		private AudioSource _rageStatesSource;

		[SerializeField]
		private AudioSource _tryNotToCrySource;

		[SerializeField]
		private float _volumeAdjustLerp;

		[SerializeField]
		private CurvePreset[] _curves;

		[SerializeField]
		private Scp096StateAudio[] _rageStatesAudioClips;

		[SerializeField]
		private AudioClip[] _lethalClips;

		[SerializeField]
		private AudioClip[] _nonLethalClips;

		[SerializeField]
		private float _lethalDistance;

		[SerializeField]
		private float _nonLethalDistance;

		[SerializeField]
		private float _pitchRandomization;

		private static bool _soundsDictionarized = false;

		private Scp096HitResult _syncHitSound;

		private static readonly Dictionary<Scp096RageState, Scp096StateAudio> AudioStates = new Dictionary<Scp096RageState, Scp096StateAudio>();

		private static readonly Dictionary<FalloffType, CurvePreset> Curves = new Dictionary<FalloffType, CurvePreset>();

		private void Update()
		{
			bool flag = base.CastRole.IsAbilityState(Scp096AbilityState.TryingNotToCry);
			float num = Mathf.Lerp(_tryNotToCrySource.volume, flag ? 1 : 0, Time.deltaTime * _volumeAdjustLerp);
			_tryNotToCrySource.volume = num;
			_rageStatesSource.volume = 1f - num;
		}

		protected override void Awake()
		{
			base.Awake();
			base.CastRole.StateController.OnRageUpdate += SetAudioState;
			if (!_soundsDictionarized)
			{
				Curves.FromArray(_curves, (CurvePreset x) => x.Type);
				AudioStates.FromArray(_rageStatesAudioClips, (Scp096StateAudio x) => x.State);
				_soundsDictionarized = true;
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			SetAudioState(base.CastRole.StateController.RageState);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_tryNotToCrySource.volume = 0f;
			_rageStatesSource.volume = 0f;
		}

		public void Play(AudioClip clip, FalloffType falloff = FalloffType.Linear, float maxDistance = -1f)
		{
			if (Curves.TryGetValue(falloff, out var value))
			{
				_rageStatesSource.SetCustomCurve(AudioSourceCurveType.CustomRolloff, value.FalloffCurve);
				if (maxDistance > 0f)
				{
					_rageStatesSource.maxDistance = maxDistance;
				}
				_rageStatesSource.clip = clip;
				_rageStatesSource.Play();
			}
		}

		public void SetAudioState(Scp096RageState state)
		{
			if (TryGetAudioForState(state, out var stateAudio) && !(_rageStatesSource.clip == stateAudio.Audio))
			{
				Play(stateAudio.Audio, stateAudio.Falloff, stateAudio.MaxDistance);
			}
		}

		public void Stop()
		{
			if (_rageStatesSource.isPlaying)
			{
				_rageStatesSource.Stop();
			}
			_rageStatesSource.clip = null;
		}

		public void ServerPlayAttack(Scp096HitResult hitRes)
		{
			_syncHitSound = hitRes;
			ServerSendRpc(toAll: true);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_syncHitSound);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			Scp096HitResult scp096HitResult = (Scp096HitResult)reader.ReadByte();
			if ((scp096HitResult & Scp096HitResult.Human) != Scp096HitResult.None)
			{
				bool num = (scp096HitResult & Scp096HitResult.Lethal) == Scp096HitResult.Lethal;
				float maxDistance = (num ? _lethalDistance : _nonLethalDistance);
				AudioClip sound = (num ? _lethalClips : _nonLethalClips).RandomItem();
				MixerChannel channel = (num ? MixerChannel.NoDucking : MixerChannel.DefaultSfx);
				float pitchScale = UnityEngine.Random.Range(1f - _pitchRandomization, 1f + _pitchRandomization);
				if (base.Owner.isLocalPlayer)
				{
					AudioSourcePoolManager.Play2D(sound, 1f, channel, pitchScale);
				}
				else
				{
					AudioSourcePoolManager.PlayOnTransform(sound, base.transform, maxDistance, 1f, FalloffType.Exponential, channel, pitchScale);
				}
			}
		}

		public static bool TryGetAudioForState(Scp096RageState state, out Scp096StateAudio stateAudio)
		{
			return AudioStates.TryGetValue(state, out stateAudio);
		}
	}
}
