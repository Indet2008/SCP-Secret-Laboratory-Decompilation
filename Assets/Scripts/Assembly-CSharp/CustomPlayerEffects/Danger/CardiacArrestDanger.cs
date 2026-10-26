using System;

namespace CustomPlayerEffects.Danger
{
	public class CardiacArrestDanger : DangerStackBase
	{
		private CardiacArrest _cardiacArrest;

		public override float DangerValue { get; set; } = 2f;

		public override void Initialize(ReferenceHub target)
		{
			base.Initialize(target);
			if (!base.Owner.playerEffectsController.TryGetEffect<CardiacArrest>(out _cardiacArrest))
			{
				throw new NullReferenceException("Cardiac arrest wasn't found. This DangerOverride will not function as intended.");
			}
			IsActive = _cardiacArrest.IsEnabled;
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
			if (!(effect != _cardiacArrest))
			{
				IsActive = effect.IsEnabled;
			}
		}
	}
}
