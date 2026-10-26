using System;
using CursorManagement;
using InventorySystem.Items;
using Mirror;
using NetworkManagerUtils.Dummies;
using RelativePositioning;
using UnityEngine;
using UserSettings.ControlsSettings;

namespace PlayerRoles.FirstPersonControl
{
	public class FpcMouseLook : IDummyActionProvider
	{
		private static FpcMouseLook _localInstance;

		public const float MinimumVer = -88f;

		public const float MaximumVer = 88f;

		public const float OverallMultiplier = 2f;

		private const float FullAngle = 360f;

		private const float SmoothTime = 10f;

		private const float ThirdpersonSmooth = 22f;

		private readonly ReferenceHub _hub;

		private readonly FirstPersonMovementModule _fpmm;

		private float _curHorizontal;

		private float _curVertical;

		private float _syncHorizontal;

		private float _syncVertical;

		private float _inputHorizontal;

		private float _inputVertical;

		private ushort _prevSyncH;

		private ushort _prevSyncV;

		protected virtual float BiaxialSensitivity
		{
			get
			{
				float num = SensitivitySettings.SensMultiplier * 2f;
				if (_hub.inventory.CurInstance is IZoomModifyingItem zoomModifyingItem && zoomModifyingItem != null)
				{
					num *= zoomModifyingItem.SensitivityScale;
				}
				return num;
			}
		}

		public float CurrentHorizontal
		{
			get
			{
				return _curHorizontal;
			}
			set
			{
				_inputHorizontal = (_curHorizontal = ClampHorizontal(value));
			}
		}

		public float CurrentVertical
		{
			get
			{
				return _curVertical;
			}
			set
			{
				_inputVertical = (_curVertical = ClampVertical(value));
			}
		}

		private Quaternion TargetHubRotation => Quaternion.Euler(Vector3.up * _curHorizontal);

		private Quaternion TargetCamRotation => Quaternion.Euler(Vector3.left * _curVertical);

		public FpcMouseLook(ReferenceHub hub, FirstPersonMovementModule fpmm)
		{
			_hub = hub;
			_fpmm = fpmm;
			CurrentHorizontal = hub.transform.eulerAngles.y;
			CurrentVertical = 0f;
			if (hub.isLocalPlayer)
			{
				_localInstance = this;
			}
		}

		public static bool TryGetLocalMouseLook(out FpcMouseLook ml)
		{
			ml = _localInstance;
			return ml != null;
		}

		public void UpdateRotation()
		{
			Quaternion rotation;
			Quaternion localRotation;
			if (_hub.isLocalPlayer)
			{
				GetMouseInput(out var hRot, out var vRot);
				if (Cursor.visible || CursorManager.MovementLocked)
				{
					hRot = 0f;
					vRot = 0f;
				}
				_inputVertical = ClampVertical(_inputVertical + vRot);
				_inputHorizontal = ClampHorizontal(_inputHorizontal + hRot);
				float t = (SensitivitySettings.SmoothInput ? (10f * Time.deltaTime) : 1f);
				_curVertical = ClampVertical(Mathf.LerpAngle(_curVertical, _inputVertical, t));
				_curHorizontal = ClampHorizontal(Mathf.LerpAngle(_curHorizontal, _inputHorizontal, t));
				rotation = TargetHubRotation;
				localRotation = TargetCamRotation;
			}
			else
			{
				if (!NetworkServer.active || !_hub.IsDummy)
				{
					CurrentHorizontal = WaypointBase.GetWorldRotation(_fpmm.Motor.ReceivedPosition.WaypointId, Quaternion.Euler(Vector3.up * _syncHorizontal)).eulerAngles.y;
					CurrentVertical = _syncVertical;
				}
				float t2 = (NetworkServer.active ? 1f : (22f * Time.deltaTime));
				rotation = Quaternion.Lerp(_hub.transform.rotation, TargetHubRotation, t2);
				localRotation = Quaternion.Lerp(_hub.PlayerCameraReference.localRotation, TargetCamRotation, t2);
			}
			_hub.transform.rotation = rotation;
			_hub.PlayerCameraReference.localRotation = localRotation;
		}

		public void GetMouseInput(out float hRot, out float vRot)
		{
			hRot = Input.GetAxisRaw("Mouse X");
			vRot = Input.GetAxisRaw("Mouse Y");
			float biaxialSensitivity = BiaxialSensitivity;
			hRot = ProcessHorizontalInput(hRot * biaxialSensitivity);
			vRot = ProcessVerticalInput(vRot * biaxialSensitivity);
		}

		public void ApplySyncValues(ushort horizontal, ushort vertical)
		{
			if (_prevSyncH == horizontal && _prevSyncV == vertical)
			{
				_fpmm.Motor.RotationDetected = false;
				return;
			}
			_prevSyncH = horizontal;
			_prevSyncV = vertical;
			_syncHorizontal = Mathf.Lerp(0f, 360f, (float)(int)horizontal / 65535f);
			_syncVertical = Mathf.Lerp(-88f, 88f, (float)(int)vertical / 65535f);
			if (_hub.isLocalPlayer)
			{
				CurrentHorizontal = _syncHorizontal;
				CurrentVertical = _syncVertical;
			}
			_fpmm.Motor.RotationDetected = true;
		}

		public void GetSyncValues(byte waypointId, out ushort syncH, out ushort syncV)
		{
			syncH = (ushort)Mathf.RoundToInt(Mathf.InverseLerp(0f, 360f, WaypointBase.GetRelativeRotation(waypointId, Quaternion.Euler(Vector3.up * CurrentHorizontal)).eulerAngles.y) * 65535f);
			syncV = (ushort)Mathf.RoundToInt(Mathf.InverseLerp(-88f, 88f, CurrentVertical) * 65535f);
		}

		protected virtual float ClampHorizontal(float f)
		{
			while (f < 0f)
			{
				f += 360f;
			}
			while (f > 360f)
			{
				f -= 360f;
			}
			return f;
		}

		protected virtual float ClampVertical(float f)
		{
			return Mathf.Clamp(f, -88f, 88f);
		}

		protected virtual float ProcessVerticalInput(float f)
		{
			if (!SensitivitySettings.Invert)
			{
				return f;
			}
			return 0f - f;
		}

		protected virtual float ProcessHorizontalInput(float f)
		{
			return f;
		}

		public void PopulateDummyActions(Action<DummyAction> actionAdder)
		{
			int[] array = new int[4] { 1, 10, 45, 180 };
			foreach (int i2 in array)
			{
				actionAdder(new DummyAction(string.Format("{0}-{1}", "CurrentHorizontal", i2), () =>
				{
					CurrentHorizontal -= (float)i2;
				}));
				actionAdder(new DummyAction(string.Format("{0}+{1}", "CurrentHorizontal", i2), () =>
				{
					CurrentHorizontal += (float)i2;
				}));
				actionAdder(new DummyAction(string.Format("{0}-{1}", "CurrentVertical", i2), () =>
				{
					CurrentVertical -= (float)i2;
				}));
				actionAdder(new DummyAction(string.Format("{0}+{1}", "CurrentVertical", i2), () =>
				{
					CurrentVertical += (float)i2;
				}));
			}
		}
	}
}
