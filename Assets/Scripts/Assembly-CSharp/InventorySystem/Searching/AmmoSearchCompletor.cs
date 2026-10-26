using System;
using Hints;
using InventorySystem.Configs;
using InventorySystem.Items.Firearms.Ammo;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using UnityEngine;

namespace InventorySystem.Searching
{
	public class AmmoSearchCompletor : PickupSearchCompletor
	{
		private readonly ItemType _ammoType;

		private ushort CurrentAmmo
		{
			get
			{
				return base.Hub.inventory.GetCurAmmo(_ammoType);
			}
			set
			{
				base.Hub.inventory.ServerSetAmmo(_ammoType, value);
			}
		}

		private ushort MaxAmmo => InventoryLimits.GetAmmoLimit(_ammoType, base.Hub);

		public AmmoSearchCompletor(ReferenceHub hub, ItemPickupBase targetPickup, double maxDistanceSquared)
			: base(hub, targetPickup, maxDistanceSquared)
		{
			_ammoType = targetPickup.Info.ItemId;
		}

		public override bool ValidateStart()
		{
			if (!base.ValidateStart())
			{
				return false;
			}
			PlayerSearchingAmmoEventArgs e = new PlayerSearchingAmmoEventArgs(base.Hub, TargetPickup as AmmoPickup);
			PlayerEvents.OnSearchingAmmo(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			return true;
		}

		protected override bool ValidateAny()
		{
			if (!base.ValidateAny())
			{
				return false;
			}
			uint maxAmmo = MaxAmmo;
			if (CurrentAmmo >= maxAmmo)
			{
				base.Hub.hints.Show(new TranslationHint(HintTranslations.MaxAmmoAlreadyReached, new HintParameter[2]
				{
					new AmmoHintParameter((byte)_ammoType),
					new PackedULongHintParameter(maxAmmo)
				}, new HintEffect[1] { HintEffectPresets.TrailingPulseAlpha(0.5f, 1f, 0.5f, 2f, 0f, 2) }, 2f));
				return false;
			}
			return true;
		}

		public override void Complete()
		{
			PlayerEvents.OnSearchedPickup(new PlayerSearchedPickupEventArgs(base.Hub, TargetPickup));
			if (!(TargetPickup is AmmoPickup ammoPickup))
			{
				Debug.LogError("The pickup needs to derive from AmmoPickup");
				return;
			}
			ushort currentAmmo = CurrentAmmo;
			ushort ammoAmount = (ushort)(Math.Min(currentAmmo + ammoPickup.SavedAmmo, MaxAmmo) - currentAmmo);
			PlayerPickingUpAmmoEventArgs e = new PlayerPickingUpAmmoEventArgs(base.Hub, _ammoType, ammoAmount, TargetPickup as AmmoPickup);
			PlayerEvents.OnPickingUpAmmo(e);
			if (!e.IsAllowed)
			{
				ItemPickupBase targetPickup = TargetPickup;
				PickupSyncInfo info = TargetPickup.Info;
				info.InUse = false;
				targetPickup.NetworkInfo = info;
				return;
			}
			ammoAmount = e.AmmoAmount;
			if (ammoAmount >= ammoPickup.SavedAmmo)
			{
				TargetPickup.DestroySelf();
			}
			else
			{
				ammoPickup.NetworkSavedAmmo = (ushort)(ammoPickup.SavedAmmo - ammoAmount);
				ItemPickupBase targetPickup2 = TargetPickup;
				PickupSyncInfo info = TargetPickup.Info;
				info.InUse = false;
				targetPickup2.NetworkInfo = info;
				base.Hub.hints.Show(new TranslationHint(HintTranslations.MaxAmmoReached, new HintParameter[2]
				{
					new AmmoHintParameter((byte)_ammoType),
					new PackedULongHintParameter(MaxAmmo)
				}, HintEffectPresets.FadeInAndOut(0.25f), 1.5f));
			}
			CurrentAmmo += ammoAmount;
			PlayerEvents.OnPickedUpAmmo(new PlayerPickedUpAmmoEventArgs(base.Hub, _ammoType, ammoAmount, TargetPickup as AmmoPickup));
		}
	}
}
