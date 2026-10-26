using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules.Misc;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class ViewmodelRecoilLayerScalerExtension : MonoBehaviour, IViewmodelExtension
	{
		private Firearm _fa;

		private AnimatedViewmodelBase _viewmodel;

		private float _lastShotBonus;

		private SubsequentShotsCounter _shotsCounter;

		[SerializeField]
		private AnimatorLayerMask _recoilLayers;

		[SerializeField]
		private float _postShotReturnSpeed;

		[SerializeField]
		private AnimationCurve _weightOverScale;

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_viewmodel = viewmodel;
			_fa = viewmodel.ParentFirearm;
			_shotsCounter = new SubsequentShotsCounter(_fa, 0f, 0f, 0f);
			_shotsCounter.OnShotRecorded += () =>
			{
				_lastShotBonus = _shotsCounter.SubsequentShots;
			};
		}

		private void Update()
		{
			float num = _fa.AttachmentsValue(AttachmentParam.OverallRecoilMultiplier);
			_lastShotBonus = Mathf.MoveTowards(_lastShotBonus, 1f, Time.deltaTime * _postShotReturnSpeed);
			float num2 = _weightOverScale.Evaluate(_lastShotBonus * num);
			_recoilLayers.SetWeight(_viewmodel.AnimatorSetLayerWeight, num2);
			int[] layers = _recoilLayers.Layers;
			foreach (int layer in layers)
			{
				_viewmodel.AnimatorSetLayerWeight(layer, num2);
			}
			_shotsCounter.Update();
		}
	}
}
