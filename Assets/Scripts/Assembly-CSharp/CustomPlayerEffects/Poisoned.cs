using Mirror;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Poisoned : TickingEffectBase, IHealableEffect, IPulseEffect
	{
		private float damagePerTick = 2f;

		private readonly float minDamage = 2f;

		private readonly float maxDamage = 20f;

		private readonly float multPerTick = 2f;

		public void ExecutePulse()
		{
		}

		public bool IsHealable(ItemType it)
		{
			return it == ItemType.SCP500;
		}

		protected override void OnTick()
		{
			if (NetworkServer.active)
			{
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(damagePerTick, DeathTranslations.Poisoned));
				base.Hub.playerEffectsController.ServerSendPulse<Poisoned>();
				damagePerTick *= multPerTick;
				damagePerTick = Mathf.Clamp(damagePerTick, minDamage, maxDamage);
			}
		}

		protected override void Enabled()
		{
			if (NetworkServer.active)
			{
				damagePerTick = minDamage;
			}
		}
	}
}
