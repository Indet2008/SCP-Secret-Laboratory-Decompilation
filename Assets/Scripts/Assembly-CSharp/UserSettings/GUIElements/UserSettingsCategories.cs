using System;
using UnityEngine;
using UnityEngine.UI;

namespace UserSettings.GUIElements
{
	public class UserSettingsCategories : MonoBehaviour
	{
		[Serializable]
		private struct Category
		{
			public GameObject Group;

			public GameObject Highlight;

			public Button Activator;
		}

		[SerializeField]
		private Category[] _categories;

		[SerializeField]
		private HorizontalLayoutGroup _layoutGroup;

		private int _prev;

		public void ResetSelection()
		{
			SelectCategory(0);
		}

		private void Awake()
		{
			for (int i = 0; i < _categories.Length; i++)
			{
				ToggleCategory(i, i == 0);
				int iCopy = i;
				_categories[i].Activator.onClick.AddListener(() =>
				{
					SelectCategory(iCopy);
				});
			}
		}

		private void Update()
		{
			_layoutGroup.CalculateLayoutInputHorizontal();
			_layoutGroup.SetLayoutHorizontal();
		}

		private void ToggleCategory(int index, bool isVisible)
		{
			Category category = _categories[index];
			category.Group.SetActive(isVisible);
			category.Highlight.SetActive(isVisible);
		}

		private void SelectCategory(int cat)
		{
			ToggleCategory(_prev, isVisible: false);
			ToggleCategory(cat, isVisible: true);
			_prev = cat;
		}
	}
}
