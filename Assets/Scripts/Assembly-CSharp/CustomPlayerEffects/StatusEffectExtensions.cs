using System.Text;
using System.Text.RegularExpressions;
using NorthwoodLib.Pools;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public static class StatusEffectExtensions
	{
		public static Color NegativeEffectColor { get; } = new Color(1f, 0.4784314f, 0.4784314f);

		public static Color PositiveEffectColor { get; } = new Color(180f / 255f, 1f, 180f / 255f);

		public static Color MixedEffectColor { get; } = new Color(1f, 180f / 255f, 1f);

		public static Color TechnicalEffectColor { get; } = new Color(245f / 255f, 0.8705882f, 93f / 255f);

		public static Color GetEffectColor(this StatusEffectBase effect)
		{
			return effect.Classification switch
			{
				StatusEffectBase.EffectClassification.Positive => PositiveEffectColor, 
				StatusEffectBase.EffectClassification.Technical => TechnicalEffectColor, 
				StatusEffectBase.EffectClassification.Negative => NegativeEffectColor, 
				StatusEffectBase.EffectClassification.Mixed => MixedEffectColor, 
				_ => NegativeEffectColor, 
			};
		}

		public static string GetEffectName(this StatusEffectBase effect)
		{
			if (effect is ICustomDisplayName customDisplayName && !string.IsNullOrEmpty(customDisplayName.DisplayName))
			{
				return customDisplayName.DisplayName;
			}
			return Regex.Replace(effect.name, "(\\B[A-Z])", " $1");
		}

		public static string GetDisplayNameComplete(this StatusEffectBase effect)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.AppendFormat("<color={0}>", effect.GetEffectColor().ToHex());
			stringBuilder.Append(effect.GetEffectName());
			stringBuilder.AppendFormat("[{0}]</color>", effect.Intensity);
			if (effect is IDisplayInfoEffect displayInfoEffect)
			{
				displayInfoEffect.AppendDisplayInfo(stringBuilder);
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}
	}
}
