using System;
using System.Collections.Generic;
using AudioPooling;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class AudioController : MonoBehaviour, ISoundEmittingItem
	{
		[Serializable]
		private struct FiringClipSet
		{
			public MicroHidFiringMode FiringMode;

			public AudioClip WindUpClip;

			public AudioClip StopFiringClip;

			public AudioClip FireClip;

			public AudioClip AbortClip;

			public AnimationCurve AbortStartTimeOverElapsed;
		}

		private bool _cacheSet;

		private bool? _last3d;

		private MicroHidPhase _lastPhase;

		private Transform _cachedTransform;

		private bool _allSilent;

		private FiringClipSet _lastClipSet;

		private float _crossfadeSpeed;

		private readonly List<AudioPoolSession> _activeSessions = new List<AudioPoolSession>();

		[SerializeField]
		private AudioSource _windupSource;

		[SerializeField]
		private AudioSource _winddownSource;

		[SerializeField]
		private AudioSource _firingSource;

		[SerializeField]
		private FiringClipSet[] _clipSets;

		public List<AudioPoolSession> ActiveSessions
		{
			get
			{
				for (int num = _activeSessions.Count - 1; num >= 0; num--)
				{
					if (!_activeSessions[num].SameSession)
					{
						_activeSessions.RemoveAt(num);
					}
				}
				return _activeSessions;
			}
		}

		public ushort Serial { get; set; }

		public bool Idle
		{
			get
			{
				if (_lastPhase != MicroHidPhase.Standby)
				{
					return false;
				}
				if (!_allSilent)
				{
					return false;
				}
				if (ActiveSessions.Count > 0)
				{
					return false;
				}
				return true;
			}
		}

		public Transform FastTr
		{
			get
			{
				ValidateCache();
				return _cachedTransform;
			}
		}

		private void ValidateCache()
		{
			if (!_cacheSet)
			{
				_cachedTransform = base.transform;
				_last3d = null;
				_cacheSet = true;
			}
		}

		private void AdjustVolume(AudioSource src, bool enable, float speed)
		{
			float target = (enable ? 1 : 0);
			float maxDelta = speed * Time.deltaTime;
			src.volume = Mathf.MoveTowards(src.volume, target, maxDelta);
		}

		private void AdjustVolumeFast(AudioSource src, bool enable)
		{
			AdjustVolume(src, enable, 11f);
		}

		private void AdjustVolumeSlow(AudioSource src, bool enable)
		{
			AdjustVolume(src, enable, 2f);
		}

		private void AdjustVolumeInstant(AudioSource src, bool enable)
		{
			src.volume = (enable ? 1 : 0);
		}

		private void OnDestroy()
		{
			AudioManagerModule.RegisterDestroyed(this);
		}

		public AudioPoolSession PlayOneShot(AudioClip clip, float range = 10f, MixerChannel mixer = MixerChannel.NoDucking)
		{
			AudioPoolSession audioPoolSession = new AudioPoolSession(AudioSourcePoolManager.PlayOnTransform(clip, FastTr, range, 1f, FalloffType.Exponential, mixer));
			ActiveSessions.Add(audioPoolSession);
			UpdateSourcePosition();
			return audioPoolSession;
		}

		public void UpdateAudio(MicroHidPhase phase)
		{
			UpdateConditionally(phase);
			_lastPhase = phase;
		}

		private void UpdateConditionally(MicroHidPhase phase)
		{
			if (Idle)
			{
				return;
			}
			UpdateSourcePosition();
			if (phase == MicroHidPhase.Standby)
			{
				UpdateStandby();
				return;
			}
			bool flag = _lastPhase != phase;
			if (!flag || TryFindClipSet(out _lastClipSet))
			{
				switch (phase)
				{
				case MicroHidPhase.WindingUp:
					UpdateWindUp(flag);
					break;
				case MicroHidPhase.WoundUpSustain:
					UpdateWindUp(changed: false);
					break;
				case MicroHidPhase.WindingDown:
					UpdateWindDown(flag);
					break;
				case MicroHidPhase.Firing:
					UpdateFiring(flag);
					break;
				}
				_allSilent = false;
			}
		}

		private void Set3d(bool is3D)
		{
			if (is3D != _last3d)
			{
				_windupSource.SetSpace(is3D);
				_winddownSource.SetSpace(is3D);
				_firingSource.SetSpace(is3D);
				_last3d = is3D;
			}
		}

		private void UpdateSourcePosition()
		{
			ReferenceHub hub;
			if (MicroHIDPickup.PickupsBySerial.TryGetValue(Serial, out var value))
			{
				FastTr.position = value.Position;
				Set3d(is3D: true);
			}
			else if (InventoryExtensions.TryGetHubHoldingSerial(Serial, out hub))
			{
				Set3d(!hub.isLocalPlayer && !hub.IsLocallySpectated());
				FastTr.position = hub.GetPosition();
			}
		}

		private bool TryFindClipSet(out FiringClipSet clipSet)
		{
			MicroHidFiringMode firingMode = CycleSyncModule.GetFiringMode(Serial);
			FiringClipSet[] clipSets = _clipSets;
			for (int i = 0; i < clipSets.Length; i++)
			{
				FiringClipSet firingClipSet = clipSets[i];
				if (firingClipSet.FiringMode == firingMode)
				{
					clipSet = firingClipSet;
					return true;
				}
			}
			clipSet = default;
			return false;
		}

		private void UpdateStandby()
		{
			if (!_allSilent)
			{
				AdjustVolumeFast(_firingSource, enable: false);
				if (_crossfadeSpeed > 0f)
				{
					AdjustVolume(_windupSource, enable: false, _crossfadeSpeed);
					AdjustVolume(_winddownSource, enable: true, _crossfadeSpeed);
				}
				else
				{
					AdjustVolumeFast(_windupSource, enable: false);
				}
				_allSilent = _winddownSource.volume == 0f && _windupSource.volume == 0f && _firingSource.volume == 0f;
			}
		}

		private void UpdateWindUp(bool changed)
		{
			if (changed)
			{
				_windupSource.clip = _lastClipSet.WindUpClip;
				AdjustVolumeInstant(_windupSource, enable: true);
				_windupSource.Play();
			}
			AdjustVolumeSlow(_winddownSource, enable: false);
			AdjustVolumeFast(_firingSource, enable: false);
		}

		private void UpdateWindDown(bool changed)
		{
			if (!changed)
			{
				AdjustVolume(_windupSource, enable: false, _crossfadeSpeed);
				AdjustVolume(_winddownSource, enable: true, _crossfadeSpeed);
				AdjustVolumeSlow(_firingSource, enable: false);
				return;
			}
			float num;
			AudioClip audioClip;
			if (_lastPhase == MicroHidPhase.Firing)
			{
				num = 0f;
				audioClip = _lastClipSet.StopFiringClip;
				_crossfadeSpeed = 4f;
			}
			else
			{
				audioClip = _lastClipSet.AbortClip;
				if (!_windupSource.clip)
				{
					return;
				}
				float length = _windupSource.clip.length;
				float time = _windupSource.time;
				float num2 = length - time;
				if (num2 > 0.01f)
				{
					_crossfadeSpeed = Mathf.Max(4f, 1f / num2);
					num = _lastClipSet.AbortStartTimeOverElapsed.Evaluate(time);
					AdjustVolumeInstant(_winddownSource, enable: false);
				}
				else
				{
					num = 0f;
					AdjustVolumeInstant(_winddownSource, enable: true);
					AdjustVolumeInstant(_windupSource, enable: false);
				}
			}
			if (num <= audioClip.length)
			{
				_winddownSource.clip = audioClip;
				_winddownSource.Play();
				_winddownSource.time = Mathf.Max(0f, num);
			}
			else
			{
				_winddownSource.Stop();
			}
			UpdateWindDown(changed: false);
		}

		private void UpdateFiring(bool changed)
		{
			if (changed)
			{
				_firingSource.clip = _lastClipSet.FireClip;
				_firingSource.Play();
			}
			AdjustVolumeSlow(_windupSource, enable: false);
			AdjustVolumeSlow(_winddownSource, enable: false);
			AdjustVolumeInstant(_firingSource, enable: true);
		}

		public bool TryGetSoundEmissionRange(out float range)
		{
			switch (_lastPhase)
			{
			case MicroHidPhase.WindingUp:
			case MicroHidPhase.WoundUpSustain:
				range = _windupSource.maxDistance;
				return true;
			case MicroHidPhase.WindingDown:
				range = _winddownSource.maxDistance;
				return true;
			case MicroHidPhase.Firing:
				range = _firingSource.maxDistance;
				return true;
			default:
				range = 0f;
				return false;
			}
		}
	}
}
