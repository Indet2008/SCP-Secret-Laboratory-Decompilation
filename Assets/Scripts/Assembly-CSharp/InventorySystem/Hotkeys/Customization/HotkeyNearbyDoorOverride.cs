using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items;
using MapGeneration;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyNearbyDoorOverride : HotkeyOverrideBase
	{
		private static readonly List<DoorVariant> NearbyDoors = new List<DoorVariant>();

		private static bool _anyNearbyDoors;

		private static Vector3Int? _prevCoords;

		public override HotkeyOverrideOption OptionType => HotkeyOverrideOption.PrioritizeNearbyDoors;

		public override HotkeysTranslation OptionName => HotkeysTranslation.OverrideNearbyDoor;

		public override HotkeysTranslation? Description => HotkeysTranslation.OverrideNearbyDoorHint;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnLocalClientStarted += delegate
			{
				_prevCoords = null;
				NearbyDoors.Clear();
				_anyNearbyDoors = false;
			};
		}

		private static void UpdateNearbyDoors(Vector3 position)
		{
			NearbyDoors.Clear();
			if (position.TryGetRoom(out var room) && DoorVariant.DoorsByRoom.TryGetValue(room, out var value))
			{
				foreach (DoorVariant item in value)
				{
					NearbyDoors.Add(item);
				}
			}
			_anyNearbyDoors = NearbyDoors.Count > 0;
		}

		public override bool CheckAvailability(List<PoolElementData> elements)
		{
			return elements.CountMatches(HotkeyItemGroup.AnyKeycard.GetItems()) > 0;
		}

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, List<ItemBase> matches, out ItemBase result)
		{
			result = null;
			if (!(player.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			Vector3 position = fpcRole.FpcModule.Position;
			Vector3Int vector3Int = RoomUtils.PositionToCoords(position);
			if (!_prevCoords.HasValue || _prevCoords.Value != vector3Int)
			{
				UpdateNearbyDoors(position);
				_prevCoords = vector3Int;
			}
			if (!_anyNearbyDoors)
			{
				return false;
			}
			DoorVariant doorVariant = null;
			float num = float.MaxValue;
			foreach (DoorVariant nearbyDoor in NearbyDoors)
			{
				if (!(nearbyDoor == null))
				{
					float sqrMagnitude = (nearbyDoor.transform.position - position).sqrMagnitude;
					if (!(sqrMagnitude >= num))
					{
						num = sqrMagnitude;
						doorVariant = nearbyDoor;
					}
				}
			}
			if (doorVariant == null)
			{
				return false;
			}
			foreach (ItemBase match in matches)
			{
				if (match is IDoorPermissionProvider provider && doorVariant.CheckPermissions(provider, out var _))
				{
					result = match;
					return true;
				}
			}
			return false;
		}
	}
}
