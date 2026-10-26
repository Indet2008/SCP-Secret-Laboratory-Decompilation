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

		public static readonly char[] ScreenTime = "00:00.00".ToCharArray();

		public static int TextVersion;

		public static float RemainingTimeInMinutes;

		public float ClientTimer;

		public AnimationCurve ScaledTimer;

		[SerializeField]
		private AnimationCurve deviationSpeedup;

		[SerializeField]
		private float _maxDeviation;

		private int _lastTime = -1;

		public float RemainingTimeMinutes => RemainingTimeInMinutes;

		public void UpdateTimer(float serverTime)
		{
			ClientTimer = serverTime;
		}

		private void Update()
		{
			DecontaminationController singleton = DecontaminationController.Singleton;
			if (singleton == null || singleton.DecontaminationPhases == null)
			{
				return;
			}
			float num = 0f;
			DecontaminationController.DecontaminationPhase[] decontaminationPhases = singleton.DecontaminationPhases;
			for (int i = 0; i < decontaminationPhases.Length; i++)
			{
				DecontaminationController.DecontaminationPhase decontaminationPhase = decontaminationPhases[i];
				if (decontaminationPhase.Function == DecontaminationController.DecontaminationPhase.PhaseFunction.Final)
				{
					num = decontaminationPhase.TimeTrigger;
					break;
				}
			}
			float num2;
			if (singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Forced)
			{
				num2 = 0f;
			}
			else if (singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Disabled || singleton.RoundStartTime <= 0.0)
			{
				num2 = num;
			}
			else
			{
				num2 = Mathf.Max(0f, num - (float)DecontaminationController.GetServerTime);
			}
			ClientTimer = num2;
			RemainingTimeInMinutes = num2 / 60f;
			int num3 = Mathf.FloorToInt(num2 * 100f);
			if (num3 != _lastTime)
			{
				_lastTime = num3;
				int num4 = Mathf.FloorToInt(num2 / 60f);
				int value = Mathf.FloorToInt(num2 % 60f);
				int value2 = num3 % 100;
				SetDigits(0, Mathf.Min(num4, 99));
				ScreenTime[2] = ':';
				SetDigits(3, value);
				ScreenTime[5] = '.';
				SetDigits(6, value2);
				TextVersion++;
			}
		}

		internal static void SetDigits(int position, int value)
		{
			value = Mathf.Clamp(value, 0, 99);
			ScreenTime[position] = (char)(48 + value / 10);
			ScreenTime[position + 1] = (char)(48 + value % 10);
		}
	}
}