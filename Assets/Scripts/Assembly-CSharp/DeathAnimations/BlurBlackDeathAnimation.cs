using CustomRendering;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.Rendering;

namespace DeathAnimations
{
	public class BlurBlackDeathAnimation : FirstpersonDeathAnimation
	{
		private const float InstantDarknessSpeed = 0.25f;

		public float delayTillDark = 3.3f;

		private bool _instantDarkness;

		private Volume _tempVolume;

		private BlurEffect _blur;

		private Darken _darken;

		private float _fadeTime;

		private void Update()
		{
			_fadeTime += Time.deltaTime;
			if (!(_fadeTime < delayTillDark))
			{
				_darken.Intensity.value = Mathf.Clamp01(_fadeTime - delayTillDark);
			}
			else if (_instantDarkness)
			{
				_darken.Intensity.value = Mathf.Clamp01(_fadeTime / 0.25f);
			}
		}

		protected override void OnAnimationStarted()
		{
			base.OnAnimationStarted();
			if (base.IsFirstperson && ReferenceHub.TryGetLocalHub(out var hub) && hub.GetTeam() == Team.Dead)
			{
				if (base.TargetRagdoll.Info.Handler is ScpDamageHandler scpDamageHandler && scpDamageHandler.Attacker.Role == RoleTypeId.Scp106)
				{
					_instantDarkness = true;
				}
				base.enabled = true;
				_blur = ScriptableObject.CreateInstance<BlurEffect>();
				_blur.Amount.Override(5f);
				_blur.Iterations.Override(3);
				_blur.active = true;
				_darken = ScriptableObject.CreateInstance<Darken>();
				_darken.Intensity.Override(0f);
				_darken.active = true;
				_tempVolume = PostProcessingVolumes.SafeGetVolume(1, 40f, new VolumeComponent[2] { _darken, _blur });
				_tempVolume.weight = 1f;
			}
			else
			{
				Object.Destroy(this);
			}
		}

		protected override void OnAnimationEnded()
		{
			base.OnAnimationEnded();
			PostProcessingVolumes.DestroyVolume(_tempVolume);
			if (_blur != null)
			{
				Object.Destroy(_blur);
			}
			if (_darken != null)
			{
				Object.Destroy(_darken);
			}
			Object.Destroy(this);
		}
	}
}
