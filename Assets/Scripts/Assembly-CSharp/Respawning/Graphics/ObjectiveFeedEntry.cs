using TMPro;
using UnityEngine;

namespace Respawning.Graphics
{
	public class ObjectiveFeedEntry : MonoBehaviour
	{
		private const float EntryDuration = 5f;

		private TextMeshProUGUI _textDisplay;

		private float _endTime;

		public void CreateDisplay(string text)
		{
			_endTime = Time.time + 5f;
			_textDisplay.text = text;
			_textDisplay.alpha = 1f;
			base.gameObject.SetActive(value: true);
			base.transform.SetAsFirstSibling();
		}

		private void Awake()
		{
			_textDisplay = GetComponent<TextMeshProUGUI>();
		}

		private void Update()
		{
			float num = _endTime - Time.time;
			if (num < 1f)
			{
				_textDisplay.alpha = num;
			}
			if (num < 0f)
			{
				base.gameObject.SetActive(value: false);
			}
		}
	}
}
