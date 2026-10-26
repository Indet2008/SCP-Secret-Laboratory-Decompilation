using InventorySystem;
using InventorySystem.Items;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class Scp1576 : Scp2536ItemGift
	{
		private static bool _hasBeenGranted;

		public override UrgencyLevel Urgency => UrgencyLevel.Exclusive;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[1]
		{
			new Scp2536Reward(ItemType.SCP1576, 100f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!_hasBeenGranted && base.CanBeGranted(hub))
			{
				return Random.value <= 0.05f;
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			ItemType type = GenerateRandomReward();
			hub.inventory.ServerAddItem(type, ItemAddReason.Scp2536, 0).GrantAmmoReward();
			_hasBeenGranted = true;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				_hasBeenGranted = false;
			};
		}
	}
}
