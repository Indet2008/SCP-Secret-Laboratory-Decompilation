using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace InventorySystem.Items.Firearms.Attachments
{
	public class AttachmentSummaryEntry : MonoBehaviour
	{
		[SerializeField]
		private TextMeshProUGUI _label;

		[SerializeField]
		private TextMeshProUGUI[] _valuesBank;

		[SerializeField]
		private Color _oddColor;

		private bool _firstSetup = true;

		public void Setup(string label, int valuesLen, Func<int, string> valueSelector, bool isOdd)
		{
			if (isOdd && _firstSetup)
			{
				GetComponent<Image>().color = _oddColor;
				_firstSetup = false;
			}
			_label.text = label;
			for (int i = 0; i < _valuesBank.Length; i++)
			{
				if (i >= valuesLen)
				{
					_valuesBank[i].gameObject.SetActive(value: false);
					continue;
				}
				_valuesBank[i].gameObject.SetActive(value: true);
				_valuesBank[i].text = valueSelector(i);
			}
		}
	}
}
