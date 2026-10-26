using GameObjectPools;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public class EmotionSubcontroller : SubcontrollerBehaviour, IPoolResettable
	{
		public const EmotionPresetType FallbackPreset = EmotionPresetType.Neutral;

		private int _rendCnt;

		[field: SerializeField]
		public EmotionRenderer[] Renderers { get; private set; }

		[field: SerializeField]
		public EmotionPreset[] Presets { get; private set; }

		public override void Init(AnimatedCharacterModel model, int index)
		{
			base.Init(model, index);
			_rendCnt = Renderers.Length;
		}

		public override void OnReassigned()
		{
			base.OnReassigned();
			SetPreset(EmotionSync.GetEmotionPreset(base.OwnerHub));
		}

		public void ResetObject()
		{
			ResetWeights();
		}

		public void SetPreset(EmotionPresetType presetType)
		{
			ResetWeights();
			EmotionPreset? emotionPreset = null;
			EmotionPreset[] presets = Presets;
			for (int i = 0; i < presets.Length; i++)
			{
				EmotionPreset value = presets[i];
				if (value.PresetType != presetType)
				{
					if (value.PresetType == EmotionPresetType.Neutral)
					{
						emotionPreset = value;
					}
					continue;
				}
				value.SetWeights(SetWeight);
				return;
			}
			if (!emotionPreset.HasValue)
			{
				Debug.LogError($"Model {base.Model.name} does not have a {EmotionPresetType.Neutral} expression set, which is a required fallback.", base.Model);
			}
			else
			{
				emotionPreset.Value.SetWeights(SetWeight);
			}
		}

		private void ResetWeights()
		{
			for (int i = 0; i < _rendCnt; i++)
			{
				Renderers[i].ResetWeights();
			}
		}

		private void SetWeight(EmotionBlendshape blendshape, float weight)
		{
			for (int i = 0; i < _rendCnt; i++)
			{
				Renderers[i].SetWeight(blendshape, weight);
			}
		}
	}
}
