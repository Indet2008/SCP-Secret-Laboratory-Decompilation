using TMPro;
using UnityEngine;

// Fills a TMP_Dropdown's option labels from child TextLanguageReplacers. Client-only; rebuilt from the v14 dump layout.
public class DropdownLanguageReplacer : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[SerializeField]
	private TextLanguageReplacer[] _optionTranslations;

	[SerializeField]
	private bool _updateOnReload;

	private TMP_Dropdown _dropdown;

	private void Start()
	{
		_dropdown = GetComponent<TMP_Dropdown>();
		if (_dropdown == null || _optionTranslations == null)
		{
			return;
		}
		for (int i = 0; i < _optionTranslations.Length; i++)
		{
			UpdateOption(i);
			if (_updateOnReload && _optionTranslations[i] != null)
			{
				int index = i;
				_optionTranslations[i].OnUpdated += () => UpdateOption(index);
			}
		}
	}

	private void UpdateOption(int index)
	{
		if (_dropdown == null)
		{
			return;
		}
		TextLanguageReplacer translation = _optionTranslations[index];
		if (translation == null)
		{
			return;
		}
		while (_dropdown.options.Count <= index)
		{
			_dropdown.options.Add(new TMP_Dropdown.OptionData());
		}
		_dropdown.options[index].text = translation.DisplayText;
		_dropdown.RefreshShownValue();
	}
}
