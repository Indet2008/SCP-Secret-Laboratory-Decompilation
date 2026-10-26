using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class WorldmodelConditionalBipolarExtension : MonoBehaviour, IWorldmodelExtension
	{
		[SerializeField]
		private ConditionalEvaluator _conditions;

		[SerializeField]
		private BipolarTransform _bipolar;

		public void SetupWorldmodel(FirearmWorldmodel worldmodel)
		{
			_conditions.InitWorldmodel(worldmodel);
			_bipolar.Polarity = _conditions.Evaluate();
		}
	}
}
