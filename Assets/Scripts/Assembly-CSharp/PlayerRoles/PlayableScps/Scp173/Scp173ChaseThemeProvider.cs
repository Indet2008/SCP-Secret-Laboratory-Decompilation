using System;
using System.Collections.Generic;
using AudioPooling;
using FacilitySoundtrack.ChaseThemes;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173ChaseThemeProvider : SubroutineBase, IChaseThemeProvider
	{
		[Serializable]
		private class EncounterStinger
		{
			public AudioClip Clip;

			public float MinDistanceFromPov;

			public float Cooldown;

			public bool ReduceCooldownWhenObserved;

			public float RemainingCooldown { get; set; }

			public bool TryPlay()
			{
				if (RemainingCooldown > 0f)
				{
					return false;
				}
				AudioSourcePoolManager.Play2D(Clip, 1f, MixerChannel.NoDucking);
				return true;
			}

			public void UpdateCooldown(bool isObserved)
			{
				if (!(RemainingCooldown <= 0f))
				{
					if (isObserved && !ReduceCooldownWhenObserved)
					{
						RemainingCooldown = Cooldown;
					}
					else
					{
						RemainingCooldown -= Time.deltaTime;
					}
				}
			}

			public void ResetCooldown()
			{
				RemainingCooldown = 0f;
			}
		}

		private bool _isObserved;

		private bool _playDrums;

		private float _remainingSustain;

		[SerializeField]
		private EncounterStinger[] _stingers;

		[SerializeField]
		private AudioClip _baselineChaseClip;

		[SerializeField]
		private AudioClip _drumChaseClip;

		[SerializeField]
		private AnimationCurve _dominanceOverDistance;

		[SerializeField]
		private float _sustainTime;

		[SerializeField]
		private float _globalStingerCooldown;

		private const float EnableDrumsThld = 8f;

		private const float DisableDrumsThld = 17.6f;

		public List<DesiredChaseClip> ClipsToPlay { get; private set; } = new List<DesiredChaseClip>();

		public float DominanceScale { get; private set; } = 1f;

		public int Priority => 0;

		public static event Action OnPlayerEscapeScp173;

		private bool GetObservedByPov()
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			if (!(base.Role is Scp173Role scp173Role))
			{
				return false;
			}
			if (!scp173Role.SubroutineModule.TryGetSubroutine<Scp173ObserversTracker>(out var subroutine))
			{
				return false;
			}
			return subroutine.IsObservedBy(hub);
		}

		private void OnFrozen(Scp173Role target)
		{
			if (target != base.Role)
			{
				return;
			}
			_isObserved = true;
			float num = Vector3.Distance(target.FpcModule.Position, MainCameraController.LastPosition);
			bool flag = false;
			EncounterStinger[] stingers = _stingers;
			foreach (EncounterStinger encounterStinger in stingers)
			{
				if (!(encounterStinger.MinDistanceFromPov > num))
				{
					if (encounterStinger.TryPlay())
					{
						flag = true;
						encounterStinger.RemainingCooldown = encounterStinger.Cooldown;
					}
					break;
				}
			}
			if (flag)
			{
				stingers = _stingers;
				foreach (EncounterStinger encounterStinger2 in stingers)
				{
					encounterStinger2.RemainingCooldown = Mathf.Max(_globalStingerCooldown, encounterStinger2.RemainingCooldown);
				}
			}
		}

		private void OnDestroy()
		{
			Scp173CharacterModel.OnFrozen -= OnFrozen;
		}

		private void UpdateClips()
		{
			ClipsToPlay.Clear();
			ClipsToPlay.Add(new DesiredChaseClip(_baselineChaseClip));
			if (_playDrums)
			{
				ClipsToPlay.Add(new DesiredChaseClip(_drumChaseClip));
			}
		}

		protected override void Awake()
		{
			base.Awake();
			Scp173CharacterModel.OnFrozen += OnFrozen;
		}

		public AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers)
		{
			return null;
		}

		public bool TryStartChase()
		{
			return _isObserved;
		}

		public bool UpdateChase()
		{
			_isObserved = GetObservedByPov();
			EncounterStinger[] stingers = _stingers;
			for (int i = 0; i < stingers.Length; i++)
			{
				stingers[i].UpdateCooldown(_isObserved);
			}
			float num = Vector3.Distance(MainCameraController.LastPosition, (base.Role as IFpcRole).FpcModule.Position);
			DominanceScale = _dominanceOverDistance.Evaluate(num);
			UpdateClips();
			if (_isObserved)
			{
				if (num < 8f)
				{
					_playDrums = true;
				}
				else if (num > 17.6f)
				{
					_playDrums = false;
				}
				_remainingSustain = _sustainTime;
				return true;
			}
			_remainingSustain -= Time.deltaTime;
			if (_remainingSustain > 0f)
			{
				return true;
			}
			OnPlayerEscapeScp173?.Invoke();
			return false;
		}

		public void OnChaseStopped()
		{
			_isObserved = false;
			_playDrums = false;
			EncounterStinger[] stingers = _stingers;
			for (int i = 0; i < stingers.Length; i++)
			{
				stingers[i].ResetCooldown();
			}
		}
	}
}
