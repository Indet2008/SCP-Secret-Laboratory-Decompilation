using Mirror;
using UnityEngine;

namespace LightContainmentZoneDecontamination
{
	public class DecontaminationClientTimer : MonoBehaviour
	{
		private const int DigitSeparation = 18;

		internal const int MinutePosition = 0;

		internal const int SecondPosition = 53;

		internal const int MillisecondPosition = 105;

		public const int BaseDecontaminationTime = 952;

		// Rich-text template; SetDigits writes the tens digit at a position and the units digit 18 characters later.
		public static readonly char[] ScreenTime = "A<size=20> </size>B<size=1> </size>:<size=10> </size>C<size=20> </size>D<size=1> </size>.<size=1> </size>E<size=20> </size>F".ToCharArray();

		public static int TextVersion;

		public static float RemainingTimeInMinutes;

		public float ClientTimer;

		public AnimationCurve ScaledTimer;

		[SerializeField]
		private AnimationCurve deviationSpeedup;

		[SerializeField]
		private float _maxDeviation;

		private int _lastTime = -1;

		// Original: the screens show ScaledTimer(elapsed seconds) in minutes; a negative time offset
		// (decontamination delayed) counts down linearly from BaseDecontaminationTime until under 15 minutes.
		public float RemainingTimeMinutes
		{
			get
			{
				DecontaminationController singleton = DecontaminationController.Singleton;
				if (singleton.RoundStartTime <= 0.0)
				{
					return (float)singleton.RoundStartTime;
				}
				if (!(0f > singleton.TimeOffset))
				{
					return ScaledTimer.Evaluate(ClientTimer);
				}
				float num = (Mathf.Abs(singleton.TimeOffset) + (float)BaseDecontaminationTime - (float)(NetworkTime.time - singleton.RoundStartTime)) / 60f;
				if (15f > num)
				{
					return ScaledTimer.Evaluate(ClientTimer);
				}
				return num;
			}
		}

		public void UpdateTimer(float serverTime)
		{
			float num = serverTime - ClientTimer;
			if (Mathf.Abs(num) < 0.001f)
			{
				return;
			}
			if (Mathf.Abs(num) > _maxDeviation)
			{
				ClientTimer = serverTime;
				return;
			}
			ClientTimer += Time.deltaTime * deviationSpeedup.Evaluate(num);
		}

		private void Update()
		{
			DecontaminationController singleton = DecontaminationController.Singleton;
			if (singleton == null || singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Disabled)
			{
				return;
			}
			double roundStartTime = singleton.RoundStartTime;
			if (roundStartTime > 0.0)
			{
				// The original controller feeds the server time in (inlined there); done here to keep it in one place.
				UpdateTimer((float)DecontaminationController.GetServerTime);
			}
			float remainingTimeMinutes = RemainingTimeMinutes;
			if (singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Forced)
			{
				return;
			}
			RemainingTimeInMinutes = remainingTimeMinutes;
			int num = (int)(remainingTimeMinutes * 6000f);
			if (num == _lastTime)
			{
				return;
			}
			_lastTime = num;
			if (num < 1 && roundStartTime > 0.0)
			{
				base.enabled = false;
			}
			int num2 = num / 6000;
			num -= num2 * 6000;
			int num3 = num / 100;
			num -= num3 * 100;
			SetDigits(MinutePosition, num2);
			SetDigits(SecondPosition, num3);
			SetDigits(MillisecondPosition, num);
			TextVersion++;
		}

		internal static void SetDigits(int position, int value)
		{
			ScreenTime[position] = (char)(48 + value / 10);
			ScreenTime[position + DigitSeparation] = (char)(48 + value % 10);
		}
	}
}
