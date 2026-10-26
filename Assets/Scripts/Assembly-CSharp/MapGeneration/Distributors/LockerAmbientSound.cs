using System.Diagnostics;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class LockerAmbientSound : MonoBehaviour
	{
		[SerializeField]
		private AudioSource _closedAmbientSource;

		[SerializeField]
		private AudioSource _openAmbinetSource;

		[SerializeField]
		private AnimationCurve _crossfadeOverTime;

		private LockerChamber _chamber;

		private float _crossfadeDuration;

		private readonly Stopwatch _animSw = Stopwatch.StartNew();

		private void Awake()
		{
			_chamber = GetComponent<LockerChamber>();
			_chamber.OnDoorStatusSet += UpdateStatus;
			_crossfadeDuration = _crossfadeOverTime.GetDuration();
			UpdateStatus();
		}

		private void UpdateStatus()
		{
			base.enabled = true;
			_animSw.Restart();
		}

		private void Update()
		{
			float num = (float)_animSw.Elapsed.TotalSeconds;
			float time = (_chamber.IsOpen ? num : (_crossfadeDuration - num));
			float num2 = Mathf.Clamp01(_crossfadeOverTime.Evaluate(time));
			_openAmbinetSource.volume = num2;
			_closedAmbientSource.volume = 1f - num2;
			if (num > _crossfadeDuration)
			{
				base.enabled = false;
			}
		}
	}
}
