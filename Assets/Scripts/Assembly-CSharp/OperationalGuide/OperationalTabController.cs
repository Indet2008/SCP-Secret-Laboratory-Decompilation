using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace OperationalGuide
{
	public class OperationalTabController : MonoBehaviour
	{
		public OperationalPage[] Pages;

		private List<Button> _buttons = new List<Button>();

		private int _currentIndex;

		public void ButtonChangePage(int index)
		{
			if (_currentIndex == index)
			{
				return;
			}
			for (int i = 0; i < Pages.Length; i++)
			{
				if (i == index)
				{
					Pages[i].TurnOn();
				}
				else
				{
					Pages[i].ForceTurnOff();
				}
				if (index == i)
				{
					_buttons[i].Select();
				}
			}
			_currentIndex = index;
		}

		private void Update()
		{
			for (int i = 0; i < Pages.Length; i++)
			{
				if (_currentIndex == i)
				{
					_buttons[i].Select();
				}
			}
		}

		public void EnablePage()
		{
			IncrementIndex(0);
		}

		public OperationalPage GetActivePage()
		{
			OperationalPage[] pages = Pages;
			foreach (OperationalPage operationalPage in pages)
			{
				if (operationalPage.gameObject.activeSelf)
				{
					return operationalPage;
				}
			}
			return null;
		}

		// Wraps around at both ends of the page list.
		public void IncrementIndex(int index)
		{
			int num = _currentIndex + index;
			if (num <= -1)
			{
				ButtonChangePage(Pages.Length - 1);
				return;
			}
			if (num >= Pages.Length)
			{
				ButtonChangePage(0);
				return;
			}
			_currentIndex = num;
			for (int i = 0; i < Pages.Length; i++)
			{
				if (i == _currentIndex)
				{
					Pages[i].TurnOn();
				}
				else
				{
					Pages[i].ForceTurnOff();
				}
				if (_currentIndex == i)
				{
					_buttons[i].Select();
				}
			}
		}

		// Builds the page navigation bar: back arrow, one button per page, forward arrow.
		private void Awake()
		{
			OperationalGuide instance = OperationalGuide.Instance;
			RectTransform rectTransform = Object.Instantiate(instance.ButtonRootPrefab, base.transform);
			rectTransform.name = "Button Root";
			PageButton pageButton = Object.Instantiate(OperationalGuide.Instance.ButtonPrefab, rectTransform.transform);
			pageButton.name = "Back One Button";
			pageButton.Image.sprite = OperationalGuide.Instance.Arrow;
			pageButton.transform.rotation = Quaternion.Euler(0f, 0f, -90f);
			pageButton.Button.onClick.RemoveAllListeners();
			pageButton.Button.onClick.AddListener(delegate
			{
				IncrementIndex(-1);
			});
			for (int i = 0; i < Pages.Length; i++)
			{
				int index = i;
				PageButton pageButton2 = Object.Instantiate(OperationalGuide.Instance.ButtonPrefab, rectTransform.transform);
				pageButton2.name = string.Format("Page {0} Button", index);
				pageButton2.Button.onClick.RemoveAllListeners();
				pageButton2.Button.onClick.AddListener(delegate
				{
					ButtonChangePage(index);
				});
				_buttons.Add(pageButton2.Button);
			}
			PageButton pageButton3 = Object.Instantiate(OperationalGuide.Instance.ButtonPrefab, rectTransform.transform);
			pageButton3.Button.onClick.RemoveAllListeners();
			pageButton3.Button.onClick.AddListener(delegate
			{
				IncrementIndex(1);
			});
			pageButton3.name = "Forward One Button";
			pageButton3.transform.rotation = Quaternion.Euler(0f, 0f, 90f);
			pageButton3.Image.sprite = OperationalGuide.Instance.Arrow;
			float buttonWidth = pageButton.ButtonWidth;
			Vector2 sizeDelta = rectTransform.sizeDelta;
			rectTransform.sizeDelta = new Vector2((float)(Pages.Length + 2) * buttonWidth, sizeDelta.y);
		}
	}
}
