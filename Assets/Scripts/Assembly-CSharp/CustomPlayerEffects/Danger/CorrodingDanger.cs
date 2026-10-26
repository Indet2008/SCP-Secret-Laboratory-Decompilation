using System;

namespace CustomPlayerEffects.Danger
{
	public class CorrodingDanger : DangerStackBase
	{
		private Corroding _corroding;

		private PocketCorroding _pocketCorroding;

		public override float DangerValue { get; set; } = 1f;

		public override void Initialize(ReferenceHub target)
		{
			base.Initialize(target);
			if (!base.Owner.playerEffectsController.TryGetEffect<Corroding>(out _corroding))
			{
				throw new NullReferenceException("Corroding wasn't found. This DangerOverride will not function as intended.");
			}
			if (!base.Owner.playerEffectsController.TryGetEffect<PocketCorroding>(out _pocketCorroding))
			{
				throw new NullReferenceException("PocketCorroding wasn't found. This DangerOverride will not function as intended.");
			}
			IsActive = _corroding.IsEnabled || _pocketCorroding.IsEnabled;
			StatusEffectBase.OnEnabled += UpdateState;
			StatusEffectBase.OnDisabled += UpdateState;
		}

		public override void Dispose()
		{
			base.Dispose();
			StatusEffectBase.OnEnabled -= UpdateState;
			StatusEffectBase.OnDisabled -= UpdateState;
		}

		private void UpdateState(StatusEffectBase effect)
		{
			if (!(effect != _corroding) || !(effect != _pocketCorroding))
			{
				IsActive = _corroding.IsEnabled || _pocketCorroding.IsEnabled;
			}
		}
	}
}
