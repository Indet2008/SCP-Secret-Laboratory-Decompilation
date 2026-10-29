using System;
using CursorManagement;
using PlayerRoles.FirstPersonControl;
using TMPro;
using UnityEngine;

namespace PlayerRoles.Filmmaker
{
	public class FilmmakerFly : MonoBehaviour, ICursorOverride
	{
		[Serializable]
		private struct PrecisionMode
		{
			public string Name;

			public float MovementSpeed;

			public float ZoomSize;

			public float RollAmount;
		}

		[SerializeField]
		private PrecisionMode[] _precisionModes;

		[SerializeField]
		private TMP_Text _userInfo;

		[SerializeField]
		private float _minZoom;

		[SerializeField]
		private KeyCode _keyFly;

		[SerializeField]
		private KeyCode _keyChangePrecMode;

		[SerializeField]
		private KeyCode _keyRollLeft;

		[SerializeField]
		private KeyCode _keyRollRight;

		private static KeyCode _keyFwd;

		private static KeyCode _keyBwd;

		private static KeyCode _keyRgt;

		private static KeyCode _keyLft;

		private static KeyCode _keyUpw;

		private static KeyCode _keyDnw;

		private static FpcMouseLook _mLook;

		private static FilmmakerRole _role;

		private static int _curPrecisionMode;

		public static bool IsFlying { get; private set; }

		public CursorOverrideMode CursorOverride => CursorOverrideMode.NoOverride;

		public bool LockMovement => false;

		private bool WantsToFly => Input.GetKey(_keyFly);

		private void Start()
		{
			CursorManager.Register(this);
			_role = ReferenceHub.LocalHub.roleManager.CurrentRole as FilmmakerRole;
			_keyFwd = NewInput.GetKey(ActionName.MoveForward);
			_keyBwd = NewInput.GetKey(ActionName.MoveBackward);
			_keyLft = NewInput.GetKey(ActionName.MoveLeft);
			_keyRgt = NewInput.GetKey(ActionName.MoveRight);
			_keyUpw = NewInput.GetKey(ActionName.Jump);
			_keyDnw = NewInput.GetKey(ActionName.Sneak);
			_mLook = new FpcMouseLook(ReferenceHub.LocalHub, null);
		}

		private void OnDestroy()
		{
			CursorManager.Unregister(this);
		}

		private void Update()
		{
			if (!WantsToFly || Cursor.visible)
			{
				_userInfo.text = string.Empty;
				IsFlying = false;
				return;
			}
			if (HideHUDController.IsHUDVisible && Input.GetKeyDown(_keyChangePrecMode))
			{
				_curPrecisionMode++;
			}
			PrecisionMode precisionMode = _precisionModes[_curPrecisionMode % _precisionModes.Length];
			UpdateMovement(precisionMode.MovementSpeed);
			UpdateRotation(precisionMode.RollAmount);
			UpdateZoom(precisionMode.ZoomSize);
			Vector3 eulerAngles = Quaternion.Euler(_role.VerticalRotation, _role.HorizontalRotation, _role.RollRotation).eulerAngles;
			_userInfo.text = string.Format("Precision mode: {0}\nPosition: {1}\nRotation: {2}\nZoom: {3}", precisionMode.Name, _role.CameraPosition, eulerAngles, FilmmakerRole.ZoomScale);
			IsFlying = true;
		}

		private void UpdateMovement(float movementSpeed)
		{
			Transform currentCamera = MainCameraController.CurrentCamera;
			Vector3 zero = Vector3.zero;
			if (Input.GetKey(_keyFwd))
			{
				zero += currentCamera.forward;
			}
			if (Input.GetKey(_keyBwd))
			{
				zero -= currentCamera.forward;
			}
			if (Input.GetKey(_keyRgt))
			{
				zero += currentCamera.right;
			}
			if (Input.GetKey(_keyLft))
			{
				zero -= currentCamera.right;
			}
			if (Input.GetKey(_keyUpw))
			{
				zero += currentCamera.up;
			}
			if (Input.GetKey(_keyDnw))
			{
				zero -= currentCamera.up;
			}
			_role.CameraPosition += movementSpeed * Time.deltaTime * zero;
		}

		private void UpdateRotation(float rollStep)
		{
			_mLook.GetMouseInput(out var hRot, out var vRot);
			_role.HorizontalRotation += hRot;
			_role.VerticalRotation -= vRot;
			if (Input.GetKeyDown(_keyRollLeft))
			{
				_role.RollRotation += rollStep;
			}
			if (Input.GetKeyDown(_keyRollRight))
			{
				_role.RollRotation -= rollStep;
			}
		}

		private void UpdateZoom(float step)
		{
			float axisRaw = Input.GetAxisRaw("Mouse ScrollWheel");
			if (axisRaw != 0f)
			{
				FilmmakerRole.ZoomScale = Mathf.Max(_minZoom, FilmmakerRole.ZoomScale + Mathf.Sign(axisRaw) * step);
			}
		}
	}
}
