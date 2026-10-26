using UnityEngine;

namespace CustomPlayerEffects
{
	public interface IConflictableEffect
	{
		bool CheckConflicts(StatusEffectBase other);

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StatusEffectBase.OnEnabled += (StatusEffectBase newEffect) =>
			{
				StatusEffectBase[] allEffects = newEffect.Hub.playerEffectsController.AllEffects;
				foreach (StatusEffectBase statusEffectBase in allEffects)
				{
					if (statusEffectBase.IsEnabled && statusEffectBase is IConflictableEffect conflictableEffect && !(statusEffectBase == newEffect))
					{
						conflictableEffect.CheckConflicts(newEffect);
					}
				}
			};
		}
	}
}
