using Interactables;
using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	[PresetPrefabExtension("Laser Viewmodel", false)]
	public class ViewmodelLaserExtension : MonoBehaviour, IViewmodelExtension, IDestroyExtensionReceiver
	{
		private Light _lightSource;

		private Transform _selfTr;

		private Transform _viewmodelTr;

		private Firearm _firearm;

		private BarrelTipExtension _barrelTip;

		private Color _laserColor;

		private Vector3 _localPos;

		private bool _hasBarrelTip;

		private float _distanceFromWall;

		private float _unlockBlend;

		private const float MinDistanceFromWall = 0.2f;

		private const float MaxDistanceFromWall = 15f;

		private const float AdsMultiplier = 2.5f;

		private const float UnlockSpeed = 5f;

		private const float AngularSnapMin = 2.8f;

		private const float AngularSnapMax = 20f;

		private float ClientAds
		{
			get
			{
				if (!_firearm.TryGetModule<IAdsModule>(out var module))
				{
					return 0f;
				}
				return module.AdsAmount;
			}
		}

		private Vector3 BarrelForward
		{
			get
			{
				if (!_hasBarrelTip)
				{
					return _selfTr.parent.forward;
				}
				return _barrelTip.WorldspaceDirection;
			}
		}

		private bool WantsToUnlock
		{
			get
			{
				ModuleBase[] modules = _firearm.Modules;
				foreach (ModuleBase moduleBase in modules)
				{
					if (moduleBase is IInspectorModule { DisplayInspecting: not false })
					{
						return true;
					}
					if (moduleBase is IBusyIndicatorModule { IsBusy: not false } busyIndicatorModule && !(busyIndicatorModule is IActionModule))
					{
						return true;
					}
				}
				return false;
			}
		}

		private void LateUpdate()
		{
			_unlockBlend = Mathf.MoveTowards(_unlockBlend, WantsToUnlock ? 1 : 0, Time.deltaTime * 5f);
			_selfTr.localPosition = _localPos;
			Vector3 forward = _viewmodelTr.forward;
			Vector3 barrelForward = BarrelForward;
			Vector3 position = _selfTr.position;
			float num = Vector3.Angle(forward, barrelForward);
			float num2 = Mathf.Clamp01(1f - ClientAds * 2.5f);
			float num3 = Mathf.InverseLerp(2.8f, 20f, num * num2);
			float t = Mathf.SmoothStep(0f, 1f, num3 + _unlockBlend);
			float z = _viewmodelTr.InverseTransformPoint(position).z;
			z = Mathf.Min(z, _distanceFromWall - 0.2f);
			Vector3 position2 = new Vector3(0f, 0f, z);
			Vector3 a = _viewmodelTr.TransformPoint(position2);
			_selfTr.forward = Vector3.Slerp(forward, barrelForward, t);
			_selfTr.position = Vector3.Lerp(a, position, t);
			_lightSource.color = _laserColor * num2;
		}

		private void OnCenterRaycastMissed()
		{
			_distanceFromWall = 15f;
		}

		private void OnCenterRaycastHit(RaycastHit hit)
		{
			_distanceFromWall = hit.distance;
		}

		public void InitViewmodel(AnimatedFirearmViewmodel viewmodel)
		{
			_firearm = viewmodel.ParentFirearm;
			_viewmodelTr = viewmodel.transform;
			_lightSource = GetComponent<Light>();
			_laserColor = _lightSource.color;
			_selfTr = base.transform;
			_localPos = _selfTr.localPosition;
			_hasBarrelTip = viewmodel.TryGetExtension<BarrelTipExtension>(out _barrelTip);
			CenterScreenRaycast.OnCenterRaycastHit += OnCenterRaycastHit;
			CenterScreenRaycast.OnCenterRaycastMissed += OnCenterRaycastMissed;
		}

		public void OnDestroyExtension()
		{
			CenterScreenRaycast.OnCenterRaycastHit -= OnCenterRaycastHit;
			CenterScreenRaycast.OnCenterRaycastMissed -= OnCenterRaycastMissed;
		}
	}
}
