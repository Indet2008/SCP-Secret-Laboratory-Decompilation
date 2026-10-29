using PlayerRoles.Spectating;
using UnityEngine;

namespace DeathAnimations
{
	public class RagdollHead : FirstpersonDeathAnimation
	{
		public float CameraFixSpeed = 0.075f;

		public GameObject SpectatorCameraAnchor;

		protected override void OnAnimationStarted()
		{
			base.OnAnimationStarted();
			if (base.IsFirstperson)
			{
				base.enabled = true;
				SpectatorTargetTracker.SetTrackedTransform(SpectatorCameraAnchor.transform);
				SpectatorCameraAnchor.SetActive(value: true);
			}
			else
			{
				Object.Destroy(this);
			}
		}

		protected override void OnAnimationEnded()
		{
			base.OnAnimationEnded();
			SpectatorCameraAnchor.SetActive(value: false);
			SpectatorTargetTracker.SetTrackedTransform(null);
			Object.Destroy(this);
		}

		private void OnCollisionEnter(Collision collision)
		{
			if (base.IsPlaying)
			{
				float magnitude = collision.relativeVelocity.magnitude;
				if (magnitude > 8f && BloodEffectsSystem.LocalPlayerSingleton != null)
				{
					BloodEffectsSystem.LocalPlayerSingleton.AddScrapes(magnitude / 40f);
				}
			}
		}
	}
}
