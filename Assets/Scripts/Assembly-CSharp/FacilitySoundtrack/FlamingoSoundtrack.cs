using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp1507;
using UnityEngine;

namespace FacilitySoundtrack
{
	public class FlamingoSoundtrack : SoundtrackLayerBase
	{
		[SerializeField]
		private float _fadeInWeightSpeed;

		[SerializeField]
		private float _fadeOutWeightSpeed;

		[SerializeField]
		private float _fadePresenceSpeed;

		[SerializeField]
		private AudioSource _ambient;

		[SerializeField]
		private AnimationCurve _volumeOverElapsed;

		[SerializeField]
		private float _minSustainTime;

		[SerializeField]
		private float _omnipresentDuration;

		[SerializeField]
		private float _flamingoRangeSqr;

		private float _weight;

		private float _elapsed;

		private float _separationTimer;

		private const float LateJoinSkipTime = 60f;

		private const float AwayVolume = 0.01f;

		public override float Weight => _weight;

		public override bool Additive => false;

		public override bool IsMuteable => true;

		private void Update()
		{
			FindFlamingos(out var anyFlamingosExist, out var anyFlamingosInRange);
			if (!anyFlamingosExist)
			{
				_weight = Mathf.MoveTowards(_weight, 0f, _fadeOutWeightSpeed * Time.deltaTime);
				return;
			}
			if (anyFlamingosInRange || _elapsed < _omnipresentDuration)
			{
				_separationTimer = 0f;
			}
			else
			{
				_separationTimer += Time.deltaTime;
			}
			float target = ((_separationTimer < _minSustainTime) ? 1f : 0.01f);
			_weight = Mathf.MoveTowards(_weight, target, _fadePresenceSpeed * Time.deltaTime);
		}

		private void FindFlamingos(out bool anyFlamingosExist, out bool anyFlamingosInRange)
		{
			anyFlamingosExist = false;
			anyFlamingosInRange = false;
			Vector3? vector = ((ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IFpcRole fpcRole) ? new Vector3?(fpcRole.FpcModule.Position) : ((Vector3?)null));
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is Scp1507Role { Team: Team.Flamingos } scp1507Role)
				{
					anyFlamingosExist = true;
					if (!vector.HasValue)
					{
						break;
					}
					if (!((scp1507Role.FpcModule.Position - vector.Value).sqrMagnitude > _flamingoRangeSqr))
					{
						anyFlamingosInRange = true;
						break;
					}
				}
			}
		}

		public override void UpdateVolume(float volumeScale)
		{
			bool flag = volumeScale <= 0f;
			if (_ambient.isPlaying)
			{
				if (flag)
				{
					_ambient.Stop();
				}
				_elapsed += Time.deltaTime;
			}
			else
			{
				if (flag)
				{
					return;
				}
				_ambient.Play();
			}
			_ambient.volume = volumeScale * _volumeOverElapsed.Evaluate(_elapsed);
		}
	}
}
