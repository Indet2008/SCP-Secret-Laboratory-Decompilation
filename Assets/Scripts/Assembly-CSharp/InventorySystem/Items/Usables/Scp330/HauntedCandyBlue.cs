using CustomPlayerEffects;
using InventorySystem.Items.MarshmallowMan;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyBlue : ICandy
	{
		public CandyKindID Kind => CandyKindID.Blue;

		public float SpawnChanceWeight { get; private set; } = 5f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			hub.playerEffectsController.AllEffects.ForEach(DisableEffectConditionally);
		}

		private void DisableEffectConditionally(StatusEffectBase fx)
		{
			if (!(fx is BodyshotReduction) && !(fx is Invigorated) && !(fx is MovementBoost) && !(fx is RainbowTaste) && !(fx is Vitality) && !(fx is Blurred) && !(fx is Burned) && !(fx is Concussed) && !(fx is Deafened) && !(fx is CardiacArrest) && !(fx is CustomPlayerEffects.Scp207) && !(fx is CustomPlayerEffects.AntiScp207) && !(fx is Metal) && !(fx is OrangeCandy) && !(fx is WhiteCandy))
			{
				if (fx is MarshmallowEffect || fx is SugarCrave)
				{
					fx.ServerSetState(1);
				}
			}
			else
			{
				fx.ServerDisable();
			}
		}
	}
}
