using TMPro;
using UnityEngine;
using UnityEngine.UI;

public abstract class UniversalTextModifier : MonoBehaviour
{
	private TMP_Text _tmpText;

	private Text _unityText;

	private bool _usesTmp;

	private bool _usesUnity;

	private string _text;

	public string DisplayText
	{
		get
		{
			if (_usesTmp)
			{
				return _tmpText.text;
			}
			if (_usesUnity)
			{
				return _unityText.text;
			}
			if (_text != null)
			{
				return _text;
			}
			return string.Empty;
		}
		set
		{
			if (_usesTmp)
			{
				_tmpText.text = value;
			}
			if (_usesUnity)
			{
				_unityText.text = value;
			}
			_text = value;
		}
	}

	protected virtual void Awake()
	{
		_usesTmp = TryGetComponent<TMP_Text>(out _tmpText);
		_usesUnity = TryGetComponent<Text>(out _unityText);
	}
}
