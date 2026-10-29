using System.Collections.Generic;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	// Restored from the client build (IL2CPP): SCP-1507 sees enemies within range as colored particle markers.
	public class Scp1507HostileVision : StandardSubroutine<Scp1507Role>
	{
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Color _colorMultiplier;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _postProcess;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.ParticleSystem _particleTemplate;

		[global::UnityEngine.SerializeField]
		private float _visionRange;

		private bool _visionEnabled;

		private readonly Dictionary<IFpcRole, ParticleSystem> _trackers = new Dictionary<IFpcRole, ParticleSystem>();

		protected override void LateUpdate()
		{
			base.LateUpdate();
			bool enable = base.Owner != null && (base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated());
			if (enable)
			{
				UpdateEnabled();
			}
			if (_visionEnabled == enable)
			{
				return;
			}
			_postProcess.SetActive(enable);
			_visionEnabled = enable;
			if (enable)
			{
				SetupAll();
			}
			else
			{
				CleanupAll();
			}
		}

		private void UpdateEnabled()
		{
			Vector3 ownPos = base.CastRole.FpcModule.Position;
			float rangeSqr = _visionRange * _visionRange;
			foreach (ReferenceHub hub in ReferenceHub.AllHubs)
			{
				if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole) || !_trackers.TryGetValue(fpcRole, out var particles) || particles == null)
				{
					continue;
				}
				Vector3 pos = fpcRole.FpcModule.Position;
				ParticleSystem.EmissionModule emission = particles.emission;
				emission.enabled = (pos - ownPos).sqrMagnitude <= rangeSqr;
				particles.transform.position = pos;
			}
		}

		private void SetupAll()
		{
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			ReferenceHub.OnPlayerRemoved += OnPlayerRemoved;
			foreach (ReferenceHub hub in ReferenceHub.AllHubs)
			{
				RegisterRole(hub.roleManager.CurrentRole);
			}
		}

		private void CleanupAll()
		{
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			ReferenceHub.OnPlayerRemoved -= OnPlayerRemoved;
			foreach (ParticleSystem particles in _trackers.Values)
			{
				if (particles != null)
				{
					Object.Destroy(particles.gameObject);
				}
			}
			_trackers.Clear();
		}

		private void RegisterRole(PlayerRoleBase prb)
		{
			if (prb == null || prb.Team == base.CastRole.Team || !(prb is IFpcRole fpcRole))
			{
				return;
			}
			if (!_trackers.TryGetValue(fpcRole, out var particles) || particles == null)
			{
				particles = Object.Instantiate(_particleTemplate);
				_trackers[fpcRole] = particles;
			}
			ParticleSystem.MainModule main = particles.main;
			main.startColor = prb.RoleColor * _colorMultiplier;
			ParticleSystem.EmissionModule emission = particles.emission;
			emission.enabled = true;
		}

		private void UnregisterRole(PlayerRoleBase prb)
		{
			if (prb is IFpcRole fpcRole && _trackers.TryGetValue(fpcRole, out var particles) && particles != null)
			{
				ParticleSystem.EmissionModule emission = particles.emission;
				emission.enabled = false;
			}
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (_visionEnabled)
			{
				UnregisterRole(prevRole);
				RegisterRole(newRole);
			}
		}

		private void OnPlayerRemoved(ReferenceHub user)
		{
			UnregisterRole(user.roleManager.CurrentRole);
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_visionEnabled = false;
			_postProcess.SetActive(false);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (_visionEnabled)
			{
				CleanupAll();
			}
			_visionEnabled = false;
			_postProcess.SetActive(false);
		}
	}
}
