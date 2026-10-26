using System.Diagnostics;
using GameObjectPools;
using PlayerRoles.PlayableScps.Scp079.Overcons;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Cameras
{
	public class Scp079ForwardCameraSelector : Scp079DirectionalCameraSelector, IPoolResettable
	{
		[SerializeField]
		private float _maxDistance;

		[SerializeField]
		private float _minDot;

		[SerializeField]
		private AnimationCurve _elevatorSwitchDot;

		private bool _switchRequested;

		private Scp079Camera _requestedCamera;

		private float _requestedRotation;

		private readonly Stopwatch _requestTimer = new Stopwatch();

		private const float MinDisSqr = 0.2f;

		private const float RequestTimeout = 4f;

		public static Scp079Camera HighlightedCamera { get; private set; }

		private void OnCameraChanged()
		{
			if (!_switchRequested)
			{
				return;
			}
			_switchRequested = false;
			if (!(base.CurrentCamSync.CurrentCamera != _requestedCamera) && !(_requestTimer.Elapsed.TotalSeconds > 4.0))
			{
				CameraRotationAxis horizontalAxis = _requestedCamera.HorizontalAxis;
				float num = (horizontalAxis.TargetValue + _requestedRotation - horizontalAxis.Pivot.eulerAngles.y) % 360f;
				float minValue = horizontalAxis.MinValue;
				float maxValue = horizontalAxis.MaxValue;
				if (num > maxValue || num < minValue)
				{
					float num2 = Mathf.Abs(Mathf.DeltaAngle(num, minValue));
					float num3 = Mathf.Abs(Mathf.DeltaAngle(num, maxValue));
					num = ((num2 < num3) ? minValue : maxValue);
				}
				horizontalAxis.TargetValue = num;
			}
		}

		protected override bool TryGetCamera(out Scp079Camera targetCamera)
		{
			bool flag = false;
			float num = _minDot;
			targetCamera = null;
			Scp079Camera currentCamera = base.CurrentCamSync.CurrentCamera;
			Vector3 position = MainCameraController.CurrentCamera.position;
			Vector3 forward = MainCameraController.CurrentCamera.forward;
			float num2 = _maxDistance * _maxDistance;
			foreach (CameraOvercon visibleOvercon in CameraOverconRenderer.VisibleOvercons)
			{
				if (visibleOvercon == currentCamera)
				{
					continue;
				}
				Vector3 vector = visibleOvercon.Position - position;
				float sqrMagnitude = vector.sqrMagnitude;
				if (!(sqrMagnitude < 0.2f) && !(sqrMagnitude > num2))
				{
					float num3 = Vector3.Dot(forward, vector / Mathf.Sqrt(sqrMagnitude));
					if (!(num3 < num) && (!visibleOvercon.IsElevator || !(num3 < _elevatorSwitchDot.Evaluate(sqrMagnitude))))
					{
						flag = true;
						num = num3;
						targetCamera = visibleOvercon.Target;
					}
				}
			}
			if (flag || base.TryGetCamera(out targetCamera))
			{
				HighlightedCamera = targetCamera;
				return true;
			}
			HighlightedCamera = null;
			return false;
		}

		protected override void Trigger()
		{
			if (TryGetCamera(out _requestedCamera) && _requestedCamera.Room != base.CurrentCamSync.CurrentCamera.Room)
			{
				Transform obj = _requestedCamera.Room.transform;
				Transform transform = base.CurrentCamSync.CurrentCamera.Room.transform;
				Vector3 to = obj.position - transform.position;
				_requestedRotation = Vector3.SignedAngle(Vector3.forward, to, Vector3.up);
				_switchRequested = true;
				_requestTimer.Restart();
			}
			base.Trigger();
		}

		protected override void Start()
		{
			base.Start();
			base.CurrentCamSync.OnCameraChanged += OnCameraChanged;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_switchRequested = false;
		}
	}
}
