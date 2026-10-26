using PlayerRoles;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.Spectating;
using UnityEngine;

namespace MapGeneration.Holidays
{
	public class Scp079Eyeball : Scp079HolidayCameraBase
	{
		[SerializeField]
		private Material _offMaterial;

		[SerializeField]
		private Material _onMaterial;

		[SerializeField]
		private Renderer _eyeball;

		protected override void OnInitialize()
		{
			base.CameraParent.OnCameraStateChanged += OnCameraStateChanged;
			SpectatorTargetTracker.OnTargetChanged += OnTargetChanged;
		}

		private void OnDestroy()
		{
			base.CameraParent.OnCameraStateChanged -= OnCameraStateChanged;
			SpectatorTargetTracker.OnTargetChanged -= OnTargetChanged;
		}

		private void OnCameraStateChanged(Scp079Camera camera)
		{
			_eyeball.sharedMaterial = (camera.IsActive ? _onMaterial : _offMaterial);
			ReferenceHub hub;
			if (!camera.IsActive)
			{
				_eyeball.enabled = true;
			}
			else if (ReferenceHub.TryGetPovHub(out hub))
			{
				_eyeball.enabled = hub.GetRoleId() != RoleTypeId.Scp079;
			}
		}

		private void OnTargetChanged()
		{
			ReferenceHub hub;
			if (!base.CameraParent.IsActive)
			{
				_eyeball.enabled = true;
			}
			else if (ReferenceHub.TryGetPovHub(out hub))
			{
				_eyeball.enabled = hub.GetRoleId() != RoleTypeId.Scp079;
			}
		}
	}
}
