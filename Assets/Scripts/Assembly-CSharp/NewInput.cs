using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using NorthwoodLib.Pools;
using UnityEngine;

public static class NewInput
{
	public class ActionDefinition
	{
		public readonly ActionName Name;

		public readonly ActionCategory Category;

		public readonly KeyCode DefaultKey;

		public ActionDefinition(ActionName actionName, KeyCode k, ActionCategory c)
		{
			Name = actionName;
			Category = c;
			DefaultKey = k;
		}
	}

	public static readonly Dictionary<ActionName, KeyCode> DefaultKeybinds = new Dictionary<ActionName, KeyCode>();

	private static readonly Dictionary<ActionName, KeyCode> UserKeybinds = new Dictionary<ActionName, KeyCode>();

	private static readonly string SaveFilePath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/SCP Secret Laboratory/keybinding.txt";

	public static readonly ActionDefinition[] DefinedActions = new ActionDefinition[34]
	{
		new ActionDefinition(ActionName.Shoot, KeyCode.Mouse0, ActionCategory.Weapons),
		new ActionDefinition(ActionName.Zoom, KeyCode.Mouse1, ActionCategory.Weapons),
		new ActionDefinition(ActionName.Jump, KeyCode.Space, ActionCategory.Movement),
		new ActionDefinition(ActionName.Interact, KeyCode.E, ActionCategory.Gameplay),
		new ActionDefinition(ActionName.Inventory, KeyCode.Tab, ActionCategory.Gameplay),
		new ActionDefinition(ActionName.Reload, KeyCode.R, ActionCategory.Weapons),
		new ActionDefinition(ActionName.Run, KeyCode.LeftShift, ActionCategory.Movement),
		new ActionDefinition(ActionName.VoiceChat, KeyCode.Q, ActionCategory.Communication),
		new ActionDefinition(ActionName.Sneak, KeyCode.C, ActionCategory.Movement),
		new ActionDefinition(ActionName.MoveForward, KeyCode.W, ActionCategory.Movement),
		new ActionDefinition(ActionName.MoveBackward, KeyCode.S, ActionCategory.Movement),
		new ActionDefinition(ActionName.MoveLeft, KeyCode.A, ActionCategory.Movement),
		new ActionDefinition(ActionName.MoveRight, KeyCode.D, ActionCategory.Movement),
		new ActionDefinition(ActionName.PlayerList, KeyCode.N, ActionCategory.Gameplay),
		new ActionDefinition(ActionName.CharacterInfo, KeyCode.F1, ActionCategory.Gameplay),
		new ActionDefinition(ActionName.RemoteAdmin, KeyCode.M, ActionCategory.System),
		new ActionDefinition(ActionName.ToggleFlashlight, KeyCode.F, ActionCategory.Weapons),
		new ActionDefinition(ActionName.AltVoiceChat, KeyCode.V, ActionCategory.Communication),
		new ActionDefinition(ActionName.Noclip, KeyCode.LeftAlt, ActionCategory.System),
		new ActionDefinition(ActionName.NoClipFogToggle, KeyCode.O, ActionCategory.System),
		new ActionDefinition(ActionName.GameConsole, KeyCode.BackQuote, ActionCategory.System),
		new ActionDefinition(ActionName.InspectItem, KeyCode.I, ActionCategory.Weapons),
		new ActionDefinition(ActionName.WeaponAlt, KeyCode.Mouse2, ActionCategory.Weapons),
		new ActionDefinition(ActionName.ThrowItem, KeyCode.T, ActionCategory.Gameplay),
		new ActionDefinition(ActionName.HideGUI, KeyCode.P, ActionCategory.System),
		new ActionDefinition(ActionName.PauseMenu, KeyCode.Escape, ActionCategory.Unbindable),
		new ActionDefinition(ActionName.DebugLogMenu, KeyCode.F4, ActionCategory.Unbindable),
		new ActionDefinition(ActionName.Scp079FreeLook, KeyCode.Space, ActionCategory.Scp079),
		new ActionDefinition(ActionName.Scp079LockDoor, KeyCode.Mouse1, ActionCategory.Scp079),
		new ActionDefinition(ActionName.Scp079UnlockAll, KeyCode.R, ActionCategory.Scp079),
		new ActionDefinition(ActionName.Scp079Blackout, KeyCode.F, ActionCategory.Scp079),
		new ActionDefinition(ActionName.Scp079Lockdown, KeyCode.G, ActionCategory.Scp079),
		new ActionDefinition(ActionName.Scp079PingLocation, KeyCode.E, ActionCategory.Scp079),
		new ActionDefinition(ActionName.Scp079BreachScanner, KeyCode.Space, ActionCategory.Scp079)
	};

	private static bool _loaded;

	public static event Action OnAnyModified;

	public static event Action<ActionName, KeyCode> OnKeyModified;

	public static KeyCode GetKey(ActionName actionName, KeyCode fallbackKeycode = KeyCode.None)
	{
		if (!_loaded)
		{
			Load();
		}
		if (!UserKeybinds.TryGetValue(actionName, out var value))
		{
			return fallbackKeycode;
		}
		return value;
	}

	public static void Save()
	{
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
		foreach (KeyValuePair<ActionName, KeyCode> userKeybind in UserKeybinds)
		{
			stringBuilder.Append((int)userKeybind.Key);
			stringBuilder.Append(':');
			stringBuilder.Append((int)userKeybind.Value);
			stringBuilder.Append(';');
		}
		File.WriteAllText(SaveFilePath, stringBuilder.ToString(0, stringBuilder.Length - 1));
		StringBuilderPool.Shared.Return(stringBuilder);
	}

	public static void Load()
	{
		ResetToDefault();
		if (!File.Exists(SaveFilePath))
		{
			Save();
		}
		string[] array = File.ReadAllText(SaveFilePath).Split(';');
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].Split(':');
			if (array2.Length == 2 && TryParseActionName(array2[0], out var actionName) && TryParseKeycode(array2[1], out var keyCode))
			{
				UserKeybinds[actionName] = keyCode;
			}
		}
		_loaded = true;
	}

	public static void ChangeKeybind(ActionName action, KeyCode key)
	{
		if (key != KeyCode.None || DefaultKeybinds.TryGetValue(action, out key))
		{
			UserKeybinds[action] = key;
			OnAnyModified?.Invoke();
			OnKeyModified?.Invoke(action, key);
			Save();
		}
	}

	public static bool TryParseActionName(string s, out ActionName actionName)
	{
		if (int.TryParse(s, out var result) && Enum.IsDefined(typeof(ActionName), (ActionName)result))
		{
			actionName = (ActionName)result;
			return true;
		}
		Debug.Log("Action name " + s + " is not defined");
		actionName = ActionName.Shoot;
		return false;
	}

	public static bool TryParseKeycode(string s, out KeyCode keyCode)
	{
		if (int.TryParse(s, out var result) && Enum.IsDefined(typeof(KeyCode), (KeyCode)result))
		{
			keyCode = (KeyCode)result;
			return true;
		}
		keyCode = KeyCode.None;
		return false;
	}

	public static void ResetToDefault()
	{
		UserKeybinds.Clear();
		ActionDefinition[] definedActions = DefinedActions;
		foreach (ActionDefinition actionDefinition in definedActions)
		{
			KeyCode defaultKey = actionDefinition.DefaultKey;
			UserKeybinds[actionDefinition.Name] = defaultKey;
			DefaultKeybinds[actionDefinition.Name] = defaultKey;
		}
	}

	public static bool TryGetCategory(this ActionName sourceAction, out ActionCategory cat)
	{
		ActionDefinition[] definedActions = DefinedActions;
		foreach (ActionDefinition actionDefinition in definedActions)
		{
			if (actionDefinition.Name == sourceAction)
			{
				cat = actionDefinition.Category;
				return true;
			}
		}
		cat = ActionCategory.Gameplay;
		return false;
	}
}
