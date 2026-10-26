using System.Collections.Generic;
using MapGeneration.Spawnables;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class AudioLogRippleTrigger : RippleTriggerBase
	{
		private readonly Dictionary<AudioLog, float> _cooldowns = new Dictionary<AudioLog, float>();

		public float CooldownPerLog = 1.5f;

		public float RangeMultiplier = 1.35f;

		public override void ResetObject()
		{
			base.ResetObject();
			_cooldowns.Clear();
		}

		private void Update()
		{
			if (!base.IsLocalOrSpectated)
			{
				return;
			}
			foreach (AudioLog instance in AudioLog.Instances)
			{
				if (CanTriggerRipple(instance))
				{
					float maxRange = instance.MaxHearingRange * RangeMultiplier;
					PlayInRange(instance.PlayingLocation, maxRange, Color.red);
					_cooldowns[instance] = Time.time + CooldownPerLog;
				}
			}
		}

		private bool CanTriggerRipple(AudioLog audioLog)
		{
			if (!audioLog.IsPlaying)
			{
				return false;
			}
			if (!_cooldowns.TryGetValue(audioLog, out var value))
			{
				return true;
			}
			return value <= Time.time;
		}
	}
}
