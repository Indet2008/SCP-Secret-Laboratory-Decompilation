using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class TeslaRippleTrigger : RippleTriggerBase
	{
		private const float CooldownDuration = 0.7f;

		private const float IdleRangeSqr = 120f;

		private const float BurstRangeSqr = 2400f;

		private static readonly Vector3 PosOffset = Vector3.up * 1.35f;

		private readonly AbilityCooldown _cooldown = new AbilityCooldown();

		public override void SpawnObject()
		{
			base.SpawnObject();
			TeslaGate.OnBursted += OnTeslaBursted;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_cooldown.Clear();
			TeslaGate.OnBursted -= OnTeslaBursted;
		}

		private void OnTeslaBursted(TeslaGate tg)
		{
			if (base.IsLocalOrSpectated)
			{
				PlayInRange(tg.transform.position + PosOffset, 2400f, Color.red);
			}
		}

		private void Update()
		{
			if (!base.IsLocalOrSpectated || !_cooldown.IsReady)
			{
				return;
			}
			_cooldown.Trigger(0.699999988079071);
			foreach (TeslaGate allGate in TeslaGate.AllGates)
			{
				if (allGate.isIdling)
				{
					PlayInRange(allGate.transform.position + PosOffset, 120f, Color.red);
				}
			}
		}
	}
}
