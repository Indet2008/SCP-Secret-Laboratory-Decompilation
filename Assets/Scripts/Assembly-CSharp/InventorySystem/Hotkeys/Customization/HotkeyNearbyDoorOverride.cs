namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyNearbyDoorOverride : global::InventorySystem.Hotkeys.Customization.HotkeyOverrideBase
	{
		private static readonly global::System.Collections.Generic.List<global::Interactables.Interobjects.DoorUtils.DoorVariant> NearbyDoors;

		private static bool _anyNearbyDoors;

		private static global::UnityEngine.Vector3Int? _prevCoords;

		public override global::InventorySystem.Hotkeys.Customization.HotkeyOverrideOption OptionType
		{
			get
			{
				return default;
			}
		}

		public override global::InventorySystem.Hotkeys.HotkeysTranslation OptionName
		{
			get
			{
				return default;
			}
		}

		public override global::InventorySystem.Hotkeys.HotkeysTranslation? Description
		{
			get
			{
				return default;
			}
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
		}

		private static void UpdateNearbyDoors(global::UnityEngine.Vector3 position)
		{
		}

		public override bool CheckAvailability(global::System.Collections.Generic.List<global::InventorySystem.Hotkeys.Customization.PoolElementData> elements)
		{
			return default;
		}

		public override bool TryGetOverride(ReferenceHub player, int hotkeyId, global::System.Collections.Generic.List<global::InventorySystem.Items.ItemBase> matches, out global::InventorySystem.Items.ItemBase result)
		{ result = default;
			return default;
		}

		public HotkeyNearbyDoorOverride()
		{
		}
	}
}
