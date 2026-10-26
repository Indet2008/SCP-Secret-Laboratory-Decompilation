using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson.LayerProcessors
{
	public abstract class LayerProcessorBase : MonoBehaviour
	{
		private bool _alreadyInit;

		protected ThirdpersonItemBase Source { get; private set; }

		public AnimatedCharacterModel TargetModel => Source.TargetModel;

		protected Animator Animator => TargetModel.Animator;

		protected ReferenceHub OwnerHub => TargetModel.OwnerHub;

		public ThirdpersonLayerWeight GetWeightForLayer(ThirdpersonItemBase source, AnimItemLayer3p layer)
		{
			if (!_alreadyInit)
			{
				Init(source);
				_alreadyInit = true;
			}
			return GetWeightForLayer(layer);
		}

		protected virtual void Init(ThirdpersonItemBase source)
		{
			Source = source;
		}

		protected abstract ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer);
	}
}
