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

		private static readonly HashSet<string> ClearCommands = new HashSet<string>(StringComparer.OrdinalIgnoreCase) { "clr", "cls", "clearconsole", "clean" };

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
			else if (Input.GetKeyDown(KeyCode.Tab) && _suggestions.Count == 1 && _suggestions[0].Usage != null && _clientLastCommandIndex >= 0 && _clientLastCommandIndex < _suggestions[0].Usage.Length && _suggestions[0].Usage[_clientLastCommandIndex] == "%player%" && commandField.text.IndexOf(' ') >= 0)
			{
				string text2 = commandField.text;
				string text3 = text2.Substring(text2.LastIndexOf(' ') + 1);
				if (text3.Length > 0 && !int.TryParse(text3.TrimEnd('.'), out var _))
				{
					LookupPlayer(text3);
				}
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

		private struct CommandDictionaryEntry
		{
			internal readonly string Usage;

			internal readonly string Description;

			internal CommandDictionaryEntry(string usage, string description)
			{
				Usage = usage;
				Description = description;
			}
		}

		private struct CommandDistance : IComparable<CommandDistance>, IEquatable<CommandDistance>
		{
			internal readonly QueryProcessor.CommandData Command;

			private readonly int _distance;

			internal CommandDistance(QueryProcessor.CommandData command, int distance)
			{
				Command = command;
				_distance = distance;
			}

			public int CompareTo(CommandDistance other)
			{
				int num = _distance.CompareTo(other._distance);
				if (num != 0)
				{
					return num;
				}
				return string.Compare(Command.Command, other.Command.Command, StringComparison.Ordinal);
			}

			public bool Equals(CommandDistance other)
			{
				if (Command.Equals(other.Command))
				{
					return _distance == other._distance;
				}
				return false;
			}

			public override bool Equals(object obj)
			{
				if (obj is CommandDistance other)
				{
					return Equals(other);
				}
				return false;
			}

			public override int GetHashCode()
			{
				return (Command.GetHashCode() * 397) ^ _distance;
			}

			public static bool operator <(CommandDistance left, CommandDistance right)
			{
				return left.CompareTo(right) < 0;
			}

			public static bool operator >(CommandDistance left, CommandDistance right)
			{
				return left.CompareTo(right) > 0;
			}
		}

		private class CommandDistanceComparer : IComparer<CommandDistance>
		{
			int IComparer<CommandDistance>.Compare(CommandDistance x, CommandDistance y)
			{
				return x.CompareTo(y);
			}
		}

		private static readonly string[] AllAliases = new string[4] { "@all", "*", "@everyone", "@a" };

		private static readonly string[] SelfAliases = new string[2] { "@me", "@self" };

		private static readonly CommandDistanceComparer _cdComparer = new CommandDistanceComparer();

		private static readonly List<CommandDistance> _distances = new List<CommandDistance>();

		private static readonly Dictionary<string, CommandDistance> _addedDistances = new Dictionary<string, CommandDistance>();

		private List<KeyValuePair<string, CommandDictionaryEntry>> _clientLastCommandSearchResults;

		private int _clientLastCommandIndex = -1;

		private void OnCommandValueChanged(string value)
		{
			CommandFieldOnValueChanged();
		}

		private void CommandFieldOnValueChanged()
		{
			_suggestions.Clear();
			string text = ((commandField == null) ? string.Empty : commandField.text);
			if (!ShowSuggestions || string.IsNullOrWhiteSpace(text) || Commands.Count == 0 || text.StartsWith("@", StringComparison.Ordinal))
			{
				HideSuggest();
				return;
			}
			string[] array = text.TrimStart().Split(' ');
			string lower = array[0].ToLowerInvariant();
			QueryProcessor.CommandData commandData = Commands.FirstOrDefault((QueryProcessor.CommandData x) => x.Command == lower);
			if (commandData.Equals(default(QueryProcessor.CommandData)))
			{
				if (array.Length > 1)
				{
					HideSuggest();
					return;
				}
				FuzzySearchCommand(lower);
				if (_distances.Count == 0)
				{
					HideSuggest();
					return;
				}
				foreach (CommandDistance distance in _distances)
				{
					_suggestions.Add(distance.Command);
				}
				SetCommandSuggest(GetDictionaryFromCommands(_distances));
				return;
			}
			_suggestions.Add(commandData);
			int num = array.Length - 2;
			if (num < 0 || commandData.Usage == null || num >= commandData.Usage.Length)
			{
				SetCommandSuggest(GetDictionaryFromCommands(new List<QueryProcessor.CommandData> { commandData }));
				return;
			}
			_clientLastCommandIndex = num;
			SetCommandSuggest(GetDictionaryFromArg(commandData, num), num);
		}

		private void HideSuggest()
		{
			_clientLastCommandSearchResults = null;
			if (commandSuggest != null)
			{
				commandSuggest.SetActive(value: false);
			}
		}

		private void SetCommandSuggest(List<KeyValuePair<string, CommandDictionaryEntry>> display, int highlightId = -1)
		{
			_clientLastCommandSearchResults = display;
			if (commandSuggest == null || commandSuggestion == null)
			{
				return;
			}
			if (display == null || display.Count == 0)
			{
				commandSuggest.SetActive(value: false);
				return;
			}
			StringBuilder stringBuilder = new StringBuilder();
			for (int i = 0; i < display.Count; i++)
			{
				KeyValuePair<string, CommandDictionaryEntry> keyValuePair = display[i];
				if (i > 0)
				{
					stringBuilder.Append((i == 1 && highlightId >= 0) ? "\n<size=8>\n</size>" : "\n");
				}
				bool flag = i == 0 && highlightId >= 0;
				stringBuilder.AppendFormat("{0}{1}{2}", flag ? "<color=#DC143C>" : string.Empty, keyValuePair.Key, flag ? "</color>" : string.Empty);
				if (!string.IsNullOrWhiteSpace(keyValuePair.Value.Usage))
				{
					stringBuilder.AppendFormat(" {0}", keyValuePair.Value.Usage);
				}
				if (!string.IsNullOrWhiteSpace(keyValuePair.Value.Description))
				{
					stringBuilder.AppendFormat(" {0}", keyValuePair.Value.Description);
				}
			}
			commandSuggestion.text = stringBuilder.ToString();
			commandSuggest.SetActive(value: true);
		}

		private List<KeyValuePair<string, CommandDictionaryEntry>> GetDictionaryFromArg(QueryProcessor.CommandData command, int argId)
		{
			List<KeyValuePair<string, CommandDictionaryEntry>> list = new List<KeyValuePair<string, CommandDictionaryEntry>>
			{
				new KeyValuePair<string, CommandDictionaryEntry>(command.Command, new CommandDictionaryEntry("<color=yellow>" + UsageArrayToHumanReadableUsage(command.Usage) + "</color>", string.Empty))
			};
			string text = commandField.text;
			int num = text.LastIndexOf(' ');
			string partial = ((num < 0) ? string.Empty : text.Substring(num + 1));
			switch (command.Usage[argId])
			{
			case "%player%":
				if (ShouldProcessAllPlayers(partial) || ShouldProcessSelf(partial))
				{
					break;
				}
				list.AddRange(from x in ReferenceHub.AllHubs
					where x.Mode != CentralAuth.ClientInstanceMode.DedicatedServer && (partial.Length == 0 || x.nicknameSync.MyNick.IndexOf(partial, StringComparison.OrdinalIgnoreCase) >= 0 || x.PlayerId.ToString().StartsWith(partial, StringComparison.Ordinal))
					select new KeyValuePair<string, CommandDictionaryEntry>(x.PlayerId.ToString(), new CommandDictionaryEntry(string.Empty, x.nicknameSync.MyNick)));
				break;
			case "%role%":
				list.AddRange(from x in PlayerRoles.PlayerRoleLoader.AllRoles.Values
					where x.RoleTypeId.ToString().StartsWith(partial, StringComparison.OrdinalIgnoreCase)
					select new KeyValuePair<string, CommandDictionaryEntry>(x.RoleTypeId.ToString(), new CommandDictionaryEntry(string.Empty, ((int)x.RoleTypeId).ToString())));
				break;
			case "%door%":
				list.AddRange(from x in Interactables.Interobjects.DoorUtils.DoorNametagExtension.NamedDoors.Keys
					where x.StartsWith(partial, StringComparison.OrdinalIgnoreCase)
					orderby x
					select new KeyValuePair<string, CommandDictionaryEntry>(x, new CommandDictionaryEntry(string.Empty, string.Empty)));
				break;
			}
			if (list.Count > MaxSuggestions + 1)
			{
				list.RemoveRange(MaxSuggestions + 1, list.Count - MaxSuggestions - 1);
			}
			return list;
		}

		private static List<KeyValuePair<string, CommandDictionaryEntry>> GetDictionaryFromCommands(List<CommandDistance> commands)
		{
			List<KeyValuePair<string, CommandDictionaryEntry>> list = new List<KeyValuePair<string, CommandDictionaryEntry>>();
			foreach (CommandDistance command in commands)
			{
				list.Add(CreateEntry(command.Command));
			}
			return list;
		}

		private static List<KeyValuePair<string, CommandDictionaryEntry>> GetDictionaryFromCommands(List<QueryProcessor.CommandData> commands)
		{
			List<KeyValuePair<string, CommandDictionaryEntry>> list = new List<KeyValuePair<string, CommandDictionaryEntry>>();
			foreach (QueryProcessor.CommandData command in commands)
			{
				list.Add(CreateEntry(command));
			}
			return list;
		}

		private static KeyValuePair<string, CommandDictionaryEntry> CreateEntry(QueryProcessor.CommandData command)
		{
			string usage = ((command.Usage == null || command.Usage.Length == 0) ? string.Empty : ("<color=yellow>" + UsageArrayToHumanReadableUsage(command.Usage) + "</color>"));
			string description = (string.IsNullOrEmpty(command.AliasOf) ? (command.Description ?? string.Empty) : ("<color=#0080FF>" + command.AliasOf + "</color>"));
			return new KeyValuePair<string, CommandDictionaryEntry>(command.Command, new CommandDictionaryEntry(usage, description));
		}

		private static string UsageArrayToHumanReadableUsage(IEnumerable<string> usage)
		{
			if (usage == null)
			{
				return string.Empty;
			}
			StringBuilder stringBuilder = new StringBuilder();
			foreach (string item in usage)
			{
				switch (item)
				{
				case "%player%":
					stringBuilder.Append("[PlayerID or Name]");
					break;
				case "%role%":
					stringBuilder.Append("[Role Name]");
					break;
				case "%door%":
					stringBuilder.Append("[Door Name]");
					break;
				default:
					stringBuilder.Append("[" + item + "]");
					break;
				}
				stringBuilder.Append(" ");
			}
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Length--;
			}
			return stringBuilder.ToString();
		}

		private static void FuzzySearchCommand(string partialCommand)
		{
			_distances.Clear();
			_addedDistances.Clear();
			string text = partialCommand.ToLowerInvariant();
			foreach (QueryProcessor.CommandData command in Commands)
			{
				if (command.Hidden || string.IsNullOrEmpty(command.Command))
				{
					continue;
				}
				int distance;
				if (command.Command.StartsWith(text, StringComparison.OrdinalIgnoreCase))
				{
					distance = command.Command.Length - text.Length;
				}
				else
				{
					if (Misc.LongestCommonSubstring(text, command.Command).Length < Math.Min(2, text.Length))
					{
						continue;
					}
					distance = Misc.LevenshteinDistance(text, command.Command) + 100;
				}
				string key = (string.IsNullOrEmpty(command.AliasOf) ? command.Command : command.AliasOf);
				CommandDistance commandDistance = new CommandDistance(command, distance);
				if (!_addedDistances.TryGetValue(key, out var value) || commandDistance < value)
				{
					_addedDistances[key] = commandDistance;
				}
			}
			_distances.AddRange(_addedDistances.Values);
			_distances.Sort(_cdComparer);
			if (_distances.Count > MaxSuggestions)
			{
				_distances.RemoveRange(MaxSuggestions, _distances.Count - MaxSuggestions);
			}
		}

		private bool ShouldProcessAllPlayers(string args)
		{
			string[] allAliases = AllAliases;
			foreach (string value in allAliases)
			{
				if (args.IndexOf(value, StringComparison.OrdinalIgnoreCase) >= 0)
				{
					return true;
				}
			}
			return false;
		}

		private static bool ShouldProcessSelf(string args)
		{
			string[] selfAliases = SelfAliases;
			foreach (string value in selfAliases)
			{
				if (args.IndexOf(value, StringComparison.OrdinalIgnoreCase) >= 0)
				{
					return true;
				}
			}
			return false;
		}

		private void LookupPlayer(string arg)
		{
			List<ReferenceHub> list = ReferenceHub.AllHubs.Where((ReferenceHub x) => x.Mode != CentralAuth.ClientInstanceMode.DedicatedServer && x.nicknameSync.MyNick.IndexOf(arg, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
			if (list.Count == 0)
			{
				return;
			}
			if (list.Count > 1)
			{
				AddLog("Multiple matches found!");
				AddLog("-----------------------------------------");
				foreach (ReferenceHub item in list)
				{
					AddLog(string.Format("[{0}] {1}", item.PlayerId, item.nicknameSync.MyNick));
				}
				AddLog("-----------------------------------------");
				return;
			}
			string myNick = list[0].nicknameSync.MyNick;
			string text = ((myNick.IndexOf(' ') >= 0 || myNick.IndexOf('.') >= 0 || myNick.IndexOf('@') >= 0) ? ("@\"" + myNick + "\"") : ("@" + myNick));
			string text2 = commandField.text;
			commandField.SetTextWithoutNotify(text2.Substring(0, text2.Length - arg.Length) + text + ".");
			commandField.MoveToEndOfLine(shift: false, ctrl: false);
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
