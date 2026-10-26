using UnityEngine;

namespace FacilitySoundtrack
{
	public class WarheadSoundtrack : SoundtrackLayerBase
	{
		private float _curWeight;

		[SerializeField]
		private AnimationCurve _attenuationOverOutput;

		[SerializeField]
		private float _weightAdjustSpeed;

		public override float Weight => _curWeight;

		public override bool Additive => false;

		public override bool IsMuteable => false;

		private float TargetWeight
		{
			get
			{
				if (!AlphaWarheadController.SingletonSet)
				{
					return 0f;
				}
				AlphaWarheadController singleton = AlphaWarheadController.Singleton;
				if (!singleton.Info.InProgress || AlphaWarheadController.Detonated)
				{
					return 0f;
				}
				float currentMusicOutput = singleton.CurScenario.Announcer.CurrentMusicOutput;
				return _attenuationOverOutput.Evaluate(currentMusicOutput);
			}
		}

		public override void UpdateVolume(float volumeScale)
		{
			_curWeight = Mathf.MoveTowards(_curWeight, TargetWeight, Time.deltaTime * _weightAdjustSpeed);
		}
	}
}
