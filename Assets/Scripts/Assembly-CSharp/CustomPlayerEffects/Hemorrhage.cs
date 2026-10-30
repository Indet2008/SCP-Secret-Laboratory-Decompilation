using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;

namespace CustomPlayerEffects
{
	public class Hemorrhage : TickingEffectBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		public float effectIncrease;


		public float damagePerTick = 1f;

		private bool _isSprinting;

		private DiminishingLerpVisuals _diminishingPlayerEffect;

		protected override void Awake()
		{
			base.Awake();
			_diminishingPlayerEffect = GetComponent<DiminishingLerpVisuals>();
		}

		protected override void OnTick()
		{
			if (NetworkServer.active && _isSprinting)
			{
				float damage = damagePerTick * RainbowTaste.CurrentMultiplier(base.Hub);
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(damage, DeathTranslations.Bleeding));
			}
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				_isSprinting = fpcRole.FpcModule.CurrentMovementState == PlayerMovementState.Sprinting;
			}
			if ((base.Hub.isLocalPlayer || PlayerRoles.Spectating.SpectatorNetworking.IsLocallySpectated(base.Hub)) && _isSprinting)
			{
				_diminishingPlayerEffect.Intensity += effectIncrease;
			}
		}
	}
}
