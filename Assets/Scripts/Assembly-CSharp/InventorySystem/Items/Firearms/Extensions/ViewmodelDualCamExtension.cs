using System.Collections.Generic;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

namespace InventorySystem.Items.Firearms.Extensions
{
	[PresetPrefabExtension("Sniper Scope Screen Viewmodel", false)]
	[PresetPrefabExtension("NV Scope Screen Viewmodel", false)]
	public class ViewmodelDualCamExtension : MonoBehaviour, IViewmodelExtension
	{
		private static readonly Dictionary<Material, Material> MaterialInstances = new Dictionary<Material, Material>();

		private static readonly int RenderTexHash = Shader.PropertyToID("_RenderTex");

		private static readonly int AdsHash = Shader.PropertyToID("_Ads");

		[SerializeField]
		private Renderer _targetRenderer;

		[SerializeField]
		private GameObject _cameraSetupRoot;

		[SerializeField]
		private float _zoomAmount = 1f;

		[SerializeField]
		private Transform _topPointTr;

		[SerializeField]
		private Transform _bottomPointTr;

		private Camera _fovCamera;

		private Firearm _firearm;

		private Material _matInstance;

		private Transform _cameraTr;

		public bool TryGetVerticalScreenOccupation(out float verticalScreenOccupation)
		{
			verticalScreenOccupation = 0f;
			if (!ViewmodelCamera.TryGetViewportPoint(_topPointTr.position, out var viewport))
			{
				return false;
			}
			if (!ViewmodelCamera.TryGetViewportPoint(_bottomPointTr.position, out var viewport2))
			{
				return false;
			}
			verticalScreenOccupation = (viewport - viewport2).MagnitudeOnlyY();
			return true;
		}

		public virtual void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_fovCamera = _cameraSetupRoot.GetComponent<Camera>();
			_cameraTr = _cameraSetupRoot.transform;
			_firearm = viewmodel.ParentFirearm;
			Material sharedMat = _targetRenderer.sharedMaterial;
			_matInstance = MaterialInstances.GetOrAdd(sharedMat, () => new Material(sharedMat));
			_matInstance.SetTexture(RenderTexHash, _fovCamera.targetTexture);
			_targetRenderer.sharedMaterial = _matInstance;
			// The scope camera is re-enabled every time the player aims, which restarts HDRP's automatic exposure from
			// scratch: the zoomed view stayed black for several seconds before adapting. Render it without exposure control.
			if (_cameraSetupRoot.TryGetComponent<HDAdditionalCameraData>(out var cameraData))
			{
				cameraData.customRenderingSettings = true;
				cameraData.renderingPathCustomFrameSettingsOverrideMask.mask[(uint)FrameSettingsField.ExposureControl] = true;
				cameraData.renderingPathCustomFrameSettings.SetEnabled(FrameSettingsField.ExposureControl, false);
			}
		}

		protected virtual void LateUpdate()
		{
			if (_firearm.TryGetModule<IAdsModule>(out var module) && TryGetVerticalScreenOccupation(out var verticalScreenOccupation))
			{
				float adsAmount = module.AdsAmount;
				_matInstance.SetFloat(AdsHash, adsAmount);
				_cameraSetupRoot.SetActive(adsAmount > 0f);
				Transform currentCamera = MainCameraController.CurrentCamera;
				_cameraTr.SetPositionAndRotation(currentCamera.position, currentCamera.rotation);
				float num = _zoomAmount / verticalScreenOccupation;
				float fieldOfView = 70f / num;
				_fovCamera.fieldOfView = fieldOfView;
			}
		}
	}
}
