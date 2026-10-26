using CameraShaking;
using GameObjectPools;
using UnityEngine;

namespace PlayerRoles.Filmmaker
{
	public class FilmmakerRole : PlayerRoleBase, IShakeEffect, IAdvancedCameraController, ICameraController, IPoolResettable, ICustomNameRole
	{
		[SerializeField]
		private GameObject _filmmakerTools;

		private GameObject _toolsInstance;

		public override RoleTypeId RoleTypeId => RoleTypeId.Filmmaker;

		public override Team Team => Team.Dead;

		public override Color RoleColor => new Color(0.05f, 0.05f, 0.05f, 1f);

		public Vector3 CameraPosition { get; set; }

		public Quaternion CameraRotation
		{
			get
			{
				return Quaternion.Euler(VerticalRotation, HorizontalRotation, RollRotation);
			}
			set
			{
				Vector3 eulerAngles = value.eulerAngles;
				VerticalRotation = eulerAngles.x;
				HorizontalRotation = eulerAngles.y;
				RollRotation = eulerAngles.z;
			}
		}

		public float VerticalRotation { get; set; }

		public float HorizontalRotation { get; set; }

		public float RollRotation { get; set; }

		public static float ZoomScale { get; set; }

		public string CustomRoleName => "Film Maker";

		private void OnDestroy()
		{
			ResetObject();
		}

		internal override void Init(ReferenceHub hub, RoleChangeReason spawnReason, RoleSpawnFlags spawnFlags)
		{
			base.Init(hub, spawnReason, spawnFlags);
			if (hub.isLocalPlayer)
			{
				Transform currentCamera = MainCameraController.CurrentCamera;
				CameraPosition = currentCamera.position;
				CameraRotation = currentCamera.rotation;
				ZoomScale = 1f;
				CameraShakeController.AddEffect(this);
				_toolsInstance = Object.Instantiate(_filmmakerTools);
			}
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			float fovPercent = 1f / ZoomScale;
			shakeValues = new ShakeEffectValues(null, null, null, fovPercent);
			return base.IsLocalPlayer;
		}

		public void ResetObject()
		{
			if (!(_toolsInstance == null))
			{
				Object.Destroy(_toolsInstance);
			}
		}
	}
}
