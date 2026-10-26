using CursorManagement;
using PlayerRoles.PlayableScps.Scp079.Cameras;
using PlayerRoles.PlayableScps.Scp079.Map;
using UnityEngine;
using UserSettings;
using UserSettings.ControlsSettings;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079CursorManager : Scp079GuiElementBase, ICursorOverride
	{
		[SerializeField]
		private GameObject _freeLookCursor;

		private Scp079CurrentCameraSync _curCamSync;

		private Scp079LostSignalHandler _lostSignalHandler;

		private static readonly ToggleOrHoldInput FreeLookMode = new ToggleOrHoldInput(ActionName.Scp079FreeLook, new CachedUserSetting<bool>(MiscControlsSetting.Scp079MouseLookToggle));

		public static CursorOverrideMode CurrentMode { get; private set; }

		public static bool LockCameras { get; private set; }

		public CursorOverrideMode CursorOverride => CurrentMode;

		public bool LockMovement => LockCameras;

		private void Update()
		{
			if (_lostSignalHandler.Lost || Scp079IntroCutscene.IsPlaying)
			{
				LockCameras = true;
				CurrentMode = CursorOverrideMode.Free;
				return;
			}
			CurrentMode = (FreeLookMode.IsActive ? CursorOverrideMode.Centered : CursorOverrideMode.Confined);
			LockCameras = false;
			if (_curCamSync.CurClientSwitchState != Scp079CurrentCameraSync.ClientSwitchState.None || Scp079ToggleMenuAbilityBase<Scp079MapToggler>.IsOpen)
			{
				LockCameras = true;
				CurrentMode = ((!Scp079ToggleMenuAbilityBase<Scp079ScannerMenuToggler>.IsOpen) ? CursorOverrideMode.Centered : CursorOverrideMode.Free);
			}
			if (Cursor.lockState == CursorLockMode.None || !Application.isFocused)
			{
				LockCameras = true;
			}
		}

		internal override void Init(Scp079Role role, ReferenceHub owner)
		{
			base.Init(role, owner);
			if (owner.isLocalPlayer)
			{
				CursorManager.Register(this);
			}
			role.SubroutineModule.TryGetSubroutine<Scp079CurrentCameraSync>(out _curCamSync);
			role.SubroutineModule.TryGetSubroutine<Scp079LostSignalHandler>(out _lostSignalHandler);
		}

		private void OnDestroy()
		{
			CursorManager.Unregister(this);
		}
	}
}
