using UnityEngine;

namespace InventorySystem.Items.Thirdperson
{
	public readonly struct ThirdpersonLayerWeight
	{
		public readonly float Weight;

		public readonly bool AllowOther;

		public ThirdpersonLayerWeight(float weight, bool allowOther = true)
		{
			Weight = weight;
			AllowOther = allowOther;
		}

		public static ThirdpersonLayerWeight Lerp(ThirdpersonLayerWeight lhs, ThirdpersonLayerWeight rhs, float time)
		{
			if (time <= 0f)
			{
				return lhs;
			}
			if (time >= 1f)
			{
				return rhs;
			}
			float weight = Mathf.Lerp(lhs.Weight, rhs.Weight, time);
			bool allowOther = lhs.AllowOther && rhs.AllowOther;
			return new ThirdpersonLayerWeight(weight, allowOther);
		}
	}
}
