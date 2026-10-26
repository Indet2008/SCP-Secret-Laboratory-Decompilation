using System;
using CustomPlayerEffects;
using InventorySystem.Items.Pickups;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables;
using UnityEngine;

namespace InventorySystem.Items.Armor
{
	public class BodyArmor : ItemBase, IWearableItem, IItemNametag, IMovementSpeedModifier, IStaminaModifier
	{
		[Serializable]
		public struct ArmorAmmoLimit
		{
			public ItemType AmmoType;

			public ushort Limit;
		}

		[Serializable]
		public struct ArmorCategoryLimitModifier
		{
			public ItemCategory Category;

			public byte Limit;
		}

		[Range(0f, 100f)]
		public int HelmetEfficacy;

		[Range(0f, 100f)]
		public int VestEfficacy;

		public float CivilianClassDownsidesMultiplier = 1f;

		public ArmorAmmoLimit[] AmmoLimits;

		public ArmorCategoryLimitModifier[] CategoryLimits;

		[SerializeField]
		[Range(1f, 2f)]
		private float _staminaUseMultiplier = 1f;

		[SerializeField]
		[Range(0f, 1f)]
		private float _movementSpeedMultiplier = 1f;

		[SerializeField]
		private float _weight;

		public override float Weight => _weight;

		public bool IsWorn => true;

		public WearableSlot Slot => WearableSlot.Body;

		public override bool AllowEquip => false;

		public bool MovementModifierActive
		{
			get
			{
				if (IsWorn)
				{
					return !IHeavyItemPenaltyImmunity.IsImmune(base.Owner);
				}
				return false;
			}
		}

		public float MovementSpeedMultiplier => ProcessMultiplier(_movementSpeedMultiplier);

		public float MovementSpeedLimit => float.MaxValue;

		public bool StaminaModifierActive
		{
			get
			{
				if (IsWorn)
				{
					return !IHeavyItemPenaltyImmunity.IsImmune(base.Owner);
				}
				return false;
			}
		}

		public float StaminaUsageMultiplier => ProcessMultiplier(_staminaUseMultiplier);

		public bool SprintingDisabled => false;

		public float StaminaRegenMultiplier => 1f;

		public override ItemDescriptionType DescriptionType => ItemDescriptionType.Armor;

		public string Name => ItemTypeId.GetName();

		private float ProcessMultiplier(float f)
		{
			Team team = base.Owner.GetTeam();
			if (team == Team.ClassD || team == Team.Scientists)
			{
				f = (f - 1f) * CivilianClassDownsidesMultiplier + 1f;
			}
			return f;
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			if (NetworkServer.active)
			{
				BodyArmorUtils.SetPlayerDirty(base.Owner);
				base.Owner.EnableWearables(WearableElements.Armor);
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (NetworkServer.active)
			{
				BodyArmorUtils.SetPlayerDirty(base.Owner);
				base.Owner.DisableWearables(WearableElements.Armor);
			}
		}
	}
}
