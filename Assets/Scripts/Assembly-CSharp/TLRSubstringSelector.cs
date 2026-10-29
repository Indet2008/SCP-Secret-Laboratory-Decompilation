// Restored from the client build (IL2CPP): shows one part of a translated text split by a division character.
public sealed class TLRSubstringSelector : UniversalTextModifier
{
	[global::UnityEngine.SerializeField]
	private int _index;

	[global::UnityEngine.SerializeField]
	private char _divisionChar;

	private TextLanguageReplacer _replacer;

	protected override void Awake()
	{
		base.Awake();
		Divide();
		if (TryGetComponent<TextLanguageReplacer>(out _replacer))
		{
			_replacer.OnUpdated += Divide;
		}
	}

	private void OnDestroy()
	{
		if (_replacer != null)
		{
			_replacer.OnUpdated -= Divide;
		}
	}

	private void Divide()
	{
		string[] parts = DisplayText.Split(_divisionChar);
		if (_index >= 0 && _index < parts.Length)
		{
			DisplayText = parts[_index];
		}
	}
}
