using AudioPooling;
using Mirror;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;

namespace Audio
{
	public class DamagedAudio : MonoBehaviour
	{
		private const double Cooldown = 0.25;

		private const float MinimumDamage = 2.5f;

		[SerializeField]
		private AudioClip[] _scpAudioClips;

		[SerializeField]
		private AudioClip[] _humanAudioClips;

		private double _lastTime;

		private ReferenceHub _owner;

		private void Start()
		{
			if (ReferenceHub.TryGetHub(base.gameObject, out _owner))
			{
				_owner.playerStats.GetModule<HealthStat>().OnStatChange += OnHealthStatChange;
				_owner.playerStats.GetModule<AhpStat>().OnStatChange += OnHealthStatChange;
				_owner.playerStats.GetModule<HumeShieldStat>().OnStatChange += OnHumeStatChange;
			}
		}

		private void OnDestroy()
		{
			if (!(_owner == null))
			{
				_owner.playerStats.GetModule<HealthStat>().OnStatChange -= OnHealthStatChange;
				_owner.playerStats.GetModule<AhpStat>().OnStatChange -= OnHealthStatChange;
				_owner.playerStats.GetModule<HumeShieldStat>().OnStatChange -= OnHumeStatChange;
			}
		}

		private void OnHumeStatChange(float oldValue, float newValue)
		{
			PlayAudio(oldValue - newValue, isHume: true);
		}

		private void OnHealthStatChange(float oldValue, float newValue)
		{
			PlayAudio(oldValue - newValue, isHume: false);
		}

		private void PlayAudio(float damage, bool isHume)
		{
			if ((_owner.isLocalPlayer || _owner.IsLocallySpectated()) && !(damage <= 2.5f) && !(_lastTime > NetworkTime.time))
			{
				_lastTime = NetworkTime.time + 0.25;
				AudioSourcePoolManager.Play2DWithParent(isHume ? _scpAudioClips.RandomItem() : _humanAudioClips.RandomItem(), _owner.transform);
			}
		}
	}
}
