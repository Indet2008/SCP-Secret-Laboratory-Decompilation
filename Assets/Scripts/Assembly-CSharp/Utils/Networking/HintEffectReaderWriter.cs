using System;
using Hints;
using Mirror;
using UnityEngine;

namespace Utils.Networking
{
	public static class HintEffectReaderWriter
	{
		public enum HintEffectType : byte
		{
			Alpha = 0,
			AlphaCurve = 1,
			Outline = 2
		}

		public static HintEffect ReadHintEffect(this NetworkReader reader)
		{
			byte b = reader.ReadByte();
			Func<NetworkReader, HintEffect> func;
			switch ((HintEffectType)b)
			{
			case HintEffectType.Alpha:
				func = AlphaEffect.FromNetwork;
				break;
			case HintEffectType.AlphaCurve:
				func = AlphaCurveHintEffect.FromNetwork;
				break;
			case HintEffectType.Outline:
				func = OutlineEffect.FromNetwork;
				break;
			default:
				Debug.LogWarning($"Received malformed hint parameter (type {b}).");
				return null;
			}
			return func(reader);
		}

		public static void WriteHintEffect(this NetworkWriter writer, HintEffect effect)
		{
			if (effect == null)
			{
				throw new ArgumentNullException("effect");
			}
			HintEffectType value;
			if (!(effect is AlphaEffect))
			{
				if (!(effect is AlphaCurveHintEffect))
				{
					if (!(effect is OutlineEffect))
					{
						throw new ArgumentException("Hint effect was of an unknown type. This type should be added to the pattern switch (needed for polymorphism to work).", "effect");
					}
					value = HintEffectType.Outline;
				}
				else
				{
					value = HintEffectType.AlphaCurve;
				}
			}
			else
			{
				value = HintEffectType.Alpha;
			}
			writer.WriteByte((byte)value);
			effect.Serialize(writer);
		}
	}
}
