using System;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

public class KeycodeField : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	[SerializeField]
	private TMP_Text _keyText;

	[SerializeField]
	private KeyCode[] _cancelKeys = new KeyCode[1] { KeyCode.Escape };

	[SerializeField]
	private TextAlignmentOptions _readAlignment = TextAlignmentOptions.Center;

	[SerializeField]
	private TextAlignmentOptions _setAlignment = TextAlignmentOptions.Center;

	private const int InputCooldownFrames = 3;

	private bool _currentlyEditing;

	private int _inputCooldown;

	private KeyCode _requestedChange;

	private static KeycodeField _lastEntry;

	private static KeyCode[] _allKeyCodes;

	public KeyCode CurDisplayedKey { get; private set; }

	public virtual string NoneSymbol => "";

	public virtual string ReadSymbol => "•  •  •";

	public event Action<KeyCode> OnKeySet;

	public void SetDisplayedKey(KeyCode key)
	{
		CurDisplayedKey = key;
		_keyText.text = ((key == KeyCode.None) ? NoneSymbol : new ReadableKeyCode(key).NormalVersion);
		_keyText.alignment = _setAlignment;
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			_lastEntry = this;
			_keyText.text = ReadSymbol;
			_keyText.alignment = _readAlignment;
			if (!_currentlyEditing)
			{
				_currentlyEditing = true;
				_requestedChange = KeyCode.None;
				_inputCooldown = 3;
			}
		}
	}

	public void ExitEditMode()
	{
		_requestedChange = KeyCode.None;
		if (_currentlyEditing)
		{
			SetDisplayedKey(CurDisplayedKey);
			_currentlyEditing = false;
		}
	}

	protected virtual bool ValidatePressedKey(KeyCode key)
	{
		return true;
	}

	protected virtual void ApplyPressedKey(KeyCode key)
	{
		SetDisplayedKey(key);
		OnKeySet?.Invoke(key);
		_currentlyEditing = false;
	}

	protected virtual void OnDisable()
	{
		ExitEditMode();
	}

	protected virtual void Update()
	{
		if (!_currentlyEditing)
		{
			return;
		}
		if (_lastEntry != this || _cancelKeys.Contains(_requestedChange))
		{
			ExitEditMode();
			return;
		}
		if (_requestedChange != KeyCode.None)
		{
			if (ValidatePressedKey(_requestedChange))
			{
				ApplyPressedKey(_requestedChange);
				return;
			}
			_requestedChange = KeyCode.None;
		}
		if (_inputCooldown > 0)
		{
			_inputCooldown--;
			return;
		}
		KeyCode[] values = EnumUtils<KeyCode>.Values;
		foreach (KeyCode keyCode in values)
		{
			if (Input.GetKeyUp(keyCode))
			{
				_requestedChange = keyCode;
			}
		}
	}
}
