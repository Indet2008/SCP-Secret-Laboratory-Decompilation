using InventorySystem.Items.Thirdperson.LayerProcessors;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson
{
	public class IdleThirdpersonItem : ThirdpersonItemBase, IHandPoseModifier
	{
		private bool _hasProcessor;

		[SerializeField]
		private AnimationClip _idleOverride;

		[SerializeField]
		private HandPoseData _handPoseData;

		[SerializeField]
		private LayerProcessorBase _layerProcessor;

		[Tooltip("Not used when layer processor is set.")]
		[SerializeField]
		private AnimItemLayer3p[] _fallbackLayers;

		public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			if (_hasProcessor)
			{
				return _layerProcessor.GetWeightForLayer(this, layer);
			}
			return new ThirdpersonLayerWeight(_fallbackLayers.Contains(layer) ? 1 : 0);
		}

		public virtual HandPoseData ProcessHandPose(HandPoseData data)
		{
			return _handPoseData;
		}

		internal override void Initialize(InventorySubcontroller sctrl, ItemIdentifier id)
		{
			base.Initialize(sctrl, id);
			_hasProcessor = _layerProcessor != null;
			SetAnim(AnimState3p.Override0, _idleOverride);
		}

		protected bool TryGetLayerProcessor<T>(out T processor) where T : LayerProcessorBase
		{
			if (_layerProcessor is T val)
			{
				processor = val;
				return true;
			}
			processor = null;
			return false;
		}
	}
}
