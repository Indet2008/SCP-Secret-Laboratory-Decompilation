using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson.LayerProcessors
{
	public class DualHandedLayerProcessor : LayerProcessorBase
	{
		private const float ChestEaseout = 0.3f;

		protected override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			return new ThirdpersonLayerWeight(CalculateWeight(base.TargetModel, layer), allowOther: false);
		}

		public static float CalculateWeight(AnimatedCharacterModel model, AnimItemLayer3p layer)
		{
			switch (layer)
			{
			case AnimItemLayer3p.PreMovement:
				return 1f;
			case AnimItemLayer3p.Left:
			case AnimItemLayer3p.Right:
				return 1f;
			case AnimItemLayer3p.Middle:
				return Mathf.Lerp(1f, 0.3f, model.WalkLayerWeight);
			default:
				return 0f;
			}
		}
	}
}
