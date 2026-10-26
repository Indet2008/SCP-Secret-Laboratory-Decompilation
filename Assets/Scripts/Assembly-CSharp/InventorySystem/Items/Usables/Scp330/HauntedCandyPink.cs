using Utils;

namespace InventorySystem.Items.Usables.Scp330
{
	public class HauntedCandyPink : ICandy
	{
		public CandyKindID Kind => CandyKindID.Pink;

		public float SpawnChanceWeight { get; private set; } = 4f;

		public void ServerApplyEffects(ReferenceHub hub)
		{
			ExplosionUtils.ServerExplode(hub, ExplosionType.PinkCandy);
		}
	}
}
