using PlayerRoles;
using PlayerRoles.Spectating;

namespace DeathAnimations
{
	public abstract class FirstpersonDeathAnimation : DeathAnimation
	{
		private bool _eventAssigned;

		protected bool IsFirstperson
		{
			get
			{
				if (!base.IsLocalPlayer)
				{
					return base.IsBeingSpectated;
				}
				return true;
			}
		}

		private bool EventAssigned
		{
			set
			{
				if (_eventAssigned != value)
				{
					if (value)
					{
						PlayerRoleManager.OnRoleChanged += OnRoleChanged;
						SpectatorTargetTracker.OnTargetChanged += OnTargetChanged;
					}
					else
					{
						PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
						SpectatorTargetTracker.OnTargetChanged -= OnTargetChanged;
					}
					_eventAssigned = value;
				}
			}
		}

		protected override void OnAnimationStarted()
		{
			if (IsFirstperson)
			{
				EventAssigned = true;
			}
		}

		protected override void OnAnimationEnded()
		{
			EventAssigned = false;
		}

		protected virtual void OnDestroy()
		{
			EventAssigned = false;
		}

		private void OnTargetChanged()
		{
			if (!SpectatorTargetTracker.TrackerSet || !(SpectatorTargetTracker.CurrentTarget == null))
			{
				KillDeathAnimation();
			}
		}

		private void OnRoleChanged(ReferenceHub hub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (hub.isLocalPlayer && newRole.Team != Team.Dead)
			{
				KillDeathAnimation();
			}
		}
	}
}
