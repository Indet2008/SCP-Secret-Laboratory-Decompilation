using System.Linq;
using InventorySystem;
using InventorySystem.Items;
using PlayerRoles;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class LastStand : Scp2536ItemGift, ITimeLimitedGift
	{
		private const int EvilWaterBottleChance = 40;

		private const int MaxTeammatesRequirement = 3;

		private static bool _hasBeenGranted;

		public override UrgencyLevel Urgency => UrgencyLevel.Four;

		public float SecondsUntilAvailable => 360f;

		public float SecondsUntilUnavailable => 0f;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[3]
		{
			new Scp2536Reward(ItemType.GunLogicer, 100f),
			new Scp2536Reward(ItemType.SCP500, 100f),
			new Scp2536Reward(ItemType.SCP1853, 100f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (_hasBeenGranted || !base.CanBeGranted(hub))
			{
				return false;
			}
			Faction localFaction = hub.GetFaction();
			return ReferenceHub.AllHubs.Count((ReferenceHub x) => x.GetFaction() == localFaction) <= 3;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			_hasBeenGranted = true;
			ItemType type = GenerateRandomReward();
			hub.inventory.ServerAddItem(type, ItemAddReason.Scp2536, 0).GrantAmmoReward();
			if (Random.Range(1, 101) > 40)
			{
				hub.inventory.ServerAddItem(ItemType.Scp021J, ItemAddReason.Scp2536, 0);
			}
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
