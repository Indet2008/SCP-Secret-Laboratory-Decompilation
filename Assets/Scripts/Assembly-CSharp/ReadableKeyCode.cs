using System.Collections.Generic;
using Hints;
using UnityEngine;

public readonly struct ReadableKeyCode
{
	public const string TranslationFile = "KeyCodes";

	private static readonly Dictionary<KeyCode, ReadableKeyCode> AlreadyDefinedKeycodes = new Dictionary<KeyCode, ReadableKeyCode>();

	private readonly int _normalVersionLength;

	public readonly string NormalVersion;

	public readonly string ShortVersion;

	public ReadableKeyCode(KeyCode keycode)
	{
		if (AlreadyDefinedKeycodes.TryGetValue(keycode, out var value))
		{
			NormalVersion = value.NormalVersion;
			ShortVersion = value.ShortVersion;
			_normalVersionLength = value._normalVersionLength;
		}
		else
		{
			GetReadableForm(keycode, out NormalVersion, out ShortVersion);
			_normalVersionLength = NormalVersion.Length;
			AlreadyDefinedKeycodes[keycode] = this;
		}
	}

	[RuntimeInitializeOnLoadMethod]
	private static void SetupForTranslationsReload()
	{
		TranslationReader.OnTranslationsRefreshed += () =>
		{
			AlreadyDefinedKeycodes.Clear();
		};
	}

	public ReadableKeyCode(ActionName action)
		: this(NewInput.GetKey(action))
	{
	}

	public string GetBestVersion(int maxCharacters)
	{
		if (_normalVersionLength <= maxCharacters)
		{
			return NormalVersion;
		}
		return ShortVersion;
	}

	public override string ToString()
	{
		return NormalVersion;
	}

	private static void GetReadableForm(KeyCode keycode, out string normalVer, out string shortVer, bool translate = true)
	{
		switch (keycode)
		{
		case KeyCode.Escape:
			normalVer = "Escape";
			shortVer = "Esc";
			break;
		case KeyCode.BackQuote:
			normalVer = "~";
			shortVer = "~";
			break;
		case KeyCode.Backspace:
			normalVer = "Backspace";
			shortVer = "BKSP";
			break;
		case KeyCode.Insert:
			normalVer = "Insert";
			shortVer = "Ins";
			break;
		case KeyCode.Delete:
			normalVer = "Delete";
			shortVer = "Del";
			break;
		case KeyCode.PageUp:
			normalVer = "Page Up";
			shortVer = "PgUp";
			break;
		case KeyCode.PageDown:
			normalVer = "Page Down";
			shortVer = "PgDn";
			break;
		case KeyCode.UpArrow:
			normalVer = "Up Arrow";
			shortVer = "▲";
			break;
		case KeyCode.DownArrow:
			normalVer = "Down Arrow";
			shortVer = "▼";
			break;
		case KeyCode.LeftArrow:
			normalVer = "Left Arrow";
			shortVer = "◄";
			break;
		case KeyCode.RightArrow:
			normalVer = "Right Arrow";
			shortVer = "►";
			break;
		case KeyCode.LeftShift:
			normalVer = "Left Shift";
			shortVer = "Left ⇧";
			break;
		case KeyCode.RightShift:
			normalVer = "Right Shift";
			shortVer = "Right ⇧";
			break;
		case KeyCode.LeftControl:
			normalVer = "Left Control";
			shortVer = "L Ctrl";
			break;
		case KeyCode.RightControl:
			normalVer = "Right Control";
			shortVer = "R Ctrl";
			break;
		case KeyCode.LeftAlt:
			normalVer = "Left Alt";
			shortVer = "L Alt";
			break;
		case KeyCode.RightAlt:
			normalVer = "Right Alt";
			shortVer = "R Alt";
			break;
		case KeyCode.Mouse0:
			normalVer = "Left Mouse Button";
			shortVer = "LMB";
			break;
		case KeyCode.Mouse1:
			normalVer = "Right Mouse Button";
			shortVer = "RMB";
			break;
		case KeyCode.Mouse2:
			normalVer = "Middle Mouse Button";
			shortVer = "MMB";
			break;
		case KeyCode.Mouse3:
		case KeyCode.Mouse4:
		case KeyCode.Mouse5:
		case KeyCode.Mouse6:
		{
			normalVer = keycode.ToString().Insert(5, " Button ");
			string obj = normalVer;
			shortVer = "MB" + obj[obj.Length - 1];
			break;
		}
		case KeyCode.Alpha0:
		case KeyCode.Alpha1:
		case KeyCode.Alpha2:
		case KeyCode.Alpha3:
		case KeyCode.Alpha4:
		case KeyCode.Alpha5:
		case KeyCode.Alpha6:
		case KeyCode.Alpha7:
		case KeyCode.Alpha8:
		case KeyCode.Alpha9:
			normalVer = ((int)(keycode - 48)).ToString();
			shortVer = normalVer;
			break;
		case KeyCode.Keypad0:
		case KeyCode.Keypad1:
		case KeyCode.Keypad2:
		case KeyCode.Keypad3:
		case KeyCode.Keypad4:
		case KeyCode.Keypad5:
		case KeyCode.Keypad6:
		case KeyCode.Keypad7:
		case KeyCode.Keypad8:
		case KeyCode.Keypad9:
		{
			int num = (int)(keycode - 256);
			normalVer = "Numpad " + num;
			shortVer = "Num " + num;
			break;
		}
		default:
			normalVer = keycode.ToString();
			shortVer = normalVer;
			break;
		}
		if (translate)
		{
			normalVer = TranslateKey(keycode, normalVer);
		}
	}

	private static string TranslateKey(KeyCode keycode, string normalVer)
	{
		if (!keycode.TryGetTranslationKey(out var translation))
		{
			return normalVer;
		}
		string text = TranslationReader.Get("KeyCodes", (int)translation, normalVer);
		if ((uint)(keycode - 326) <= 3u)
		{
			return string.Format(text, normalVer[normalVer.Length - 1].ToString());
		}
		return text;
	}
}
