using PlayerRoles.Ragdolls;
using PlayerRoles.Spectating;
using UnityEngine;

namespace DeathAnimations
{
	public abstract class DeathAnimation : MonoBehaviour
	{
		public bool IsPlaying { get; private set; }

		public BasicRagdoll TargetRagdoll { get; private set; }

		protected bool IsLocalPlayer
		{
			get
			{
				if (!ReferenceHub.TryGetLocalHub(out var hub))
				{
					return false;
				}
				ReferenceHub ownerHub = TargetRagdoll.Info.OwnerHub;
				if (ownerHub == null || hub == null)
				{
					return false;
				}
				return ownerHub == hub;
			}
		}

		protected bool IsBeingSpectated
		{
			get
			{
				if (!ReferenceHub.TryGetLocalHub(out var hub) || !(hub.roleManager.CurrentRole is SpectatorRole))
				{
					return false;
				}
				ReferenceHub ownerHub = TargetRagdoll.Info.OwnerHub;
				ReferenceHub lastTrackedPlayer = SpectatorTargetTracker.LastTrackedPlayer;
				if (lastTrackedPlayer == null || ownerHub == null)
				{
					return false;
				}
				return lastTrackedPlayer == ownerHub;
			}
		}

		public void StartDeathAnimation(BasicRagdoll ragdollReference)
		{
			IsPlaying = true;
			TargetRagdoll = ragdollReference;
			OnAnimationStarted();
		}

		public void KillDeathAnimation()
		{
			if (IsPlaying)
			{
				IsPlaying = false;
				OnAnimationEnded();
			}
		}

		protected virtual void OnAnimationStarted()
		{
		}

		protected virtual void OnAnimationEnded()
		{
		}
	}
}
