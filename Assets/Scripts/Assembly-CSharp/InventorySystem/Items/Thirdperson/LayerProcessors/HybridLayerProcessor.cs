using UnityEngine;

namespace InventorySystem.Items.Thirdperson.LayerProcessors
{
	public class HybridLayerProcessor : LayerProcessorBase
	{
		private float _blend;

		public void SetDualHandBlend(float blendAmount)
		{
			_blend = Mathf.Clamp01(blendAmount);
		}

		protected override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			if (_blend <= 0f)
			{
				return ZeroBlendWeight(layer);
			}
			if (_blend >= 1f)
			{
				return FullBlendWeight(layer);
			}
			ThirdpersonLayerWeight lhs = ZeroBlendWeight(layer);
			ThirdpersonLayerWeight rhs = FullBlendWeight(layer);
			return ThirdpersonLayerWeight.Lerp(lhs, rhs, _blend);
		}

		private ThirdpersonLayerWeight ZeroBlendWeight(AnimItemLayer3p layer)
		{
			return new ThirdpersonLayerWeight(RightHandedLayerProcessor.CalculateWeight(base.TargetModel, layer), layer != AnimItemLayer3p.Right);
		}

		private ThirdpersonLayerWeight FullBlendWeight(AnimItemLayer3p layer)
		{
			return new ThirdpersonLayerWeight(DualHandedLayerProcessor.CalculateWeight(base.TargetModel, layer), allowOther: false);
		}
	}
}
