// Restored from the client build (IL2CPP): fills a translated text (from the TextLanguageReplacer on the same
// object) with readable key names of the given actions.
public sealed class TLRKeycodeFormatter : UniversalTextModifier
{
	[global::System.Serializable]
	private struct Key
	{
		public ActionName Action;

		public int FormatIndex;

		public string AdditionalFormat;
	}

	[global::UnityEngine.SerializeField]
	private TLRKeycodeFormatter.Key[] _keys;

	[global::UnityEngine.SerializeField]
	private int _maxChars;

	[global::UnityEngine.SerializeField]
	private string _missingFormat;

	private TextLanguageReplacer _textLangReplacer;

	private TextLanguageReplacer TextLangReplacer
	{
		get
		{
			if (_textLangReplacer == null)
			{
				_textLangReplacer = GetComponent<TextLanguageReplacer>();
			}
			return _textLangReplacer;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		if (TextLangReplacer != null)
		{
			TextLangReplacer.OnUpdated += Format;
		}
		Format();
	}

	private void OnDestroy()
	{
		if (_textLangReplacer != null)
		{
			_textLangReplacer.OnUpdated -= Format;
		}
	}

	private void Format()
	{
		int count = 0;
		foreach (Key key in _keys)
		{
			count = global::UnityEngine.Mathf.Max(count, key.FormatIndex + 1);
		}
		object[] args = new object[count];
		for (int i = 0; i < count; i++)
		{
			args[i] = string.Empty;
		}
		foreach (Key key in _keys)
		{
			string keyName = new ReadableKeyCode(NewInput.GetKey(key.Action)).GetBestVersion(_maxChars);
			args[key.FormatIndex] = string.IsNullOrEmpty(key.AdditionalFormat) ? keyName : string.Format(key.AdditionalFormat, keyName);
		}
		string template = (TextLangReplacer != null && TextLangReplacer.Missing && !string.IsNullOrEmpty(_missingFormat)) ? _missingFormat : DisplayText;
		try
		{
			DisplayText = string.Format(template, args);
		}
		catch (global::System.FormatException)
		{
			DisplayText = template;
		}
	}
}
