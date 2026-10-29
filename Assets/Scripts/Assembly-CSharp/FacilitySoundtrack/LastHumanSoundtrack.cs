using PlayerRoles;
using PlayerRoles.PlayableScps.HumanTracker;
using PlayerRoles.Spectating;
using UnityEngine;

namespace FacilitySoundtrack
{
	public class LastHumanSoundtrack : SoundtrackLayerBase
	{
		private const float MaxVolume = 0.25f;

		private const float ActiveTrackWeight = 0.125f;

		[SerializeField]
		private float _fadeInSpeed;

		[SerializeField]
		private float _fadeOutSpeed;

		[SerializeField]
		private AudioSource _audioSource;

		private float _weight;

		public override bool Additive => false;

		public override float Weight => _weight;

		public override bool IsMuteable => false;

		private float CurFadeAdjustSpeed => (LastHumanTracker.IsLocalLastTarget ? _fadeInSpeed : _fadeOutSpeed) * Time.deltaTime;

		public override void UpdateVolume(float volumeScale)
		{
			float target = (LastHumanTracker.IsLocalLastTarget ? 0.25f : 0f) * _weight * volumeScale;
			float curFadeAdjustSpeed = CurFadeAdjustSpeed;
			_audioSource.volume = Mathf.MoveTowards(_audioSource.volume, target, curFadeAdjustSpeed);
		}

		private void Awake()
		{
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			SpectatorTargetTracker.OnTargetChanged += OnTargetChanged;
		}

		private void OnTargetChanged()
		{
			float curFadeAdjustSpeed = CurFadeAdjustSpeed;
			_weight = (LastHumanTracker.IsLocalLastTarget ? 0.125f : 0f);
			float target = (LastHumanTracker.IsLocalLastTarget ? 0.25f : 0f) * _weight;
			_audioSource.volume = Mathf.MoveTowards(_audioSource.volume, target, curFadeAdjustSpeed);
		}

		private void OnDestroy()
		{
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			SpectatorTargetTracker.OnTargetChanged -= OnTargetChanged;
		}

		private void Update()
		{
			float curFadeAdjustSpeed = CurFadeAdjustSpeed;
			bool isLocalLastTarget = LastHumanTracker.IsLocalLastTarget;
			_weight = Mathf.MoveTowards(_weight, isLocalLastTarget ? 1 : 0, curFadeAdjustSpeed);
			float target = _weight * (isLocalLastTarget ? 0.25f : 0f);
			_audioSource.volume = Mathf.MoveTowards(_audioSource.volume, target, curFadeAdjustSpeed);
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (userHub.isLocalPlayer)
			{
				_weight = 0f;
				_audioSource.volume = 0f;
			}
		}
	}
}
