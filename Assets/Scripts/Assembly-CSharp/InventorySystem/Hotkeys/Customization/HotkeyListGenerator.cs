using System;
using System.Collections.Generic;
using UnityEngine;

namespace InventorySystem.Hotkeys.Customization
{
	public class HotkeyListGenerator : MonoBehaviour
	{
		[SerializeField]
		private HotkeyCustomizer _customizerTemplate;

		[SerializeField]
		private Transform _prevSibling;

		private bool _anyModified;

		private readonly List<HotkeyCustomizer> _customizerInstances = new List<HotkeyCustomizer>();

		public static event Action<int> OnModified;

		private void Awake()
		{
			HotkeyStorage.Hotkeys.ForEach(SpawnInstance);
		}

		private void SpawnInstance(SavedHotkey sv)
		{
			HotkeyCustomizer hotkeyCustomizer = UnityEngine.Object.Instantiate(_customizerTemplate, _prevSibling.parent);
			Transform transform = hotkeyCustomizer.transform;
			hotkeyCustomizer.Load(sv, this);
			_customizerInstances.Add(hotkeyCustomizer);
			transform.SetSiblingIndex(_prevSibling.GetSiblingIndex() + _customizerInstances.Count);
		}

		private void OnDisable()
		{
			int count = _customizerInstances.Count;
			for (int i = 0; i < count; i++)
			{
				HotkeyCustomizer hotkeyCustomizer = _customizerInstances[i];
				if (hotkeyCustomizer.IsModified)
				{
					_anyModified = true;
					HotkeyStorage.Hotkeys[i] = hotkeyCustomizer.ToSavedHotkey();
					hotkeyCustomizer.IsModified = false;
					HotkeyListGenerator.OnModified?.Invoke(i);
				}
			}
			if (_anyModified)
			{
				HotkeyStorage.Save();
				_anyModified = false;
			}
		}

		public void RemoveInstance(HotkeyCustomizer instance)
		{
			int num = _customizerInstances.IndexOf(instance);
			if (num >= 0)
			{
				UnityEngine.Object.Destroy(_customizerInstances[num].gameObject);
				HotkeyStorage.Hotkeys.RemoveAt(num);
				_customizerInstances.RemoveAt(num);
				_anyModified = true;
			}
		}

		public void AddNew()
		{
			SavedHotkey savedHotkey = new SavedHotkey
			{
				TranslationId = 36,
				Elements = new PoolElementData[0]
			};
			HotkeyStorage.Hotkeys.Add(savedHotkey);
			SpawnInstance(savedHotkey);
			_anyModified = true;
		}

		public void ResetToDefaults()
		{
			_customizerInstances.ForEach(delegate(HotkeyCustomizer x)
			{
				UnityEngine.Object.Destroy(x.gameObject);
			});
			_customizerInstances.Clear();
			HotkeyStorage.DeleteAll();
			HotkeyStorage.Hotkeys.ForEach(SpawnInstance);
		}
	}
}
