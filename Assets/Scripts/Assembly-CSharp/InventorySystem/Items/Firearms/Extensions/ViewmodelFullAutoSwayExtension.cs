using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ViewmodelFullAutoSwayExtension : MonoBehaviour, IViewmodelExtension
	{
		private const float TriggerIncreaseWeightSpeed = 10f;

		private const float TriggerDecreaseWeightSpeed = 5f;

		private const float RecentlyFiredIncreaseWeightSpeed = 10f;

		private const float RecentlyFiredDecreaseWeightSpeed = 1.5f;

		private const float LoadedIncreaseWeightSpeed = 1.5f;

		private const float LoadedDecreaseWeightSpeed = 5f;

		private const float DefaultAdsMuliplier = 0.1f;

		private const float DefaultHipMuliplier = 1f;

		private SubsequentShotsCounter _shotsCounter;

		private AnimatedFirearmViewmodel _viewmodel;

		private Firearm _firearm;

		[SerializeField]
		private AnimatorLayerMask _recoilLayers;

		[SerializeField]
		private float _adsMultiplier = 0.1f;

		[SerializeField]
		private float _hipMultiplier = 1f;

		private AnimatorStateInfo[] _statesByLayer;

		private float _elapsed;

		private float _weightTrigger;

		private float _weightRecentlyFired;

		private float _weightLoaded;

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_firearm = viewmodel.ParentFirearm;
			_viewmodel = viewmodel;
			_statesByLayer = new AnimatorStateInfo[_recoilLayers.Layers.Length];
			_shotsCounter = new SubsequentShotsCounter(_firearm);
			for (int i = 0; i < _statesByLayer.Length; i++)
			{
				int layer = _recoilLayers.Layers[i];
				_statesByLayer[i] = viewmodel.AnimatorStateInfo(layer);
			}
		}

		private void LateUpdate()
		{
			_shotsCounter.Update();
			bool targetIncrease = _firearm.TryGetModule<ITriggerControllerModule>(out var module) && module.TriggerHeld;
			UpdateWeight(ref _weightTrigger, targetIncrease, 10f, 5f);
			bool targetIncrease2 = _shotsCounter.SubsequentShots > 0;
			UpdateWeight(ref _weightRecentlyFired, targetIncrease2, 10f, 1.5f);
			bool targetIncrease3 = IDisplayableAmmoProviderModule.GetCombinedDisplayAmmo(_firearm).Total > 0;
			UpdateWeight(ref _weightLoaded, targetIncrease3, 1.5f, 5f);
			float num = _weightTrigger * _weightLoaded * _weightRecentlyFired;
			if (num > 0f)
			{
				_elapsed += num * Time.deltaTime;
			}
			else
			{
				_elapsed = 0f;
			}
			float t = (_firearm.TryGetModule<IAdsModule>(out var module2) ? module2.AdsAmount : 0f);
			float weight = num * Mathf.Lerp(1f, _adsMultiplier, t);
			for (int i = 0; i < _statesByLayer.Length; i++)
			{
				UpdateLayer(_recoilLayers.Layers[i], _statesByLayer[i], weight);
			}
		}

		private void UpdateWeight(ref float weight, bool targetIncrease, float increaseSpeed, float decreaseSpeed)
		{
			float target = (targetIncrease ? 1 : 0);
			float num = (targetIncrease ? increaseSpeed : decreaseSpeed);
			weight = Mathf.MoveTowards(weight, target, num * Time.deltaTime);
		}

		private void UpdateLayer(int layerId, AnimatorStateInfo state, float weight)
		{
			float time = _elapsed / state.length;
			_viewmodel.AnimatorPlay(state.shortNameHash, layerId, time);
			_viewmodel.AnimatorSetLayerWeight(layerId, weight);
		}
	}
}
