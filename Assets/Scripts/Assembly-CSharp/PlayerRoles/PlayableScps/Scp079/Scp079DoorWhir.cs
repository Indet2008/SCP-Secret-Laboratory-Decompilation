using System;
using AudioPooling;
using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079
{
	public class Scp079DoorWhir
	{
		private readonly Scp079DoorLockChanger _lockChanger;

		private readonly Scp079AuxManager _auxManager;

		private readonly DoorVariant _door;

		private readonly AudioSource _whirSrc;

		private bool _active;

		private bool _deactivating;

		private float _startAux;

		private const float WhirDist = 15f;

		private const float VolumeAdjustSpeed = 0.7f;

		private const float PitchLerpSpeed = 2f;

		private const float ShutdownPitch = 0.5f;

		private const float StartPitch = 0.9f;

		private const float FinalPitch = 1.8f;

		private const float MinStartAux = 5f;

		private bool Valid
		{
			get
			{
				if (_door != null && _lockChanger.LockedDoor == _door)
				{
					return !_lockChanger.Role.Pooled;
				}
				return false;
			}
		}

		public Scp079DoorWhir(Scp079Role scp079, AudioClip whirSound)
		{
			scp079.SubroutineModule.TryGetSubroutine<Scp079DoorLockChanger>(out _lockChanger);
			scp079.SubroutineModule.TryGetSubroutine<Scp079AuxManager>(out _auxManager);
			_door = _lockChanger.LockedDoor;
			StaticUnityMethods.OnUpdate += OnUpdate;
			_whirSrc = AudioSourcePoolManager.CreateNewSource().Source;
			AudioSourcePoolManager.ApplyStandardSettings(_whirSrc, whirSound, FalloffType.Exponential, MixerChannel.NoDucking, 1f, 15f);
			_whirSrc.transform.position = _door.transform.position;
			_whirSrc.loop = true;
			_whirSrc.volume = 0f;
			_whirSrc.Play();
			_active = true;
			_startAux = 5f;
		}

		private void OnUpdate()
		{
			try
			{
				UpdateAudioSource();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		private void UpdateAudioSource()
		{
			if (_deactivating || !Valid)
			{
				_deactivating = true;
				MuteSource();
				return;
			}
			if (_door.TargetState)
			{
				MuteSource();
				return;
			}
			if (_whirSrc.volume == 0f)
			{
				_startAux = Mathf.Max(_auxManager.CurrentAuxFloored, 5f);
			}
			float b = Mathf.Lerp(1.8f, 0.9f, (float)_auxManager.CurrentAuxFloored / _startAux);
			_whirSrc.pitch = Mathf.Lerp(_whirSrc.pitch, b, Time.deltaTime * 2f);
			_whirSrc.volume += 0.7f * Time.deltaTime;
		}

		private void MuteSource()
		{
			if (_whirSrc == null)
			{
				Destruct();
				return;
			}
			_whirSrc.volume -= 0.7f * Time.deltaTime;
			_whirSrc.pitch = Mathf.Lerp(_whirSrc.pitch, 0.5f, Time.deltaTime * 2f);
			if (_deactivating && _whirSrc.volume <= 0f)
			{
				Destruct();
			}
		}

		private void Destruct()
		{
			if (_active)
			{
				_active = false;
				StaticUnityMethods.OnUpdate -= OnUpdate;
				if (!(_whirSrc == null) && !(_whirSrc.gameObject == null))
				{
					UnityEngine.Object.Destroy(_whirSrc.gameObject);
				}
			}
		}

		~Scp079DoorWhir()
		{
			Destruct();
		}
	}
}
