using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public interface IDisplayableInaccuracyProviderModule : IInaccuracyProviderModule
	{
		DisplayInaccuracyValues DisplayInaccuracy { get; }

		static DisplayInaccuracyValues GetCombinedDisplayInaccuracy(Firearm firearm, bool addBulletToRest = false)
		{
			float num = 0f;
			float num2 = 0f;
			float num3 = 0f;
			float num4 = 0f;
			ModuleBase[] modules = firearm.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is IDisplayableInaccuracyProviderModule { DisplayInaccuracy: var displayInaccuracy })
				{
					num += displayInaccuracy.HipDeg;
					num2 += displayInaccuracy.AdsDeg;
					num3 += displayInaccuracy.RunningDeg;
					num4 += displayInaccuracy.BulletDeg;
				}
			}
			if (addBulletToRest)
			{
				num += num4;
				num2 += num4;
				num3 += num4;
			}
			return new DisplayInaccuracyValues(num, num2, num3, num4);
		}

		static float GetDisplayAccurateRange(float dispersionDegrees, bool imperial, bool rounded)
		{
			double a = dispersionDegrees * (MathF.PI / 180f);
			double num = 2.0 * Math.Tan(a);
			if (num <= 0.0)
			{
				return 5000f;
			}
			float num2 = (float)(1.0 / num);
			if (imperial)
			{
				num2 *= 1.0936f;
			}
			if (!rounded)
			{
				return num2;
			}
			if (num2 > 200f)
			{
				return Mathf.Round(num2 / 5f) * 5f;
			}
			if (num2 > 100f)
			{
				return Mathf.Round(num2);
			}
			return Mathf.Round(num2 * 10f) / 10f;
		}
	}
}
