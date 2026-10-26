using System;
using Footprinting;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.ThrowableProjectiles;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace Christmas.Scp2536.Gifts
{
	public class Naughty : Scp2536ItemGift
	{
		private const float GiftReplacementChance = 50f;

		private const int MaxGiftOpenings = 3;

		public override UrgencyLevel Urgency => UrgencyLevel.Exclusive;

		internal override bool IgnoredByRandomness => true;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[7]
		{
			new Scp2536Reward(ItemType.Coal, 45f),
			new Scp2536Reward(ItemType.SpecialCoal, 5f),
			new Scp2536Reward(ItemType.GrenadeFlash, 10f),
			new Scp2536Reward(ItemType.GrenadeHE, 10f),
			new Scp2536Reward(ItemType.SCP018, 10f),
			new Scp2536Reward(ItemType.None, 10f),
			new Scp2536Reward(ItemType.Scp021J, 10f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!(UnityEngine.Random.Range(0f, 100f) <= 50f))
			{
				return false;
			}
			return Scp2536GiftController.Gifts.Count((Scp2536GiftBase g) => g.ObtainedBy.Contains(hub)) > 3;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			ItemType itemType = GenerateRandomReward();
			switch (itemType)
			{
			case ItemType.GrenadeHE:
			case ItemType.GrenadeFlash:
				SpawnProjectile(itemType, hub, SetupEffectGrenade);
				break;
			case ItemType.SCP018:
			{
				for (int i = 0; i < 3; i++)
				{
					SpawnProjectile(itemType, hub, SetupScp018);
				}
				break;
			}
			case ItemType.None:
			{
				if (!Scp956Pinata.TryGetInstance(out var instance))
				{
					break;
				}
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					allHub.playerEffectsController.DisableEffect<Scp956Target>();
				}
				Scp956Pinata.ActiveTargets.Clear();
				instance.SpawnBehindTarget(hub);
				break;
			}
			default:
				hub.inventory.ServerAddItem(itemType, ItemAddReason.Scp2536, 0).GrantAmmoReward();
				break;
			}
		}

		private void SetupEffectGrenade(ThrownProjectile projectile)
		{
			projectile.ServerActivate();
		}

		private void SetupScp018(ThrownProjectile projectile)
		{
			projectile.GetComponent<Rigidbody>().linearVelocity = UnityEngine.Random.onUnitSphere * 15f;
		}

		private void SpawnProjectile(ItemType id, ReferenceHub hub, Action<ThrownProjectile> setupMethod)
		{
			if (InventoryItemLoader.TryGetItem<ThrowableItem>(id, out var result))
			{
				ThrownProjectile thrownProjectile = UnityEngine.Object.Instantiate(result.Projectile, hub.transform.position, Quaternion.identity);
				PickupSyncInfo pickupSyncInfo = new PickupSyncInfo(id, result.Weight, ItemSerialGenerator.GenerateNext());
				pickupSyncInfo.Locked = true;
				PickupSyncInfo networkInfo = pickupSyncInfo;
				thrownProjectile.NetworkInfo = networkInfo;
				thrownProjectile.PreviousOwner = new Footprint(hub);
				setupMethod(thrownProjectile);
				NetworkServer.Spawn(thrownProjectile.gameObject);
			}
		}
	}
}
