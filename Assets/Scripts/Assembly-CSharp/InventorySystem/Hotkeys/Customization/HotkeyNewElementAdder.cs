using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyNewElementAdder : MonoBehaviour
	{
		private struct ItemElement
		{
			private readonly global::UnityEngine.GameObject _go;

			private readonly global::TMPro.TMP_Text _text;

			private readonly global::UnityEngine.UI.RawImage _icon;

			private readonly global::UnityEngine.UI.Button _button;

			private readonly global::UnityEngine.Texture _defIcon;

			public global::InventorySystem.Hotkeys.Customization.PoolElementData Data
			{
				[global::System.Runtime.CompilerServices.CompilerGenerated]
				readonly get
				{
					return default;
				}
				[global::System.Runtime.CompilerServices.CompilerGenerated]
				private set
				{
				}
			}

			public ItemElement(global::UnityEngine.GameObject newInst, global::UnityEngine.Texture defaultIcon)
			{ this = default;
			}

			public readonly void Disable()
			{
			}

			public bool TryEnable(global::InventorySystem.Hotkeys.Customization.PoolElementData data, global::TMPro.TMP_InputField filter, global::System.Action<global::InventorySystem.Hotkeys.Customization.PoolElementData> callback)
			{
				return default;
			}

			private readonly bool CheckFilter(string filter)
			{
				return default;
			}
		}

		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.RectTransform _elementTemplate;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Texture _defaultIcon;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_InputField _searchBar;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Hotkeys.Customization.PoolElementData.ElementType[] _types;

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Hotkeys.Customization.HotkeyPool _pool;


	}
}
