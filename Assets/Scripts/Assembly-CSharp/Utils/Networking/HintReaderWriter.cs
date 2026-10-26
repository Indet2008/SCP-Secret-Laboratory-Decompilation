using System;
using Hints;
using Mirror;
using UnityEngine;

namespace Utils.Networking
{
	public static class HintReaderWriter
	{
		public enum HintType : byte
		{
			Translation = 0,
			Text = 1
		}

		public static Hint ReadHint(this NetworkReader reader)
		{
			byte b = reader.ReadByte();
			Func<NetworkReader, Hint> func;
			switch ((HintType)b)
			{
			case HintType.Text:
				func = TextHint.FromNetwork;
				break;
			case HintType.Translation:
				func = TranslationHint.FromNetwork;
				break;
			default:
				Debug.LogWarning($"Received malformed hint (type {b}).");
				return null;
			}
			return func(reader);
		}

		public static void WriteHint(this NetworkWriter writer, Hint hint)
		{
			if (hint == null)
			{
				throw new ArgumentNullException("hint");
			}
			HintType value;
			if (!(hint is TranslationHint))
			{
				if (!(hint is TextHint))
				{
					throw new ArgumentException("Hint was of an unknown type. This type should be added to the pattern switch (needed for polymorphism to work).", "hint");
				}
				value = HintType.Text;
			}
			else
			{
				value = HintType.Translation;
			}
			writer.WriteByte((byte)value);
			hint.Serialize(writer);
		}
	}
}
