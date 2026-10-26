namespace InventorySystem.Hotkeys
{
	public static class HotkeyInterpreter
	{
		private class CachedResult
		{
			public global::InventorySystem.Items.ItemBase Item;

			public bool IsValid;

			public CachedResult()
			{
			}
		}

		private static readonly global::System.Collections.Generic.List<global::InventorySystem.Items.ItemBase> UserItemsByOrder;

		private static readonly global::System.Collections.Generic.List<global::InventorySystem.Items.ItemBase> Matches;

		private static readonly global::System.Collections.Generic.List<int> OrderQueue;

		private static readonly global::System.Collections.Generic.List<global::UnityEngine.KeyCode> KeyDuplicateChecker;

		private static global::InventorySystem.Hotkeys.HotkeyInterpreter.CachedResult[] _cachedResults;

		private static ReferenceHub _lastLocalPlayer;

		private static bool _allowChecks;

		private static bool _cacheSet;

		[global::System.Runtime.CompilerServices.CompilerGenerated]
		private static global::System.Action m_OnHotkeysRevalidated;

		public static event global::System.Action OnHotkeysRevalidated
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			add
			{
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			remove
			{
			}
		}

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
		}

		private static void Update()
		{
		}

		private static bool CheckDuplicate(global::InventorySystem.Items.ItemBase ib, global::InventorySystem.Items.ItemBase other)
		{
			return default;
		}

		private static bool TryGetOverride(int hotkeyIndex, out global::InventorySystem.Items.ItemBase overrideItem)
		{ overrideItem = default;
			return default;
		}

		private static void UpdateCacheForItemQueue(int hotkeyIndex)
		{
		}

		private static void UpdateCacheForInventoryOrder(int hotkeyIndex)
		{
		}

		private static void UpdateCacheForHotkey(int hotkeyIndex)
		{
		}

		public static bool TryGetItem(int hotkeyIndex, out global::InventorySystem.Items.ItemBase ib)
		{ ib = default;
			return default;
		}
	}
}
