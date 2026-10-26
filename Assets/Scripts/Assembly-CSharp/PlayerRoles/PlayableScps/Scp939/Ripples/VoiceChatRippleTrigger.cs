using System.Collections.Generic;
using PlayerRoles.Subroutines;
using PlayerRoles.Voice;
using UnityEngine;
using VoiceChat;
using VoiceChat.Playbacks;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class VoiceChatRippleTrigger : RippleTriggerBase
	{
		private readonly AbilityCooldown _radioCooldown = new AbilityCooldown();

		private readonly Dictionary<HumanRole, AbilityCooldown> _cooldowns = new Dictionary<HumanRole, AbilityCooldown>();

		private readonly Dictionary<HumanRole, float> _prevLoudness = new Dictionary<HumanRole, float>();

		[SerializeField]
		private AnimationCurve _cooldownPerLoudness;

		[SerializeField]
		private float _minLoudness;

		[SerializeField]
		private float _radioCooldownDuration;

		[SerializeField]
		private float _loudnessDecayRate;

		public override void SpawnObject()
		{
			base.SpawnObject();
			_cooldowns.Clear();
			_prevLoudness.Clear();
			_radioCooldown.Clear();
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
		}

		private void Update()
		{
			UpdateSelfReport();
			if (!base.IsLocalOrSpectated)
			{
				return;
			}
			PlayerRolesUtils.ForEachRole<HumanRole>(UpdateHuman);
			if (!_radioCooldown.IsReady)
			{
				return;
			}
			_radioCooldown.Trigger(_radioCooldownDuration);
			foreach (SpatializedRadioPlaybackBase allInstance in SpatializedRadioPlaybackBase.AllInstances)
			{
				if (!allInstance.NoiseSource.mute)
				{
					PlayInRange(allInstance.LastPosition, allInstance.Source.maxDistance, Color.red);
				}
			}
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (newRole is HumanRole key)
			{
				_prevLoudness[key] = 0f;
			}
		}

		private void UpdateHuman(HumanRole human)
		{
			HumanVoiceModule humanVoiceModule = human.VoiceModule as HumanVoiceModule;
			float a = (_prevLoudness.TryGetValue(human, out var value) ? value : 0f);
			a = Mathf.Max(a, humanVoiceModule.FirstProxPlayback.Loudness);
			if (a > _minLoudness)
			{
				AbilityCooldown orAdd = _cooldowns.GetOrAdd(human, () => new AbilityCooldown());
				float maxDistance = humanVoiceModule.FirstProxPlayback.Source.maxDistance;
				Vector3 position = human.FpcModule.Position;
				if (orAdd.IsReady && (base.CastRole.FpcModule.Position - position).sqrMagnitude < maxDistance * maxDistance)
				{
					if (!human.TryGetOwner(out var hub) || CheckVisibility(hub))
					{
						return;
					}
					base.Player.Play(human);
					if (human.TryGetOwner(out var hub2))
					{
						OnPlayedRipple(hub2);
					}
					orAdd.Trigger(_cooldownPerLoudness.Evaluate(a));
				}
			}
			a -= Time.deltaTime * _loudnessDecayRate;
			_prevLoudness[human] = Mathf.Max(0f, a);
		}

		private void UpdateSelfReport()
		{
			if (VoiceChatMicCapture.IsSpeaking && !(VoiceChatMicCapture.Loudness < _minLoudness) && ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is HumanRole { VoiceModule: HumanVoiceModule voiceModule })
			{
				RippleTriggerBase.SelfReport(voiceModule.FirstProxPlayback.Source.maxDistance);
			}
		}
	}
}
