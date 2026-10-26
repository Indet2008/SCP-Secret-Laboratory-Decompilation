using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson.LayerProcessors
{
	public class RightHandedLayerProcessor : LayerProcessorBase
	{
		private const float HandEaseout = 0.75f;

		protected override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			return new ThirdpersonLayerWeight(CalculateWeight(base.TargetModel, layer), allowOther: false);
		}

		public static float CalculateWeight(AnimatedCharacterModel model, AnimItemLayer3p layer)
		{
			return layer switch
			{
				AnimItemLayer3p.PreMovement => 1f, 
				AnimItemLayer3p.Right => Mathf.Lerp(1f, 0.75f, model.WalkLayerWeight), 
				AnimItemLayer3p.Middle => 1f - model.WalkLayerWeight, 
				_ => 0f, 
			};
		}
	}
}
