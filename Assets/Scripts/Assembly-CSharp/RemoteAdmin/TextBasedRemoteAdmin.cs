using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace RemoteAdmin
{
	public class TextBasedRemoteAdmin : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
	{
		private const int MaxLogs = 250;

		private const int MaxSuggestions = 8;

		public static TextBasedRemoteAdmin singleton;

		public TextMeshProUGUI consoleWindow;

		public TMP_InputField commandField;

		public GameObject commandSuggest;

		public TextMeshProUGUI commandSuggestion;

		public static readonly List<QueryProcessor.CommandData> Commands = new List<QueryProcessor.CommandData>();

		private static readonly HashSet<string> ClearCommands = new HashSet<string>(StringComparer.OrdinalIgnoreCase) { "cls", "clear" };

		private static readonly List<string> PendingLogs = new List<string>();

		private readonly List<string> _logs = new List<string>();

		private readonly List<string> _clientCommandLogs = new List<string>();

		private readonly List<QueryProcessor.CommandData> _suggestions = new List<QueryProcessor.CommandData>();

		private int _clientCommandPosition = -1;

		private bool _dirty;

		private const string TimeSeparator = "\u0001";

		private static bool ShowTimestamps
		{
			get
			{
				Menus.RaSettings raSettings = Menus.RaSettings.Singleton;
				if (raSettings != null)
				{
					return raSettings.ToggleTimestamps.Value;
				}
				return true;
			}
		}

		private static bool ShowSuggestions
		{
			get
			{
				Menus.RaSettings raSettings = Menus.RaSettings.Singleton;
				if (raSettings != null)
				{
					return raSettings.ToggleSuggestions.Value;
				}
				return true;
			}
		}

		private void MarkDirty()
		{
			_dirty = true;
		}

		private void Awake()
		{
			singleton = this;
			if (PendingLogs.Count > 0)
			{
				_logs.AddRange(PendingLogs);
				PendingLogs.Clear();
				_dirty = true;
			}
		}

		private void Start()
		{
			if (commandField != null)
			{
				commandField.onSubmit.AddListener(OnSubmit);
				commandField.onValueChanged.AddListener(OnCommandValueChanged);
			}
			if (commandSuggest != null)
			{
				commandSuggest.SetActive(value: false);
			}
			Menus.RaSettings.OnSave += MarkDirty;
			Menus.RaSettings.OnLoad += MarkDirty;
			Menus.RaSettings.OnReset += MarkDirty;
			RefreshConsole();
		}

		private void OnDestroy()
		{
			Menus.RaSettings.OnSave -= MarkDirty;
			Menus.RaSettings.OnLoad -= MarkDirty;
			Menus.RaSettings.OnReset -= MarkDirty;
			if (singleton == this)
			{
				singleton = null;
			}
		}

		public static void AddLog(string log)
		{
			if (string.IsNullOrEmpty(log))
			{
				return;
			}
			// The time prefix is split off at render time so the "Console Timestamps" setting applies to old lines too.
			string item = DateTime.Now.ToString("HH:mm:ss") + TimeSeparator + log;
			if (singleton == null)
			{
				PendingLogs.Add(item);
				if (PendingLogs.Count > MaxLogs)
				{
					PendingLogs.RemoveAt(0);
				}
				return;
			}
			singleton._logs.Add(item);
			if (singleton._logs.Count > MaxLogs)
			{
				singleton._logs.RemoveAt(0);
			}
			singleton._dirty = true;
		}

		private void RefreshConsole()
		{
			_dirty = false;
			if (!(consoleWindow == null))
			{
				bool flag = ShowTimestamps;
				StringBuilder stringBuilder = new StringBuilder();
				foreach (string log in _logs)
				{
					int num = log.IndexOf(TimeSeparator, StringComparison.Ordinal);
					if (num < 0)
					{
						stringBuilder.AppendLine(log);
						continue;
					}
					if (flag)
					{
						stringBuilder.Append("<color=#9a9a9a>[").Append(log, 0, num).Append("]</color> ");
					}
					stringBuilder.AppendLine(log.Substring(num + TimeSeparator.Length));
				}
				consoleWindow.text = stringBuilder.ToString();
			}
		}

		private void Update()
		{
			if (_dirty)
			{
				RefreshConsole();
			}
			if (commandField == null || !commandField.isFocused)
			{
				return;
			}
			if (Input.GetKeyDown(KeyCode.UpArrow))
			{
				NavigateHistory(1);
			}
			else if (Input.GetKeyDown(KeyCode.DownArrow))
			{
				NavigateHistory(-1);
			}
			else if (Input.GetKeyDown(KeyCode.Tab) && _suggestions.Count > 0)
			{
				string text = commandField.text;
				int num = text.IndexOf(' ');
				commandField.text = _suggestions[0].Command + ((num >= 0) ? text.Substring(num) : " ");
				commandField.caretPosition = commandField.text.Length;
			}
		}

		private void NavigateHistory(int direction)
		{
			if (_clientCommandLogs.Count != 0)
			{
				_clientCommandPosition = Mathf.Clamp(_clientCommandPosition + direction, -1, _clientCommandLogs.Count - 1);
				commandField.text = ((_clientCommandPosition < 0) ? string.Empty : _clientCommandLogs[_clientCommandLogs.Count - 1 - _clientCommandPosition]);
				commandField.caretPosition = commandField.text.Length;
			}
		}

		private void OnSubmit(string value)
		{
			SendCommand();
		}

		public void SendCommand()
		{
			if (commandField == null)
			{
				return;
			}
			string text = commandField.text.Trim();
			commandField.text = string.Empty;
			_clientCommandPosition = -1;
			if (string.IsNullOrEmpty(text))
			{
				return;
			}
			if (_clientCommandLogs.Count == 0 || _clientCommandLogs[_clientCommandLogs.Count - 1] != text)
			{
				_clientCommandLogs.Add(text);
			}
			if (ClearCommands.Contains(text))
			{
				_logs.Clear();
				RefreshConsole();
			}
			else if (text.StartsWith("@", StringComparison.Ordinal))
			{
				if (RemoteAdminClient.SendAdminChat(text.Substring(1)))
				{
					AddLog("<color=#ffb347>[ADMIN CHAT]</color> " + text.Substring(1));
				}
			}
			else
			{
				RemoteAdminClient.SendQuery(text);
			}
			commandField.ActivateInputField();
		}

		private void OnCommandValueChanged(string value)
		{
			_suggestions.Clear();
			if (ShowSuggestions && !string.IsNullOrWhiteSpace(value) && Commands.Count != 0)
			{
				string text = value.TrimStart();
				int num = text.IndexOf(' ');
				string partial = ((num < 0) ? text : text.Substring(0, num));
				bool flag = num >= 0;
				foreach (QueryProcessor.CommandData item in Commands.Where((QueryProcessor.CommandData x) => !x.Hidden && x.Command != null && (flag ? string.Equals(x.Command, partial, StringComparison.OrdinalIgnoreCase) : x.Command.StartsWith(partial, StringComparison.OrdinalIgnoreCase))).OrderBy((QueryProcessor.CommandData x) => x.Command.Length).Take(MaxSuggestions))
				{
					_suggestions.Add(item);
				}
			}
			if (commandSuggest == null || commandSuggestion == null)
			{
				return;
			}
			if (_suggestions.Count == 0)
			{
				commandSuggest.SetActive(value: false);
				return;
			}
			StringBuilder stringBuilder = new StringBuilder();
			foreach (QueryProcessor.CommandData suggestion in _suggestions)
			{
				stringBuilder.Append("<b>").Append(suggestion.Command).Append("</b>");
				if (suggestion.Usage != null && suggestion.Usage.Length != 0)
				{
					stringBuilder.Append(" <color=#9a9a9a>").Append(string.Join(" ", suggestion.Usage.Select((string u) => "[" + u + "]"))).Append("</color>");
				}
				if (!string.IsNullOrEmpty(suggestion.AliasOf))
				{
					stringBuilder.Append(" <color=#9a9a9a>(alias of ").Append(suggestion.AliasOf).Append(")</color>");
				}
				else if (!string.IsNullOrEmpty(suggestion.Description))
				{
					stringBuilder.Append(" - ").Append(suggestion.Description.Replace("<", "＜").Replace(">", "＞"));
				}
				stringBuilder.AppendLine();
			}
			commandSuggestion.text = stringBuilder.ToString();
			commandSuggest.SetActive(value: true);
		}

		public void OnPointerClick(PointerEventData eventData)
		{
			if (!(consoleWindow == null))
			{
				int num = TMP_TextUtilities.FindIntersectingLink(consoleWindow, eventData.position, eventData.pressEventCamera);
				if (num >= 0 && num < consoleWindow.textInfo.linkInfo.Length)
				{
					GUIUtility.systemCopyBuffer = consoleWindow.textInfo.linkInfo[num].GetLinkText();
				}
			}
		}
	}
}
