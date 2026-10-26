using System;
using UnityEngine;

namespace Respawning.Waves
{
	public abstract class WaveAnimationBase<T> : MonoBehaviour where T : SpawnableWaveBase, IAnimatedWave
	{
		private static readonly int PlayKey = Animator.StringToHash("Play");

		private float _animationTime;

		public T Wave { get; private set; }

		[field: SerializeField]
		protected Animator AnimatorTrigger { get; private set; }

		protected virtual void Awake()
		{
			if (!WaveManager.TryGet<T>(out var spawnWave))
			{
				throw new NullReferenceException("Could not find a reference to the T spawn wave.");
			}
			Wave = spawnWave;
			WaveManager.OnWaveTrigger += OnWaveTrigger;
		}

		protected virtual void OnWaveTriggered()
		{
			Wave.IsAnimationPlaying = true;
			AnimatorTrigger.SetTrigger(PlayKey);
		}

		protected virtual void OnAnimationEnd()
		{
			Wave.IsAnimationPlaying = false;
		}

		protected virtual void Update()
		{
			bool isAnimationPlaying = Wave.IsAnimationPlaying;
			bool flag = Time.time >= _animationTime;
			if (isAnimationPlaying && flag)
			{
				OnAnimationEnd();
			}
		}

		private void OnWaveTrigger(SpawnableWaveBase triggeredWave)
		{
			if (triggeredWave == Wave)
			{
				_animationTime = Time.time + Wave.AnimationDuration;
				OnWaveTriggered();
			}
		}

		private void OnDestroy()
		{
			WaveManager.OnWaveTrigger -= OnWaveTrigger;
		}
	}
}
