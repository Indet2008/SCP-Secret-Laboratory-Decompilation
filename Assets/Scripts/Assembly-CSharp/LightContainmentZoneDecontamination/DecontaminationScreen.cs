using TMPro;
using UnityEngine;

namespace LightContainmentZoneDecontamination
{
	public class DecontaminationScreen : MonoBehaviour
	{
		public Animator AnimationController;

		public TextMeshPro CountdownText;

		public bool InsideLCZ;

		private int _lastVersion = -1;

		private static readonly int TimeLeftHash = Animator.StringToHash("TimeLeft");

		private static readonly int TimeSinceRoundStartHash = Animator.StringToHash("TimeSinceRoundStart");

		private static readonly int InsideLczHash = Animator.StringToHash("InsideLCZ");

		private void Update()
		{
			UpdateAnimator();
			if (!(CountdownText == null) && _lastVersion != DecontaminationClientTimer.TextVersion)
			{
				_lastVersion = DecontaminationClientTimer.TextVersion;
				CountdownText.SetText(DecontaminationClientTimer.ScreenTime);
			}
		}

		// Drives the ScreenElements controller: NotEnabled -> Warming up -> Regular -> Countdown -> Zero.
		private void UpdateAnimator()
		{
			if (AnimationController == null || !AnimationController.isActiveAndEnabled || AnimationController.runtimeAnimatorController == null)
			{
				return;
			}
			DecontaminationController singleton = DecontaminationController.Singleton;
			bool flag = singleton != null && singleton.RoundStartTime > 0.0 && singleton.DecontaminationOverride != DecontaminationController.DecontaminationStatus.Disabled;
			float value = 0f;
			float value2 = 0f;
			if (flag)
			{
				// Kept just above 0 so NotEnabled can still advance, but below the Zero threshold (0.001).
				value = ((singleton.DecontaminationOverride == DecontaminationController.DecontaminationStatus.Forced) ? 0.0005f : Mathf.Max(DecontaminationClientTimer.RemainingTimeInMinutes, 0.0005f));
				value2 = (float)DecontaminationController.GetServerTime / 60f;
			}
			AnimationController.SetFloat(TimeLeftHash, value);
			AnimationController.SetFloat(TimeSinceRoundStartHash, value2);
			AnimationController.SetBool(InsideLczHash, InsideLCZ);
		}
	}
}