using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects.Danger
{
	public class PlayerDamagedDanger : ParentDangerBase
	{
		private const int DangerStepThreshold = 10;

		private const float DangerPerThreshold = 0.25f;

		private float _leftoverDamage;

		public override void Initialize(ReferenceHub target)
		{
			base.Initialize(target);
			_leftoverDamage = 0f;
			PlayerStats.OnAnyPlayerDamaged += UpdateState;
		}

		public override void Dispose()
		{
			base.Dispose();
			PlayerStats.OnAnyPlayerDamaged -= UpdateState;
		}

		private void UpdateState(ReferenceHub damagedHub, DamageHandlerBase damageHandler)
		{
			if (damagedHub != base.Owner || damageHandler is Scp049DamageHandler)
			{
				return;
			}
			if (!(damageHandler is AttackerDamageHandler attackerDamageHandler))
			{
				if (damageHandler is UniversalDamageHandler universalDamageHandler && universalDamageHandler.TranslationId == DeathTranslations.PocketDecay.Id)
				{
					return;
				}
			}
			else if (attackerDamageHandler.Attacker.Hub.roleManager.CurrentRole.RoleTypeId == RoleTypeId.Scp106)
			{
				return;
			}
			if (damageHandler is StandardDamageHandler standardDamageHandler)
			{
				float num = Mathf.Floor((standardDamageHandler.DealtHealthDamage + _leftoverDamage) / 10f) * 0.25f;
				if (standardDamageHandler.DealtHealthDamage % 10f + _leftoverDamage >= 10f)
				{
					_leftoverDamage = 0f;
				}
				_leftoverDamage += standardDamageHandler.DealtHealthDamage % 10f;
				if (!(num < 0.25f))
				{
					base.ChildDangers.Add(new ExpiringDanger(num, base.Owner));
				}
			}
		}
	}
}
