using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public class RandomCandyEffectsOutcome : BlackCandyOutcomeBase
	{
		private List<ICandy> _cachedPool;

		protected virtual int MinGrantedEffects => 2;

		protected virtual int MaxGrantedEffects => 4;

		protected virtual ICandy[] CandyPool => Scp330Candies.NormalCandies;

		private List<ICandy> CachedPool
		{
			get
			{
				if (_cachedPool == null)
				{
					_cachedPool = CandyPool.Where((ICandy c) => c.SpawnChanceWeight > 0f).ToList();
				}
				return _cachedPool;
			}
		}

		public override void ServerGrant(ReferenceHub target)
		{
			int num = Random.Range(MinGrantedEffects, MaxGrantedEffects + 1);
			for (int i = 0; i < num; i++)
			{
				if (!TryGetCandy(out var result))
				{
					Debug.LogError("[" + GetType().Name + "] Couldn't apply any candies.");
				}
				else
				{
					result.ServerApplyEffects(target);
				}
			}
		}

		private bool TryGetCandy(out ICandy result)
		{
			result = null;
			if (CachedPool.Count == 0)
			{
				return false;
			}
			float maxInclusive = CachedPool.Sum((ICandy c) => c.SpawnChanceWeight);
			float num = Random.Range(0f, maxInclusive);
			float num2 = 0f;
			foreach (ICandy item in CachedPool)
			{
				num2 += item.SpawnChanceWeight;
				if (!(num > num2))
				{
					result = item;
					return true;
				}
			}
			return false;
		}
	}
}
