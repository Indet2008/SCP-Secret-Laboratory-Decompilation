using Footprinting;
using InventorySystem.Items.ThrowableProjectiles;
using Mirror;
using UnityEngine;

namespace MapGeneration.Decoration
{
	public class ExplosionAlarmTrigger : AlarmTriggerBase
	{
		protected override float Duration => 20f;

		protected override void Start()
		{
			base.Start();
			if (NetworkServer.active)
			{
				ExplosionGrenade.OnExploded += HandleGrenadeExploded;
			}
		}

		private void HandleGrenadeExploded(Footprint attacker, Vector3 position, ExplosionGrenade grenade)
		{
			if (IsInRange(position))
			{
				ServerTriggerAlarm();
			}
		}

		private void OnDestroy()
		{
			if (NetworkServer.active)
			{
				ExplosionGrenade.OnExploded -= HandleGrenadeExploded;
			}
		}
	}
}
