using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.Rendering;

namespace CustomPlayerEffects
{
	public class CardiacHealthIndicator : SubEffectBase
	{
		[SerializeField]
		private AnimationCurve _healthToWeight;

		[SerializeField]
		private Volume _ppv;

		[SerializeField]
		private float _speedMultiplier;

		private HealthStat _hp;

		private float _targetWeight;

		public override bool IsActive => base.MainEffect.IsEnabled;

		private void SetTargetWeight(float weight)
		{
			_targetWeight = weight;
			_ppv.weight = weight;
		}

		public override void DisableEffect()
		{
			_targetWeight = 0f;
			_ppv.weight = 0f;
		}

		internal override void UpdateEffect()
		{
			if (IsActive && (base.MainEffect.Hub.isLocalPlayer || base.MainEffect.Hub.IsLocallySpectated()))
			{
				float num = 1f - _healthToWeight.Evaluate(_hp.NormalizedValue);
				if (num != _targetWeight)
				{
					_targetWeight = num;
				}
			}
		}

		internal override void Init(StatusEffectBase mainEffect)
		{
			base.Init(mainEffect);
			_hp = base.MainEffect.Hub.playerStats.GetModule<HealthStat>();
		}

		private void Update()
		{
			if (!IsActive)
			{
				if (_targetWeight == 0f && _ppv.weight == 0f)
				{
					return;
				}
				_targetWeight = 0f;
			}
			bool flag = _targetWeight > _ppv.weight;
			float num = Time.deltaTime * _speedMultiplier;
			float num2 = _ppv.weight + (flag ? num : (0f - num));
			_ppv.weight = (flag ? Mathf.Min(num2, _targetWeight) : Mathf.Max(num2, _targetWeight));
			_ppv.weight = Mathf.Clamp01(_ppv.weight);
		}
	}
}
