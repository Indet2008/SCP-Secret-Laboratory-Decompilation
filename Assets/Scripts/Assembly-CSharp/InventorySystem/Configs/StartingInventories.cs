using System.Collections.Generic;
using PlayerRoles;

namespace InventorySystem.Configs
{
	public static class StartingInventories
	{
		public static readonly Dictionary<RoleTypeId, InventoryRoleInfo> DefinedInventories = new Dictionary<RoleTypeId, InventoryRoleInfo>
		{
			[RoleTypeId.Scientist] = new InventoryRoleInfo(new ItemType[2]
			{
				ItemType.KeycardScientist,
				ItemType.Medkit
			}, new Dictionary<ItemType, ushort>()),
			[RoleTypeId.FacilityGuard] = new InventoryRoleInfo(new ItemType[6]
			{
				ItemType.KeycardGuard,
				ItemType.GunFSP9,
				ItemType.Medkit,
				ItemType.GrenadeFlash,
				ItemType.Radio,
				ItemType.ArmorLight
			}, new Dictionary<ItemType, ushort> { [ItemType.Ammo9x19] = 60 }),
			[RoleTypeId.NtfPrivate] = new InventoryRoleInfo(new ItemType[5]
			{
				ItemType.KeycardMTFOperative,
				ItemType.GunCrossvec,
				ItemType.Medkit,
				ItemType.Radio,
				ItemType.ArmorCombat
			}, new Dictionary<ItemType, ushort>
			{
				[ItemType.Ammo9x19] = 160,
				[ItemType.Ammo556x45] = 40
			}),
			[RoleTypeId.NtfSergeant] = new InventoryRoleInfo(new ItemType[6]
			{
				ItemType.KeycardMTFOperative,
				ItemType.GunE11SR,
				ItemType.Medkit,
				ItemType.GrenadeHE,
				ItemType.Radio,
				ItemType.ArmorCombat
			}, new Dictionary<ItemType, ushort>
			{
				[ItemType.Ammo9x19] = 40,
				[ItemType.Ammo556x45] = 120
			}),
			[RoleTypeId.NtfSpecialist] = new InventoryRoleInfo(new ItemType[7]
			{
				ItemType.KeycardMTFOperative,
				ItemType.GunE11SR,
				ItemType.Medkit,
				ItemType.Medkit,
				ItemType.GrenadeHE,
				ItemType.Radio,
				ItemType.ArmorCombat
			}, new Dictionary<ItemType, ushort>
			{
				[ItemType.Ammo9x19] = 40,
				[ItemType.Ammo556x45] = 150
			}),
			[RoleTypeId.NtfCaptain] = new InventoryRoleInfo(new ItemType[7]
			{
				ItemType.KeycardMTFCaptain,
				ItemType.GunFRMG0,
				ItemType.Adrenaline,
				ItemType.Medkit,
				ItemType.GrenadeHE,
				ItemType.Radio,
				ItemType.ArmorHeavy
			}, new Dictionary<ItemType, ushort>
			{
				[ItemType.Ammo9x19] = 40,
				[ItemType.Ammo556x45] = 230
			}),
			[RoleTypeId.ChaosConscript] = new InventoryRoleInfo(new ItemType[6]
			{
				ItemType.KeycardChaosInsurgency,
				ItemType.GunAK,
				ItemType.Medkit,
				ItemType.Medkit,
				ItemType.Painkillers,
				ItemType.ArmorCombat
			}, new Dictionary<ItemType, ushort>
			{
				[ItemType.Ammo762x39] = 150,
				[ItemType.Ammo12gauge] = 14
			}),
			[RoleTypeId.ChaosRifleman] = new InventoryRoleInfo(new ItemType[5]
			{
				ItemType.KeycardChaosInsurgency,
				ItemType.GunAK,
				ItemType.Medkit,
				ItemType.Painkillers,
				ItemType.ArmorCombat
			}, new Dictionary<ItemType, ushort>
			{
				[ItemType.Ammo762x39] = 120,
				[ItemType.Ammo12gauge] = 7
			}),
			[RoleTypeId.ChaosMarauder] = new InventoryRoleInfo(new ItemType[6]
			{
				ItemType.KeycardChaosInsurgency,
				ItemType.GunShotgun,
				ItemType.GunRevolver,
				ItemType.Medkit,
				ItemType.Painkillers,
				ItemType.ArmorCombat
			}, new Dictionary<ItemType, ushort>
			{
				[ItemType.Ammo44cal] = 24,
				[ItemType.Ammo12gauge] = 49
			}),
			[RoleTypeId.ChaosRepressor] = new InventoryRoleInfo(new ItemType[5]
			{
				ItemType.KeycardChaosInsurgency,
				ItemType.GunLogicer,
				ItemType.Medkit,
				ItemType.Adrenaline,
				ItemType.ArmorHeavy
			}, new Dictionary<ItemType, ushort> { [ItemType.Ammo762x39] = 200 })
		};
	}
}
