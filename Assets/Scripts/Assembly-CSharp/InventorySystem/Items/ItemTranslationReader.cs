using System;
using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Items
{
	public static class ItemTranslationReader
	{
		private class NameDescriptionPair
		{
			public string Name;

			public string Nickname;

			public string Description;
		}

		private const char SplitChar = '~';

		private static NameDescriptionPair[] _cachedTranslations;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			TranslationReader.OnTranslationsRefreshed += ReloadTranslations;
		}

		private static void ReloadTranslations()
		{
			int num = 0;
			foreach (KeyValuePair<ItemType, ItemBase> availableItem in InventoryItemLoader.AvailableItems)
			{
				num = Mathf.Max(num, (int)availableItem.Key);
			}
			if (_cachedTranslations == null)
			{
				_cachedTranslations = new NameDescriptionPair[num + 1];
			}
			string val;
			for (int i = 0; TranslationReader.TryGet("Items", i, out val); i++)
			{
				string[] array = val.Split('~');
				if (array.Length >= 2 && int.TryParse(array[0], out var result))
				{
					string name = array[1];
					string description = ((array.Length > 2) ? array[2] : string.Empty);
					string nickname = ((array.Length > 3) ? array[3] : string.Empty);
					EnsureCapacity(result);
					_cachedTranslations[result] = new NameDescriptionPair
					{
						Name = name,
						Nickname = nickname,
						Description = description
					};
				}
			}
		}

		private static void EnsureCapacity(int cap)
		{
			if (cap >= _cachedTranslations.Length)
			{
				Array.Resize(ref _cachedTranslations, cap * 2);
			}
		}

		private static NameDescriptionPair GetTranslation(ItemType it)
		{
			int num = (int)it;
			if (num < 0)
			{
				throw new InvalidOperationException($"Cannot load translation for item {it}");
			}
			if (_cachedTranslations == null)
			{
				ReloadTranslations();
			}
			NameDescriptionPair nameDescriptionPair = _cachedTranslations[num];
			if (nameDescriptionPair == null)
			{
				nameDescriptionPair = new NameDescriptionPair
				{
					Name = it.ToString()
				};
				_cachedTranslations[num] = nameDescriptionPair;
			}
			return nameDescriptionPair;
		}

		public static string GetName(this ItemType it)
		{
			return GetTranslation(it).Name;
		}

		public static string GetNickname(this ItemType it)
		{
			return GetTranslation(it).Nickname;
		}

		public static string GetDescription(this ItemType it)
		{
			return GetTranslation(it).Description;
		}
	}
}
