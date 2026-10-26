using System;
using PlayerRoles.PlayableScps.Scp079.GUI;
using UnityEngine;
using UserSettings.ControlsSettings;

namespace PlayerRoles.PlayableScps.Scp079.Cameras
{
	[Serializable]
	public class CameraRotationAxis : CameraAxisBase
	{
		[SerializeField]
		private Transform _pivot;

		[SerializeField]
		private bool _isVertical;

		private const string HorizontalAxis = "Mouse X";

		private const string VerticalAxis = "Mouse Y";

		private const float OverallSensMultiplier = 2f;

		private const float MoveSpeed = 150f;

		private const float BeginMovePercent = 0.93f;

		private const float FullSpeedPercent = 0.98f;

		private const int EdgeThreshold = 2;

		public Transform Pivot => _pivot;

		private float MouseInput => Input.GetAxisRaw(_isVertical ? "Mouse Y" : "Mouse X") * 2f * SensitivitySettings.SensMultiplier;

		protected override float SpectatorLerpMultiplier => 7.5f;

		internal override void Update(Scp079Camera cam)
		{
			base.Update(cam);
			if (!cam.IsActive || !cam.IsUsedByLocalPlayer || Scp079CursorManager.LockCameras)
			{
				return;
			}
			if (!Cursor.visible)
			{
				float num = MouseInput;
				if (_isVertical && !SensitivitySettings.Invert)
				{
					num *= -1f;
				}
				num /= Mathf.LerpUnclamped(1f, cam.ZoomAxis.CurrentZoom, SensitivitySettings.AdsReductionMultiplier);
				base.TargetValue += num;
				return;
			}
			float num2;
			float num3;
			if (_isVertical)
			{
				num2 = Screen.height;
				num3 = num2 - Input.mousePosition.y;
			}
			else
			{
				num3 = Input.mousePosition.x;
				num2 = Screen.width;
			}
			float num4 = num2 / 2f;
			float num5 = ((num3 < num4) ? (-1f) : 1f);
			float value = Mathf.Abs((num3 - num4) / num4);
			float num6 = num4 - Mathf.Abs(num3 - num4);
			float num7 = 150f * Time.deltaTime;
			num7 *= Mathf.InverseLerp(0.93f, 0.98f, value);
			if (num6 <= 2f)
			{
				float num8 = MouseInput * num5;
				if (_isVertical)
				{
					num8 *= -1f;
				}
				num7 += Mathf.Max(num8, 0f);
			}
			base.TargetValue += num7 * num5;
		}

		protected override void OnValueChanged(float newValue, Scp079Camera cam)
		{
			float num = (Scp079Role.LocalInstanceActive ? base.TargetValue : newValue);
			_pivot.localRotation = (_isVertical ? Quaternion.Euler(num, 0f, 0f) : Quaternion.Euler(0f, num, 0f));
		}

		internal override void Awake(Scp079Camera cam)
		{
			base.Awake(cam);
			Vector3 eulerAngles = _pivot.localRotation.eulerAngles;
			float num;
			for (num = (_isVertical ? eulerAngles.x : eulerAngles.y); num < base.MinValue; num += 360f)
			{
			}
			while (num > base.MaxValue)
			{
				num -= 360f;
			}
			base.TargetValue = num;
		}
	}
}
