using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public class EmotionRenderer : MonoBehaviour
	{
		private SkinnedMeshRenderer _rend;

		private int?[] _blendshapeToIndex;

		[field: SerializeField]
		public EmotionBlendshape[] Blendshapes { get; private set; }

		private void Awake()
		{
			_rend = GetComponent<SkinnedMeshRenderer>();
			_blendshapeToIndex = new int?[EnumUtils<EmotionBlendshape>.Values.Length];
			for (int i = 0; i < Blendshapes.Length; i++)
			{
				_blendshapeToIndex[(int)Blendshapes[i]] = i;
			}
		}

		public float GetWeight(EmotionBlendshape blendshape)
		{
			int? num = _blendshapeToIndex[(int)blendshape];
			if (!num.HasValue)
			{
				return 0f;
			}
			return _rend.GetBlendShapeWeight(num.Value) * 100f;
		}

		public void SetWeight(EmotionBlendshape blendshape, float weight)
		{
			int? num = _blendshapeToIndex[(int)blendshape];
			if (num.HasValue)
			{
				_rend.SetBlendShapeWeight(num.Value, weight * 100f);
			}
		}

		public void ResetWeights()
		{
			EmotionBlendshape[] blendshapes = Blendshapes;
			foreach (EmotionBlendshape blendshape in blendshapes)
			{
				SetWeight(blendshape, 0f);
			}
		}
	}
}
