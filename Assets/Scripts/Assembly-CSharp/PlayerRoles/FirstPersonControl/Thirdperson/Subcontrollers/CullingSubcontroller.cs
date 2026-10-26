using System;
using System.Collections.Generic;
using System.Diagnostics;
using ProgressiveCulling;
using UnityEngine;
using UserSettings;
using UserSettings.VideoSettings;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public class CullingSubcontroller : CullableSimpleDynamic, IAnimatedModelSubcontroller
	{
		private enum AnimationQuality
		{
			VeryLow = 0,
			Low = 1,
			Medium = 2,
			High = 3,
			Ultra = 4
		}

		private static readonly CachedUserSetting<int> AnimQualitySetting = new CachedUserSetting<int>(PerformanceVideoSetting.AnimationQuality);

		private static readonly Dictionary<int, int> PreviousSameFrequencyCounter = new Dictionary<int, int>();

		private static int _lastFrequencyCounterResetFrame;

		private AnimatedCharacterModel _model;

		private readonly Stopwatch _lastUpdatedSw = Stopwatch.StartNew();

		private const float MaxSkipDeltaTime = 5f;

		private const float MinUnculledUpdateRate = 13f;

		private int _updateModuloFrames;

		private int _updateOffsetFrames;

		private float _sqrDistanceToLocalPlayer;

		public override bool ShouldBeVisible
		{
			get
			{
				if (_model.HasOwner)
				{
					return CullingCamera.CheckBoundsVisibility(base.WorldspaceBounds);
				}
				return true;
			}
		}

		public bool AnimCulled { get; private set; }

		public bool SkipAnimationUpdate
		{
			get
			{
				if (!_model.HasOwner || _updateModuloFrames <= 1)
				{
					return false;
				}
				if (LastUpdateElapsed >= 1f / 13f)
				{
					return false;
				}
				return (Time.frameCount + _updateOffsetFrames) % _updateModuloFrames != 0;
			}
		}

		public int InverseUpdateFrequency => (AnimationQuality)AnimQualitySetting.Value switch
		{
			AnimationQuality.Ultra => 1, 
			AnimationQuality.VeryLow => GenerateInverseFrequency(5, 5f) + 1, 
			AnimationQuality.Low => GenerateInverseFrequency(5, 6f), 
			AnimationQuality.Medium => GenerateInverseFrequency(4, 9f), 
			AnimationQuality.High => GenerateInverseFrequency(3, 13f), 
			_ => 1, 
		};

		public float LastUpdateElapsed => (float)_lastUpdatedSw.Elapsed.TotalSeconds;

		public static event Action OnAnyAnimatorUpdated;

		public event Action OnAnimatorUpdated;

		public event Action OnBeforeAnimatorUpdated;

		public void Init(AnimatedCharacterModel model, int index)
		{
			_model = model;
		}

		public void OnReassigned()
		{
			_model.Animator.enabled = false;
		}

		protected override bool AllowDeactivationFilter(GameObject go)
		{
			if (go != base.gameObject)
			{
				return go.activeInHierarchy;
			}
			return false;
		}

		protected override bool AllowCullingFilter(GameObject go)
		{
			if (base.AllowCullingFilter(go))
			{
				return go.activeInHierarchy;
			}
			return false;
		}

		private void EvaluateCulling(out bool allowCulling, out float sqrDisToLocalPlayerSqr)
		{
			if (!_model.HasOwner)
			{
				allowCulling = false;
				sqrDisToLocalPlayerSqr = 0f;
				return;
			}
			float footstepLoudnessDistance = _model.FootstepLoudnessDistance;
			float num = footstepLoudnessDistance * footstepLoudnessDistance;
			Vector3 position = _model.CachedTransform.position;
			Vector3 lastCamPosition = CullingCamera.LastCamPosition;
			sqrDisToLocalPlayerSqr = (position - lastCamPosition).sqrMagnitude;
			allowCulling = sqrDisToLocalPlayerSqr > num;
		}

		private void LateUpdate()
		{
			EvaluateCulling(out var allowCulling, out _sqrDistanceToLocalPlayer);
			bool animCulled = AnimCulled;
			AnimCulled = base.IsCulled & allowCulling;
			if (!AnimCulled)
			{
				UpdatePriority();
				if (!SkipAnimationUpdate || animCulled)
				{
					UpdateAnimator();
				}
			}
		}

		private void UpdatePriority()
		{
			if (_lastFrequencyCounterResetFrame != Time.frameCount)
			{
				PreviousSameFrequencyCounter.Clear();
				_lastFrequencyCounterResetFrame = Time.frameCount;
			}
			_updateModuloFrames = InverseUpdateFrequency;
			_updateOffsetFrames = PreviousSameFrequencyCounter.GetValueOrDefault(_updateModuloFrames);
			PreviousSameFrequencyCounter[_updateModuloFrames] = _updateOffsetFrames + 1;
		}

		private void UpdateAnimator()
		{
			OnBeforeAnimatorUpdated?.Invoke();
			_model.Animator.Update(Mathf.Min(LastUpdateElapsed, 5f));
			_lastUpdatedSw.Restart();
			OnAnimatorUpdated?.Invoke();
			OnAnyAnimatorUpdated?.Invoke();
		}

		private int GenerateInverseFrequency(int maxInvFreq, float distanceStep)
		{
			if (base.IsCulled)
			{
				return maxInvFreq;
			}
			for (int i = 1; i <= maxInvFreq; i++)
			{
				float num = (float)i * distanceStep;
				if (!(_sqrDistanceToLocalPlayer > num * num))
				{
					return i;
				}
			}
			return maxInvFreq;
		}
	}
}
