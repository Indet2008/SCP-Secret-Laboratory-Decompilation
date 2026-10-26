using System;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	[Serializable]
	public struct EmotionPreset
	{
		[Serializable]
		public struct BlendshapeWeightPair
		{
			public EmotionBlendshape Blendshape;

			[Range(0f, 1f)]
			public float Weight;
		}

		public EmotionPresetType PresetType;

		public BlendshapeWeightPair[] Pairs;

		public readonly float GetWeight(EmotionBlendshape blendshape)
		{
			BlendshapeWeightPair[] pairs = Pairs;
			for (int i = 0; i < pairs.Length; i++)
			{
				BlendshapeWeightPair blendshapeWeightPair = pairs[i];
				if (blendshapeWeightPair.Blendshape == blendshape)
				{
					return blendshapeWeightPair.Weight;
				}
			}
			return 0f;
		}

		public readonly void SetWeights(Action<EmotionBlendshape, float> setter)
		{
			BlendshapeWeightPair[] pairs = Pairs;
			for (int i = 0; i < pairs.Length; i++)
			{
				BlendshapeWeightPair blendshapeWeightPair = pairs[i];
				setter(blendshapeWeightPair.Blendshape, blendshapeWeightPair.Weight);
			}
		}
	}
}
