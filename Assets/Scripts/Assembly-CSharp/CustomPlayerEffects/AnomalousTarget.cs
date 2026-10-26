using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class AnomalousTarget : StatusEffectBase
	{
		private const float ParticleVisibilitySqrDistance = 10000f;

		[SerializeField]
		private GameObject _effectPrefab;

		private GameObject _effectInstance;

		protected override void Enabled()
		{
			base.Enabled();
			_effectInstance = Object.Instantiate(_effectPrefab, base.Hub.transform);
			_effectInstance.SetActive(GetParticleVisibilityState());
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			SpectatorTargetTracker.OnTargetChanged += OnSpectatorChange;
		}

		protected override void Disabled()
		{
			base.Disabled();
			SpectatorTargetTracker.OnTargetChanged -= OnSpectatorChange;
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			Object.Destroy(_effectInstance);
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			bool particleVisibilityState = GetParticleVisibilityState(skipSpectatorCheck: true);
			_effectInstance.SetActive(particleVisibilityState);
		}

		private bool GetParticleVisibilityState(bool skipSpectatorCheck = false)
		{
			if (!base.IsEnabled || base.Hub.isLocalPlayer)
			{
				return false;
			}
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (currentRole.Team == Team.SCPs)
			{
				if (!(currentRole is IFpcRole target))
				{
					return false;
				}
				return target.SqrDistanceTo(base.Hub) <= 10000f;
			}
			if (!(hub.roleManager.CurrentRole is SpectatorRole))
			{
				return false;
			}
			SpectatableModuleBase currentTarget = SpectatorTargetTracker.CurrentTarget;
			if (currentTarget == null)
			{
				return false;
			}
			if (currentTarget.MainRole.Team == Team.SCPs)
			{
				return false;
			}
			return true;
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!(_effectInstance == null))
			{
				_effectInstance.SetActive(GetParticleVisibilityState());
			}
		}

		private void OnSpectatorChange()
		{
			if (!(_effectInstance == null))
			{
				_effectInstance.SetActive(GetParticleVisibilityState());
			}
		}
	}
}
