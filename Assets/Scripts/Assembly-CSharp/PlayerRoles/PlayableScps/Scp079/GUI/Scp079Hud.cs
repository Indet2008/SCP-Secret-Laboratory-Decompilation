using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.Map;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	// Restored from the client build (IL2CPP). Init hands the role to every GUI element (they all read it every frame),
	// and Update drives camera zoom, the map/HUD switch and the death screen.
	public class Scp079Hud : ScpHudBase
	{
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Camera _mainCamera;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.HighDefinition.CustomPassVolume _hudCustomPass;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject[] _aliveObjects;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.Volume _deathVolume;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Gradient _deathBarsColor;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage _deathBars;

		[global::UnityEngine.SerializeField]
		private float _deathAnimSpeed;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.Scp079.GUI.Scp079NoiseController _noiseController;

		private float _defaultFov;

		private Scp079CurrentCameraSync _curCamSync;

		private Scp079MapToggler _mapToggler;

		private int _defaultLayerMask;

		public static Camera MainCamera { get; private set; }

		public static Scp079Role Instance { get; private set; }

		private Transform SceneCamera
		{
			get
			{
				return MainCameraController.CurrentCamera;
			}
			set
			{
				MainCameraController.CurrentCamera = value;
			}
		}

		private void Awake()
		{
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			if (SceneCamera == transform)
			{
				SceneCamera = null;
			}
		}

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			SceneCamera = transform;
			MainCamera = _mainCamera;
			_defaultLayerMask = MainCamera.cullingMask;
			Instance = hub.roleManager.CurrentRole as Scp079Role;
			Instance.SubroutineModule.TryGetSubroutine(out _curCamSync);
			Instance.SubroutineModule.TryGetSubroutine(out _mapToggler);
			_defaultFov = _mainCamera.fieldOfView;
			Scp079GuiElementBase[] elements = GetComponentsInChildren<Scp079GuiElementBase>(includeInactive: true);
			for (int i = 0; i < elements.Length; i++)
			{
				elements[i].Init(Instance, hub);
			}
			if (!HideHUDController.IsHUDVisible)
			{
				ToggleHud(b: false);
			}
		}

		internal override void OnDied()
		{
			_deathVolume.enabled = true;
		}

		protected override void Update()
		{
			base.Update();
			if (_mapToggler != null)
			{
				// While the map fully covers the screen there is nothing to render behind it.
				bool mapCovers = Scp079ToggleMenuAbilityBase<Scp079MapToggler>.IsOpen && _mapToggler.IsReady;
				_mainCamera.cullingMask = mapCovers ? 0 : _defaultLayerMask;
				_hudCustomPass.enabled = !Scp079ToggleMenuAbilityBase<Scp079MapToggler>.Visible;
			}
			if (!_deathVolume.enabled)
			{
				if (_curCamSync != null && _curCamSync.TryGetCurrentCamera(out var cam))
				{
					_mainCamera.fieldOfView = 1f / cam.ZoomAxis.CurrentZoom * _defaultFov;
				}
				return;
			}
			float weight = Mathf.Clamp01(_deathVolume.weight + Time.deltaTime * _deathAnimSpeed);
			_deathVolume.weight = weight;
			_deathBars.color = _deathBarsColor.Evaluate(weight);
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (userHub != Hub)
			{
				return;
			}
			foreach (GameObject aliveObject in _aliveObjects)
			{
				aliveObject.SetActive(newRole is Scp079Role);
			}
		}
	}
}
