using System.Diagnostics;
using Interactables.Interobjects;
using UnityEngine;

namespace CameraShaking
{
	public class ElevatorShake : IShakeEffect
	{
		private const float ShakeSpeed = 75f;

		private const float ShakeAngle = 0.12f;

		private const float PulsePrimarySpeed = 9f;

		private const float PulseSecondarySpeed = 3f;

		private static readonly Stopwatch RealTime = Stopwatch.StartNew();

		private static readonly Stopwatch LastMovement = new Stopwatch();

		private static readonly AnimationCurve FadeCurve = new AnimationCurve(new Keyframe(0f, 1f, -0.1f, -0.1f, 0f, 0.5f), new Keyframe(0.5f, 0f, 0f, 0f, 0.2f, 0f));

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ReferenceHub.OnPlayerAdded += OnPlayerAdded;
			ElevatorChamber.OnElevatorMoved += OnElevatorMoved;
		}

		private static void OnPlayerAdded(ReferenceHub hub)
		{
			if (hub.isLocalPlayer)
			{
				CameraShakeController.AddEffect(new ElevatorShake());
			}
		}

		private static void OnElevatorMoved(Bounds elevatorBounds, ElevatorChamber chamber, Vector3 deltaPos, Quaternion deltaRot)
		{
			if (elevatorBounds.Contains(MainCameraController.CurrentCamera.position))
			{
				LastMovement.Restart();
			}
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			float num = (LastMovement.IsRunning ? FadeCurve.Evaluate((float)LastMovement.Elapsed.TotalSeconds) : 0f);
			if (Mathf.Approximately(num, 0f))
			{
				RealTime.Restart();
				shakeValues = ShakeEffectValues.None;
			}
			else
			{
				float num2 = (float)RealTime.Elapsed.TotalSeconds;
				float num3 = Mathf.Sin(num2 * 9f);
				float num4 = Mathf.Sin(num2 * 3f);
				float num5 = Mathf.Sin(num2 * 75f) * 0.12f;
				shakeValues = new ShakeEffectValues(Quaternion.Euler(num3 * num4 * num * num5 * Vector3.up));
			}
			return true;
		}
	}
}
