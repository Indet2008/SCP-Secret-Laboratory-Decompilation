using System;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127Hitscan : SingleBulletHitscan
	{
		[Serializable]
		private struct StatsTierPair
		{
			public Scp127Tier Tier;

			[Range(0f, 1f)]
			public float Penetration;

			public float Damage;

			public float BulletAccuracy;
		}

		[SerializeField]
		private StatsTierPair[] _statPairs;

		public override float BaseDamage
		{
			get
			{
				if (!TryGetCurPair(out var ret))
				{
					return base.BaseDamage;
				}
				return ret.Damage;
			}
			protected set
			{
				base.BaseDamage = value;
			}
		}

		public override float BasePenetration
		{
			get
			{
				if (!TryGetCurPair(out var ret))
				{
					return base.BasePenetration;
				}
				return ret.Penetration;
			}
			protected set
			{
				base.BasePenetration = value;
			}
		}

		public override float BaseBulletInaccuracy
		{
			get
			{
				if (!TryGetCurPair(out var ret))
				{
					return base.BaseBulletInaccuracy;
				}
				return ret.BulletAccuracy;
			}
		}

		protected override AttackerDamageHandler GetHandler(float damageDealt)
		{
			return new CustomReasonFirearmDamageHandler(DeathTranslations.Scp127Bullets, base.Firearm, damageDealt, EffectivePenetration, UseHitboxMultipliers);
		}

		private bool TryGetCurPair(out StatsTierPair ret)
		{
			Scp127Tier tierForItem = Scp127TierManagerModule.GetTierForItem(base.Item);
			StatsTierPair[] statPairs = _statPairs;
			for (int i = 0; i < statPairs.Length; i++)
			{
				StatsTierPair statsTierPair = statPairs[i];
				if (statsTierPair.Tier == tierForItem)
				{
					ret = statsTierPair;
					return true;
				}
			}
			ret = default;
			return false;
		}
	}
}
