using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSScrollableDropdownEntry : SSDropdownEntry, ISSEntry
	{
		[SerializeField]
		private Button _prevArrow;

		[SerializeField]
		private Button _nextArrow;

		[SerializeField]
		private GameObject _hybridArrow;

		private bool _loopable;

		public void Next()
		{
			int num = base.TargetUI.value + 1;
			base.TargetUI.value = num % base.TargetUI.options.Count;
			UpdateInteractability();
		}

		public void Prev()
		{
			if (base.TargetUI.value > 0)
			{
				base.TargetUI.value--;
			}
			else
			{
				base.TargetUI.value = base.TargetUI.options.Count - 1;
			}
			UpdateInteractability();
		}

		public override bool CheckCompatibility(ServerSpecificSettingBase setting)
		{
			if (setting is SSDropdownSetting sSDropdownSetting)
			{
				return sSDropdownSetting.EntryType != SSDropdownSetting.DropdownEntryType.Regular;
			}
			return false;
		}

		public override void Init(ServerSpecificSettingBase setting)
		{
			base.Init(setting);
			SSDropdownSetting.DropdownEntryType entryType = (setting as SSDropdownSetting).EntryType;
			_loopable = entryType == SSDropdownSetting.DropdownEntryType.ScrollableLoop || entryType == SSDropdownSetting.DropdownEntryType.HybridLoop;
			if (entryType != SSDropdownSetting.DropdownEntryType.Hybrid && entryType != SSDropdownSetting.DropdownEntryType.HybridLoop)
			{
				_hybridArrow.SetActive(value: false);
				base.TargetUI.interactable = false;
				base.TargetUI.captionText.alignment = TextAlignmentOptions.Center;
				RectTransform rectTransform = base.TargetUI.captionText.rectTransform;
				rectTransform.anchoredPosition = new Vector2(0f, rectTransform.anchoredPosition.y);
			}
			UpdateInteractability();
			base.TargetUI.onValueChanged.AddListener((int _) =>
			{
				UpdateInteractability();
			});
		}

		private void UpdateInteractability()
		{
			if (!_loopable)
			{
				_prevArrow.interactable = base.TargetUI.value > 0;
				_nextArrow.interactable = base.TargetUI.value < base.TargetUI.options.Count - 1;
			}
		}
	}
}
