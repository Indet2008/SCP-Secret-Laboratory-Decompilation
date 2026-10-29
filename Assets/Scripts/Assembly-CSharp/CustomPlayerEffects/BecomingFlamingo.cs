using AudioPooling;
using CustomRendering;
using MapGeneration.Holidays;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.PlayableScps.Scp1507;
using PlayerRoles.Spectating;
using RelativePositioning;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class BecomingFlamingo : StatusEffectBase, IHolidayEffect
	{
		private static AudioPoolSession _screamSourceSession;

		[SerializeField]
		private AudioClip _screamClip;

		[SerializeField]
		private AnimationCurve _maxFadeOverTime;

		[SerializeField]
		private float _fogAdjustSpeed;

		[SerializeField]
		private GameObject _particles;

		[SerializeField]
		private GameObject _burstParticles;

		[SerializeField]
		private float _burstFadeThreshold;

		private float _elasped;

		private bool _burstSpawned;

		private RelativePosition _lastPos;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[2]
		{
			HolidayType.Christmas,
			HolidayType.AprilFools
		};

		public static bool HasHeardScream { get; private set; }

		// Other players see the transforming player fade out, then a feather burst where they stood.
		private void SpawnBurst()
		{
			if (WaypointBase.TryGetWaypoint(_lastPos.WaypointId, out var wp) && !base.Hub.isLocalPlayer && !base.Hub.IsLocallySpectated())
			{
				Vector3 worldspacePosition = wp.GetWorldspacePosition(_lastPos.Relative);
				GameObject gameObject = Object.Instantiate(_burstParticles, wp.transform);
				gameObject.transform.SetPositionAndRotation(worldspacePosition, Quaternion.identity);
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (_screamSourceSession.SameSession)
			{
				_screamSourceSession.Source.Stop();
			}
			_screamSourceSession = new AudioPoolSession(AudioSourcePoolManager.Play2D(_screamClip, 1f, (MixerChannel)4));
			HasHeardScream = true;
			_elasped = 0f;
			_burstSpawned = false;
			_lastPos = default(RelativePosition);
			_particles.SetActive(value: true);
			if (base.Hub.isLocalPlayer)
			{
				FogController.EnableFogType(FogType.BecomingFlamingo, _fogAdjustSpeed);
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			_particles.SetActive(value: false);
			if (base.Hub.isLocalPlayer)
			{
				FogController.DisableFogType(FogType.BecomingFlamingo, _fogAdjustSpeed);
			}
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (base.Hub.isLocalPlayer)
			{
				return;
			}
			_elasped += Time.deltaTime;
			float num = _maxFadeOverTime.Evaluate(_elasped);
			if (_burstFadeThreshold > num && !_burstSpawned)
			{
				SpawnBurst();
				_burstSpawned = true;
			}
			if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				_lastPos = new RelativePosition(fpcRole.FpcModule.Position);
				CharacterModel characterModelInstance = fpcRole.FpcModule.CharacterModelInstance;
				if (characterModelInstance != null)
				{
					characterModelInstance.Fade = Mathf.Min(characterModelInstance.Fade, num);
				}
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += delegate
			{
				HasHeardScream = false;
			};
		}

		internal override void OnRoleChanged(PlayerRoleBase previousRole, PlayerRoleBase newRole)
		{
			if (newRole is Scp1507Role)
			{
				base.OnRoleChanged(previousRole, newRole);
			}
		}

		internal override void OnDeath(PlayerRoleBase previousRole)
		{
		}
	}
}
