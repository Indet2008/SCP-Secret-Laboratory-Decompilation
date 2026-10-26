using System;
using Mirror;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939BreathController : StandardSubroutine<Scp939Role>
	{
		[Serializable]
		private class IdleLoop939
		{
			[SerializeField]
			private AudioSource _thirdperson;

			[SerializeField]
			[Range(0f, 1f)]
			private float _thirdpersonVolume = 1f;

			[SerializeField]
			private AudioSource _firstperson;

			[SerializeField]
			[Range(0f, 1f)]
			private float _firstPersonVolume = 1f;

			private bool _cacheSet;

			private bool _has3rd;

			private bool _has1st;

			private bool _local;

			public float CurVolume { get; private set; }

			public void SetVolume(bool isOn, float lerp)
			{
				SetVolume(isOn ? 1 : 0, lerp);
			}

			public void SetOwner(bool isLocalPlayer)
			{
				_local = isLocalPlayer;
				SetVolume(CurVolume);
			}

			public void SetVolume(float vol, float lerp = 1f)
			{
				if (!_cacheSet)
				{
					_has3rd = _thirdperson != null;
					_has1st = _firstperson != null;
					_cacheSet = true;
				}
				CurVolume = Mathf.Lerp(CurVolume, vol, lerp);
				if (_has3rd)
				{
					_thirdperson.volume = (_local ? 0f : (CurVolume * _thirdpersonVolume));
				}
				if (_has1st)
				{
					_firstperson.volume = (_local ? (CurVolume * _firstPersonVolume) : 0f);
				}
			}
		}

		[SerializeField]
		private float _exhaustionGainLerp;

		[SerializeField]
		private float _exhaustionDropLerp;

		[SerializeField]
		private float _exhaustionMuteLoopsThreshold;

		[SerializeField]
		private AnimationCurve _exhaustionVolume;

		[SerializeField]
		private float _breathLerp;

		[SerializeField]
		private float _focusGrowlGainLerp;

		[SerializeField]
		private float _focusGrowlDropLerp;

		private float _timeFromLastFocus;

		[SerializeField]
		private float _dropFocusAfter = 5f;

		[SerializeField]
		private IdleLoop939 _focusLoop;

		[SerializeField]
		private IdleLoop939 _breathLoop;

		[SerializeField]
		private IdleLoop939 _exhaustionLoop;

		[SerializeField]
		private IdleLoop939 _focusGrowlLoop;

		private float _curExhaustion;

		private StaminaStat _stamina;

		private Scp939FocusAbility _focus;

		public override void SpawnObject()
		{
			base.SpawnObject();
			RefreshPerspective();
			ForEachLoop((IdleLoop939 x) =>
			{
				x.SetVolume(0f);
			});
			_stamina = base.Owner.playerStats.GetModule<StaminaStat>();
			SpectatorTargetTracker.OnTargetChanged += RefreshPerspective;
			if (NetworkServer.active)
			{
				_stamina.ChangeSyncMode(SyncedStatBase.SyncMode.Public);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_curExhaustion = 0f;
			SpectatorTargetTracker.OnTargetChanged -= RefreshPerspective;
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp939FocusAbility>(out _focus);
		}

		private void RefreshPerspective()
		{
			bool isLocal = base.Owner.IsLocallySpectated() || base.Owner.isLocalPlayer;
			ForEachLoop((IdleLoop939 x) =>
			{
				x.SetOwner(isLocal);
			});
		}

		private void ForEachLoop(Action<IdleLoop939> action)
		{
			action(_focusLoop);
			action(_breathLoop);
			action(_exhaustionLoop);
			action(_focusGrowlLoop);
		}

		private void Update()
		{
			float num = Mathf.Clamp01(1f - _stamina.CurValue);
			_curExhaustion = Mathf.Lerp(_curExhaustion, num, Time.deltaTime * ((num > _curExhaustion) ? _exhaustionGainLerp : _exhaustionDropLerp));
			_exhaustionLoop.SetVolume(_exhaustionVolume.Evaluate(_curExhaustion));
			bool flag = _curExhaustion > _exhaustionMuteLoopsThreshold;
			bool flag2 = !flag && _focus.TargetState;
			if (_focus.TargetState)
			{
				_timeFromLastFocus = 0f;
			}
			else
			{
				_timeFromLastFocus += Time.deltaTime;
			}
			if (_timeFromLastFocus == 0f || _timeFromLastFocus > _dropFocusAfter)
			{
				_focusGrowlLoop.SetVolume(flag2, Time.deltaTime * (flag2 ? _focusGrowlGainLerp : _focusGrowlDropLerp));
			}
			_focusLoop.SetVolume(flag2, Time.deltaTime * _breathLerp);
			_breathLoop.SetVolume(!flag && !_focus.TargetState, Time.deltaTime * _breathLerp);
		}
	}
}
