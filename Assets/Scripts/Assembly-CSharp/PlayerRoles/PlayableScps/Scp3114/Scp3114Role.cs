using System.Collections.Generic;
using System.Text;
using Interactables.Interobjects.DoorUtils;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Role : FpcStandardScp, IHumeShieldedRole, IInventoryRole, ISubroutinedRole, IHudScp, ICustomNicknameDisplayRole, IDamageHandlerProcessingRole, IHitmarkerPreventer, ISpawnableScp
	{
		private static readonly HolidayType[] SupportedHolidays = new HolidayType[2]
		{
			HolidayType.Halloween,
			HolidayType.Christmas
		};

		private static readonly ItemCategory[] BlacklistedCategories = new ItemCategory[2]
		{
			ItemCategory.SCPItem,
			ItemCategory.SpecialWeapon
		};

		private static readonly ItemType[] BlacklistedItems = new ItemType[2]
		{
			ItemType.KeycardO5,
			ItemType.KeycardFacilityManager
		};

		private Scp3114Identity _identity;

		private Scp3114DamageProcessor _damageProcessor;

		private static bool EnableSpawning => SupportedHolidays.IsAnyHolidayActive();

		[field: SerializeField]
		public HumeShieldModuleBase HumeShieldModule { get; private set; }

		[field: SerializeField]
		public SubroutineManagerModule SubroutineModule { get; private set; }

		[field: SerializeField]
		public ScpHudBase HudPrefab { get; private set; }

		public Scp3114Identity.StolenIdentity CurIdentity => _identity.CurIdentity;

		public bool Disguised
		{
			get
			{
				return CurIdentity.Status == Scp3114Identity.DisguiseStatus.Active;
			}
			set
			{
				if (value != Disguised && NetworkServer.active)
				{
					CurIdentity.Status = (value ? Scp3114Identity.DisguiseStatus.Active : Scp3114Identity.DisguiseStatus.None);
					_identity.ServerResendIdentity();
				}
			}
		}

		public bool SkeletonIdle => CurIdentity.Status == Scp3114Identity.DisguiseStatus.None;

		public bool RespectPreferences => EnableSpawning;

		public bool AllowFallback => EnableSpawning;

		public Color NicknameColor => _identity.NicknameColor;

		public override PermissionUsed PermissionsUsedCallback
		{
			get
			{
				if (TryGetCurrentItem(out var ib) && ib is IDoorPermissionProvider doorPermissionProvider)
				{
					return doorPermissionProvider.PermissionsUsedCallback;
				}
				return base.PermissionsUsedCallback;
			}
		}

		private void Awake()
		{
			SubroutineModule.TryGetSubroutine<Scp3114Identity>(out _identity);
			SubroutineModule.TryGetSubroutine<Scp3114DamageProcessor>(out _damageProcessor);
		}

		public override DoorPermissionFlags GetPermissions(IDoorPermissionRequester requester)
		{
			if (Disguised && TryGetOwner(out var hub))
			{
				ItemBase curInstance = hub.inventory.CurInstance;
				if (curInstance != null && curInstance is IDoorPermissionProvider doorPermissionProvider)
				{
					return doorPermissionProvider.GetPermissions(requester);
				}
			}
			return base.GetPermissions(requester);
		}

		public bool CanPickupItem(ItemPickupBase itemPickup)
		{
			ItemType typeId = itemPickup.ItemId.TypeId;
			if (BlacklistedItems.Contains(typeId))
			{
				return false;
			}
			if (!InventoryItemLoader.TryGetItem<ItemBase>(typeId, out var result))
			{
				return false;
			}
			return !BlacklistedCategories.Contains(result.Category);
		}

		public void WriteNickname(StringBuilder sb)
		{
			_identity.WriteNickname(sb);
		}

		public DamageHandlerBase ProcessDamageHandler(DamageHandlerBase dhb)
		{
			return _damageProcessor.ProcessDamageHandler(dhb);
		}

		public bool TryPreventHitmarker(AttackerDamageHandler adh)
		{
			if (!Disguised)
			{
				return false;
			}
			RoleTypeId role = adh.Attacker.Role;
			RoleTypeId stolenRole = CurIdentity.StolenRole;
			return !HitboxIdentity.IsDamageable(role, stolenRole);
		}

		public bool AllowDisarming(ReferenceHub detainer)
		{
			if (CurIdentity.Status != Scp3114Identity.DisguiseStatus.Active)
			{
				return false;
			}
			if (CurIdentity.StolenRole.GetFaction() == detainer.GetFaction())
			{
				return false;
			}
			return true;
		}

		public bool AllowUndisarming(ReferenceHub releaser)
		{
			return releaser.IsHuman();
		}

		public float GetSpawnChance(List<RoleTypeId> alreadySpawned)
		{
			return EnableSpawning ? 1 : 0;
		}

		private bool TryGetCurrentItem(out ItemBase ib)
		{
			if (!Disguised || !TryGetOwner(out var hub))
			{
				ib = null;
				return false;
			}
			ib = hub.inventory.CurInstance;
			return true;
		}
	}
}
