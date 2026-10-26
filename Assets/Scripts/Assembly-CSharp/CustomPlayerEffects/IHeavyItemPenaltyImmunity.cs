namespace CustomPlayerEffects
{
	public interface IHeavyItemPenaltyImmunity
	{
		static bool IsImmune(ReferenceHub hub)
		{
			StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
			foreach (StatusEffectBase statusEffectBase in allEffects)
			{
				if (statusEffectBase is IHeavyItemPenaltyImmunity && statusEffectBase.IsEnabled)
				{
					return true;
				}
			}
			return false;
		}
	}
}
