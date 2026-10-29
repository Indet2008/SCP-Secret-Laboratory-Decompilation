using PlayerRoles.PlayableScps.Scp079.Cameras;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079NicknameGui : Scp079GuiElementBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Camera _cam;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _fullscreenRect;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _template;


		private Scp079CurrentCameraSync _camSync;

		private NicknameGuiDrawer _drawer;

		// Restored from the client build (IL2CPP).
		private void Start()
		{
			_drawer = base.gameObject.AddComponent<NicknameGuiDrawer>();
			_drawer.Init(_cam, _fullscreenRect, _template);
		}

		private void LateUpdate()
		{
			Redraw();
		}

		private void Redraw()
		{
			if (_drawer == null)
			{
				return;
			}
			_drawer.ClearAll();
			if (_camSync == null || !_camSync.TryGetCurrentCamera(out var cam))
			{
				return;
			}
			float zoom = cam.ZoomAxis.CurrentZoom;
			foreach (ReferenceHub hub in ReferenceHub.AllHubs)
			{
				if (hub.IsHuman() && hub.roleManager.CurrentRole is FirstPersonControl.IFpcRole fpcRole)
				{
					_drawer.TryDrawPlayer(fpcRole.FpcModule.CharacterModelInstance, hub.nicknameSync.DisplayName, zoom, cam.CameraPosition);
				}
			}
		}

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _camSync);
		}
	}
}
