using Utils;

namespace InventorySystem.Items.Usables.Scp330
{
	public class CandyPink : ICandy
	{
		public CandyKindID Kind => CandyKindID.Pink;

		public float SpawnChanceWeight { get; private set; }

		public void ServerApplyEffects(ReferenceHub hub)
		{
			ExplosionUtils.ServerExplode(hub, ExplosionType.PinkCandy);
		}
	}
}
