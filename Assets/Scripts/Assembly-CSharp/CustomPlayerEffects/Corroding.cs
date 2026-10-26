using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;

namespace CustomPlayerEffects
{
	public class Corroding : TickingEffectBase, IStaminaModifier
	{
		private const float DamagePerTick = 2.1f;

		private static readonly float StaminaDrainPercentage;

		public ReferenceHub AttackerHub;

		public override bool AllowEnabling => true;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaRegenMultiplier => 0f;

		protected override void OnTick()
		{
			if (NetworkServer.active && !(AttackerHub == null) && !Vitality.CheckPlayer(base.Hub))
			{
				base.Hub.playerStats.DealDamage(new ScpDamageHandler(AttackerHub, 2.1f, DeathTranslations.PocketDecay));
				if (StaminaDrainPercentage > 0f)
				{
					base.Hub.playerStats.GetModule<StaminaStat>().CurValue -= StaminaDrainPercentage * 0.01f;
				}
			}
		}
	}
}
