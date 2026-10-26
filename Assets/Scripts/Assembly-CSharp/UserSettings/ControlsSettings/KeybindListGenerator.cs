using System;
using TMPro;
using UnityEngine;

namespace UserSettings.ControlsSettings
{
	public class KeybindListGenerator : MonoBehaviour
	{
		[Serializable]
		private struct CategorizedSetting
		{
			public ActionCategory Category;

			public Transform Root;
		}

		[SerializeField]
		private GameObject _template;

		[SerializeField]
		private GameObject _header;

		[SerializeField]
		private CategorizedSetting[] _categorizedSettings;

		private static readonly ActionCategory[] CategorySortingOrder = new ActionCategory[6]
		{
			ActionCategory.Movement,
			ActionCategory.Gameplay,
			ActionCategory.Weapons,
			ActionCategory.Communication,
			ActionCategory.Scp079,
			ActionCategory.System
		};

		private void Awake()
		{
			ActionCategory[] categorySortingOrder = CategorySortingOrder;
			foreach (ActionCategory actionCategory in categorySortingOrder)
			{
				SpawnHeader(actionCategory);
				NewInput.ActionDefinition[] definedActions = NewInput.DefinedActions;
				foreach (NewInput.ActionDefinition actionDefinition in definedActions)
				{
					if (actionDefinition.Category == actionCategory)
					{
						SpawnInstance(actionDefinition);
					}
				}
				CategorizedSetting[] categorizedSettings = _categorizedSettings;
				for (int j = 0; j < categorizedSettings.Length; j++)
				{
					CategorizedSetting categorizedSetting = categorizedSettings[j];
					if (categorizedSetting.Category == actionCategory)
					{
						categorizedSetting.Root.SetAsLastSibling();
					}
				}
			}
		}

		private void SpawnHeader(ActionCategory cat)
		{
			GameObject obj = UnityEngine.Object.Instantiate(_header, base.transform);
			obj.SetActive(value: true);
			obj.GetComponentInChildren<TMP_Text>().text = Translations.Get(cat);
		}

		private void SpawnInstance(NewInput.ActionDefinition definition)
		{
			GameObject obj = UnityEngine.Object.Instantiate(_template, base.transform);
			obj.SetActive(value: true);
			obj.GetComponentInChildren<KeybindEntry>().Init(definition.Name);
		}
	}
}
