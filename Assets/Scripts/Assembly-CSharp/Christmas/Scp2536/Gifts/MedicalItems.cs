using InventorySystem;
using InventorySystem.Items;
using PlayerStatsSystem;

namespace Christmas.Scp2536.Gifts
{
	public class MedicalItems : Scp2536ItemGift
	{
		public override UrgencyLevel Urgency => UrgencyLevel.Five;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[3]
		{
			new Scp2536Reward(ItemType.Medkit, 50f),
			new Scp2536Reward(ItemType.Painkillers, 40f),
			new Scp2536Reward(ItemType.AntiSCP207, 10f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			if (!hub.playerStats.TryGetModule<HealthStat>(out var module))
			{
				return false;
			}
			return module.CurValue <= module.MaxValue * 0.5f;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			ItemType type = GenerateRandomReward();
			hub.inventory.ServerAddItem(type, ItemAddReason.Scp2536, 0).GrantAmmoReward();
		}
	}
}
