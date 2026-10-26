using System.Globalization;
using System.Text;
using UnityEngine;

namespace Cassie
{
	public static class CassieGlitchifier
	{
		private static readonly StringBuilder Sb = new StringBuilder();

		public static string Glitchify(string original, float intensityScale)
		{
			if (intensityScale <= 0f)
			{
				return original;
			}
			float glitchChance = Random.Range(0.1f, 0.14f) * intensityScale;
			float stutterChance = Random.Range(0.07f, 0.09f) * intensityScale;
			return Glitchify(original, glitchChance, stutterChance);
		}

		public static string Glitchify(string original, float glitchChance, float stutterChance)
		{
			if (glitchChance <= 0f)
			{
				return original;
			}
			if (stutterChance <= 0f)
			{
				return original;
			}
			Sb.Clear();
			string[] array = original.Split(' ');
			for (int i = 0; i < array.Length; i++)
			{
				Sb.Append(array[i]);
				Sb.Append(' ');
				if (i < array.Length - 1)
				{
					if (Random.value < glitchChance)
					{
						Sb.Append(".G");
						Sb.Append(Random.Range(1, 7));
						Sb.Append(' ');
					}
					if (Random.value < stutterChance)
					{
						Sb.Append("$STUTTER_");
						Sb.Append((Random.value * 0.7f).ToString(CultureInfo.InvariantCulture));
						Sb.Append("_0.13_");
						Sb.Append(Random.Range(2, 6));
						Sb.Append(' ');
					}
				}
			}
			return Sb.ToString();
		}
	}
}
