using System;
using MapGeneration;
using Mirror;
using PlayerRoles;
using PlayerRoles.PlayableScps.Scp079;
using UnityEngine;

namespace FacilitySoundtrack
{
	public class SCP079BlackoutSoundtrack : SoundtrackLayerBase
	{
		private const float BlackoutTime = 60f;

		private const float FadeInTime = 10f;

		private const float PlayDelay = 10.25f;

		private const float FadeoutTime = 1f;

		[SerializeField]
		private AudioSource _audioSource;

		[SerializeField]
		private float _fadeInMultipler;

		[SerializeField]
		private float _fadeOutMultipler;

		private float _weight;

		private FacilityZone _blackoutZone;

		private double _blackoutTime;

		public override float Weight => _weight;

		public override bool Additive => false;

		public override bool IsMuteable => true;

		public override void UpdateVolume(float volumeScale)
		{
			if (ReferenceHub.TryGetPovHub(out var hub))
			{
				_audioSource.volume = volumeScale * _weight;
				bool num = hub.IsSCP();
				bool flag = _blackoutTime + 60.0 - 1.0 < NetworkTime.time;
				bool flag2 = _blackoutTime + 10.0 > NetworkTime.time;
				if (num | flag | flag2)
				{
					Fade(increase: false);
				}
				else if (hub.GetCurrentZone() != _blackoutZone)
				{
					Fade(increase: false);
				}
				else
				{
					Fade(increase: true);
				}
			}
		}

		private void Fade(bool increase)
		{
			_weight = Mathf.Lerp(_weight, increase ? 1 : 0, (increase ? _fadeInMultipler : _fadeOutMultipler) * Time.deltaTime);
		}

		private void OnClientZoneBlackout(ReferenceHub scp079Hub, FacilityZone zone)
		{
			_audioSource.PlayDelayed(10.25f);
			_blackoutZone = zone;
			_blackoutTime = NetworkTime.time;
		}

		private void Start()
		{
			Scp079BlackoutZoneAbility.OnClientZoneBlackout = (Action<ReferenceHub, FacilityZone>)Delegate.Combine(Scp079BlackoutZoneAbility.OnClientZoneBlackout, new Action<ReferenceHub, FacilityZone>(OnClientZoneBlackout));
		}

		private void OnDestroy()
		{
			Scp079BlackoutZoneAbility.OnClientZoneBlackout = (Action<ReferenceHub, FacilityZone>)Delegate.Remove(Scp079BlackoutZoneAbility.OnClientZoneBlackout, new Action<ReferenceHub, FacilityZone>(OnClientZoneBlackout));
		}
	}
}
