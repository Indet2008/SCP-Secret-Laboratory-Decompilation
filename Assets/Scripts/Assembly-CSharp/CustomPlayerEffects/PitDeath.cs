using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class PitDeath : StatusEffectBase, IDamageModifierEffect
	{
		private const float MinAliveDuration = 1f;

		private const float FallbackMaxDelay = 1.2f;

		private float _activeElapsed;

		public override bool AllowEnabling => true;

		public bool DamageModifierActive => base.IsEnabled;

		public static bool ValidatePlayer(ReferenceHub hub)
		{
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (!(currentRole is IFpcRole fpcRole))
			{
				return false;
			}
			if (fpcRole.FpcModule.Noclip.IsActive)
			{
				return false;
			}
			if (hub.characterClassManager.GodMode)
			{
				return false;
			}
			if (currentRole.ActiveTime < 1f)
			{
				return false;
			}
			return true;
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			return (!IsFallDamageHandler(handler)) ? 1 : 0;
		}

		protected override void Enabled()
		{
			base.Enabled();
			_activeElapsed = 0f;
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (NetworkServer.active)
			{
				_activeElapsed += Time.deltaTime;
				CheckKillConditions();
			}
		}

		private bool IsFallDamageHandler(DamageHandlerBase handler)
		{
			if (handler is UniversalDamageHandler universalDamageHandler)
			{
				return universalDamageHandler.TranslationId == DeathTranslations.Falldown.Id;
			}
			return false;
		}

		private void CheckKillConditions()
		{
			if (!ValidatePlayer(base.Hub))
			{
				DisableEffect();
			}
			else if (!(_activeElapsed <= 1.2f) || base.Hub.IsGrounded())
			{
				KillPlayer();
			}
		}

		private void KillPlayer()
		{
			base.Hub.playerStats.DealDamage(new UniversalDamageHandler(-1f, DeathTranslations.Crushed));
		}
	}
}
