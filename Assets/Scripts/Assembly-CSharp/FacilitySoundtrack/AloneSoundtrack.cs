using PlayerRoles;
using PlayerRoles.PlayableScps;
using UnityEngine;

namespace FacilitySoundtrack
{
	public class AloneSoundtrack : SoundtrackLayerBase
	{
		private const float AloneTime = 120f;

		private const float SCPBufferTime = 30f;

		private const float MaxVisionDistance = 60f;

		private const float CharacterRadius = 0.25f;

		[SerializeField]
		private float _fadeInSpeed;

		[SerializeField]
		private float _fadeOutSpeed;

		[SerializeField]
		private float _maxVolume;

		[SerializeField]
		private AudioSource _aloneSource;

		private float _weight;

		private float _aloneTime;

		private float _oldAloneTime;

		private bool _hasFoundSCP;

		public override bool Additive => false;

		public override float Weight => _weight;

		public override bool IsMuteable => true;

		public override void UpdateVolume(float masterScale)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && (!hub.IsHuman() || hub.GetRoleId() == RoleTypeId.Tutorial))
			{
				_weight = 0f;
				SetVolume(_weight);
				return;
			}
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.isLocalPlayer || !allHub.IsAlive() || allHub.GetRoleId() == RoleTypeId.Tutorial)
				{
					continue;
				}
				flag3 |= HitboxIdentity.IsEnemy(hub, allHub);
				if (VisionInformation.GetVisionInformation(hub, hub.PlayerCameraReference, allHub.PlayerCameraReference.position, 0.25f, 60f).IsLooking)
				{
					if (!allHub.IsSCP())
					{
						flag = true;
						break;
					}
					flag2 = true;
				}
			}
			if (!flag && _hasFoundSCP != flag2)
			{
				_hasFoundSCP = flag2;
				if (_oldAloneTime != 0f)
				{
					_aloneTime = ((90f < _aloneTime) ? 90f : _oldAloneTime);
				}
				_oldAloneTime = (flag2 ? _aloneTime : 0f);
			}
			_aloneTime = (flag ? 0f : (_aloneTime + Time.deltaTime));
			float num = (((!base.IsPovMuted && _oldAloneTime == 0f && _aloneTime > 120f) & flag3) ? _fadeInSpeed : (0f - _fadeOutSpeed));
			_weight = Mathf.Clamp01(_weight + num * Time.deltaTime);
			SetVolume(_weight * masterScale * _maxVolume);
		}

		private void SetVolume(float volume)
		{
			_aloneSource.volume = volume;
		}

		private void Start()
		{
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		private void OnDestroy()
		{
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (userHub.isLocalPlayer && newRole.Team != Team.Dead)
			{
				_weight = 0f;
				_aloneTime = 0f;
				_oldAloneTime = 0f;
				_hasFoundSCP = false;
			}
		}
	}
}
