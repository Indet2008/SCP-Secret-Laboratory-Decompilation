using System;
using System.Collections.Generic;
using UnityEngine;

namespace MapGeneration
{
	public class MapAtlasInterpreter : MonoBehaviour
	{
		private static readonly List<AtlasInterpretation> ResultsBuffer = new List<AtlasInterpretation>();

		public const int GlyphSize = 3;

		[field: SerializeField]
		public GlyphShapePair[] PairDefinitions { get; private set; }

		public static MapAtlasInterpreter Singleton { get; private set; }

		public AtlasInterpretation[] Interpret(Texture2D atlas, System.Random rng)
		{
			ResultsBuffer.Clear();
			if (!atlas.isReadable)
			{
				throw new InvalidOperationException("Provided atlas '" + atlas.name + "' is not marked as readable. Please change the import settings in editor.");
			}
			int num = 1;
			int num2 = 0;
			bool flag = false;
			for (int i = 0; i < atlas.height; i += num)
			{
				for (int j = num2; j < atlas.width; j += num)
				{
					GlyphShapePair? glyphShapePair = ScanPixel(atlas, j, i);
					if (glyphShapePair.HasValue)
					{
						if (!flag)
						{
							Vector2Int glyphCenterOffset = glyphShapePair.Value.GlyphCenterOffset;
							j += glyphCenterOffset.x;
							i += glyphCenterOffset.y;
							num = 3;
							num2 = j % 3;
							flag = true;
						}
						ResultsBuffer.Add(new AtlasInterpretation(glyphShapePair.Value, rng, j, i));
					}
				}
			}
			return ResultsBuffer.ToArray();
		}

		private GlyphShapePair? ScanPixel(Texture2D atlas, int x, int y)
		{
			Color32 color = atlas.GetPixel(x, y);
			GlyphShapePair[] pairDefinitions = PairDefinitions;
			for (int i = 0; i < pairDefinitions.Length; i++)
			{
				GlyphShapePair value = pairDefinitions[i];
				if (Mathf.Abs(value.GlyphColor.r - color.r) <= 5 && Mathf.Abs(value.GlyphColor.g - color.g) <= 5 && Mathf.Abs(value.GlyphColor.b - color.b) <= 5)
				{
					return value;
				}
			}
			return null;
		}

		private void Awake()
		{
			Singleton = this;
		}
	}
}
