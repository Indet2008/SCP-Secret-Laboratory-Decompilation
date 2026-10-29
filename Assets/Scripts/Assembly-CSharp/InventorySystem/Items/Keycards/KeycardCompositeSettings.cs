using System;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	// Holds the KeycardTint values of the card materials. HDRP/Lit drops properties it does not declare,
	// so they cannot be read from the materials at runtime. Loaded from Resources/KeycardCompositeSettings.
	public class KeycardCompositeSettings : ScriptableObject
	{
		[Serializable]
		public class Entry
		{
			public string MaterialName;

			public Texture Albedo;

			public Texture Mask;

			public Texture PermsMask;

			public Vector2 PermsTiling = Vector2.one;

			public Vector2 PermsOffset;

			public float PermsRotation;
		}

		public Entry[] Entries;

		private static KeycardCompositeSettings _instance;

		private static bool _loaded;

		public static bool TryGet(Material template, out Entry entry)
		{
			entry = null;
			if (!_loaded)
			{
				_loaded = true;
				_instance = Resources.Load<KeycardCompositeSettings>("KeycardCompositeSettings");
			}
			if (_instance == null || template == null || _instance.Entries == null)
			{
				return false;
			}
			string text = template.name.Replace(" (Instance)", string.Empty);
			foreach (Entry entry2 in _instance.Entries)
			{
				if (entry2.MaterialName == text)
				{
					entry = entry2;
					return true;
				}
			}
			return false;
		}
	}
}
