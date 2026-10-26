using InventorySystem.Items.Firearms.Extensions;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class ViewmodelConditionalLayerExtension : MonoBehaviour, IViewmodelExtension
	{
		private Firearm _firearm;

		[SerializeField]
		private ConditionalEvaluator _condition;

		[SerializeField]
		private AnimatorConditionalOverride _layer;

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_firearm = viewmodel.ParentFirearm;
			_condition.InitInstance(_firearm);
		}

		private void LateUpdate()
		{
			_layer.Update(_firearm, _condition.Evaluate());
		}
	}
}
