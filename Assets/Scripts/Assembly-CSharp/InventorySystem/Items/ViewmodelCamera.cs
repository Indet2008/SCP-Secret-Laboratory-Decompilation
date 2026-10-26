using PlayerRoles.Spectating;
using UnityEngine;

namespace InventorySystem.Items
{
	public class ViewmodelCamera : MonoBehaviour
	{
		private bool _resetting;

		private static Camera _viewModelCamera;

		private static bool _camSet;

		private void ResetCam()
		{
			_resetting = true;
		}

		private void Awake()
		{
			_camSet = true;
			_viewModelCamera = GetComponent<Camera>();
			SpectatorTargetTracker.OnTargetChanged += ResetCam;
		}

		private void OnDestroy()
		{
			_camSet = false;
			SpectatorTargetTracker.OnTargetChanged -= ResetCam;
		}

		private void LateUpdate()
		{
			if (TryGetViewmodelFov(out var fov) && !_resetting)
			{
				_viewModelCamera.fieldOfView = fov;
			}
			else
			{
				_resetting = false;
			}
		}

		private bool TryGetViewmodelFov(out float fov)
		{
			fov = _viewModelCamera.fieldOfView;
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			if (!(hub.roleManager.CurrentRole is IViewmodelRole viewmodelRole))
			{
				return false;
			}
			if (!viewmodelRole.TryGetViewmodelFov(out var fov2))
			{
				return false;
			}
			fov = fov2;
			return true;
		}

		public static bool TryGetViewportPoint(Vector3 worldPos, out Vector3 viewport)
		{
			if (!_camSet)
			{
				viewport = Vector3.zero;
				return false;
			}
			viewport = _viewModelCamera.WorldToViewportPoint(worldPos);
			return true;
		}
	}
}
