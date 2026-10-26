using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Text;
using CentralAuth;
using CommandSystem;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using LabApi.Features.Enums;
using Mirror;
using NorthwoodLib.Pools;
using Org.BouncyCastle.Crypto;
using RemoteAdmin;
using TMPro;
using ToggleableMenus;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using UserSettings;
using UserSettings.OtherSettings;

namespace GameCore
{
	public class Console : SimpleToggleableMenu
	{
		private const string PrefsKeyName = "GameConsoleScale";

		private const string NotConnectedMessage = "You must be connected to a server to use this command.";

		private const int MaxLogAmount = 200;

		public static readonly GameConsoleCommandHandler ConsoleCommandHandler = GameConsoleCommandHandler.Create();

		internal static bool DisplayCreateServer;

		internal static bool TranslationDebugMode;

		internal static AsymmetricKeyParameter _publicKey;

		internal static readonly Queue<ConsoleLog> Logs = new Queue<ConsoleLog>();

		internal static readonly string SyncbindPath = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData) + "/SCP Secret Laboratory/internal/SyncCmd";

		internal static bool AlwaysRefreshing = false;

		[Obsolete("Replaced by SSS")]
		internal static bool AllowBindSyncing;

		[Obsolete("Replaced by SSS")]
		internal static bool BindSyncingContinue;

		private static bool _noConsoleLogOutput;

		private static bool _refreshText;

		private static readonly ConcurrentQueue<ConsoleLog> LogQueue = new ConcurrentQueue<ConsoleLog>();

		private static readonly ConsoleCommandSender Ccs = new ConsoleCommandSender();

		[SerializeField]
		private TextMeshProUGUI _consoleText;

		[SerializeField]
		private TMP_InputField _commandField;

		[SerializeField]
		private Scrollbar _scrollBar;

		[SerializeField]
		private GameObject _background;

		[SerializeField]
		private ResizableWindow _resizableWindow;

		private readonly List<string> _clientCommandLogs = new List<string>();

		private float[] _scaleNonAlloc = new float[2];

		private int _clientCommandPosition;

		private string _content;

		public static Console Singleton { get; private set; }

		public static bool RequestDNT { get; private set; }

		public static bool PrintingPaused { get; set; }

		internal static string BinariesRootPath
		{
			get
			{
				if (Application.isEditor)
				{
					return "\\BuildFiles\\windows";
				}
				return Path.GetDirectoryName(Path.GetFullPath(Application.dataPath));
			}
		}

		internal static bool DisableSRV { get; private set; }

		internal static bool SkipIpValidation { get; private set; }

		[Obsolete("Replaced by SSS")]
		internal static bool BindSyncingEnabled { get; set; }

		public override bool CanToggle
		{
			get
			{
				if (IsEnabled && _commandField.isFocused)
				{
					return _commandField.text.Length <= 1;
				}
				return true;
			}
		}

		public override bool LockMovement => IsEnabled;

		public static void AddDebugLog(string debugKey, string message, MessageImportance importance, bool nospace = false)
		{
			if (ConsoleDebugMode.CheckImportance(debugKey, importance, out var color))
			{
				AddLog("[DEBUG_" + debugKey + "] " + message, color, nospace);
			}
		}

		public static void AddLog(string text, Color color, bool nospace = false, ConsoleLogType type = ConsoleLogType.Log)
		{
			DateTimeOffset now = DateTimeOffset.Now;
			if (!_noConsoleLogOutput && !ServerStatic.IsDedicated)
			{
				switch (type)
				{
				case ConsoleLogType.Log:
					if (Application.isEditor)
					{
						Debug.Log("<color=" + color.ToHex() + ">" + text + "</color>");
					}
					else
					{
						Debug.Log(text);
					}
					break;
				case ConsoleLogType.Warning:
					Debug.LogWarning(text);
					break;
				case ConsoleLogType.Error:
					Debug.LogError(text);
					break;
				default:
					throw new ArgumentOutOfRangeException("type", type, null);
				case ConsoleLogType.DoNotLog:
					break;
				}
			}
			if (ServerStatic.IsDedicated)
			{
				ServerConsole.AddLog(text, Misc.ClosestConsoleColor(color));
			}
			else if (!PrintingPaused)
			{
				text = "<color=#808080><size=18>[" + TimeBehaviour.FormatTime("HH:mm:ss", now) + "<size=16>." + TimeBehaviour.FormatTime("fff", now) + "</size>]</size></color> " + text;
				LogQueue.Enqueue(new ConsoleLog(text, color, nospace));
			}
		}

		public static void ClearConsole()
		{
			Logs.Clear();
			Singleton.RefreshConsoleScreen();
		}

		public static GameObject FindConnectedRoot(NetworkConnection conn)
		{
			try
			{
				GameObject gameObject = conn.identity.gameObject;
				if (gameObject.CompareTag("Player"))
				{
					return gameObject;
				}
			}
			catch
			{
				return null;
			}
			return null;
		}

		internal string TypeCommand(string cmd, CommandSender sender = null)
		{
			if (!NetworkServer.active)
			{
				Debug.Log(">>> " + cmd);
				if (sender == null)
				{
					sender = Ccs;
				}
				_clientCommandLogs.Add(cmd);
			}
			else if (sender == null)
			{
				sender = ServerConsole.Scs;
			}
			if (cmd.StartsWith('.') && cmd.Length > 1)
			{
				if (!NetworkClient.active && !NetworkServer.active)
				{
					AddLog("You must be connected to a server to use this command.", Color.red);
					return "You must be connected to a server to use this command.";
				}
				string text = cmd;
				string text2 = text.Substring(1, text.Length - 1);
				string text3 = "Sending command to server: " + text2;
				sender?.Print(text3, ConsoleColor.Green);
				if (!ReferenceHub.TryGetLocalHub(out var hub))
				{
					return "You must be connected to a server to use this command.";
				}
				hub.gameConsoleTransmission.SendToServer(text2);
				return text3;
			}
			bool flag = cmd.StartsWith('@');
			if ((cmd.StartsWith('/') | flag) && cmd.Length > 1)
			{
				string text4;
				if (!flag)
				{
					string text = cmd;
					text4 = text.Substring(1, text.Length - 1);
				}
				else
				{
					text4 = cmd;
				}
				string text5 = text4;
				if (!flag)
				{
					text5 = text5.TrimStart('$');
					if (string.IsNullOrEmpty(text5))
					{
						sender?.Print("Command cant be empty!", ConsoleColor.Green);
						return "Command cant be empty!";
					}
				}
				if (NetworkServer.active)
				{
					if (!flag)
					{
						return CommandProcessor.ProcessQuery(text5, sender);
					}
					string text = text5;
					CommandProcessor.ProcessAdminChat(text.Substring(1, text.Length - 1), sender);
					return null;
				}
			}
			string[] array = cmd.Trim().Split(QueryProcessor.SpaceArray, 512, StringSplitOptions.RemoveEmptyEntries);
			cmd = array[0];
			bool flag2 = ConsoleCommandHandler.TryGetCommand(cmd, out var command);
			ArraySegment<string> arguments = array.Segment(1);
			CommandExecutingEventArgs e = new CommandExecutingEventArgs(sender, CommandType.Console, flag2, command, arguments);
			ServerEvents.OnCommandExecuting(e);
			if (!e.IsAllowed)
			{
				return null;
			}
			arguments = e.Arguments;
			sender = e.Sender;
			command = e.Command;
			if (!flag2)
			{
				string text6 = "Command " + cmd + " does not exist!";
				sender?.Print(text6, ConsoleColor.DarkYellow, new Color32(byte.MaxValue, 180, 0, byte.MaxValue));
				return text6;
			}
			try
			{
				bool successful = command.Execute(arguments, sender, out var response);
				response = Misc.CloseAllRichTextTags(response);
				CommandExecutedEventArgs e2 = new CommandExecutedEventArgs(sender, CommandType.Console, command, arguments, successful, response);
				ServerEvents.OnCommandExecuted(e2);
				response = e2.Response;
				successful = e2.ExecutedSuccessfully;
				if (string.IsNullOrWhiteSpace(response))
				{
					return null;
				}
				sender?.Print(response, successful ? ConsoleColor.Green : ConsoleColor.Red);
				return response;
			}
			catch (Exception ex)
			{
				string response2 = "Command execution failed! Error: " + Misc.RemoveStacktraceZeroes(ex.ToString());
				CommandExecutedEventArgs e3 = new CommandExecutedEventArgs(sender, CommandType.Console, command, arguments, successful: false, response2);
				ServerEvents.OnCommandExecuted(e3);
				response2 = e3.Response;
				sender?.Print(response2, ConsoleColor.Red);
				return response2;
			}
		}

		internal static void CopyPastebin()
		{
		}

		private static void HandleStartupArgs()
		{
			bool flag = false;
			string[] args = StartupArgs.Args;
			for (int i = 0; i < args.Length; i++)
			{
				switch (args[i].ToLowerInvariant())
				{
				case "-noconsolelog":
					_noConsoleLogOutput = true;
					break;
				case "-dnt":
					RequestDNT = true;
					AddLog("\"Do not track\" request will be sent to all servers you are joining - enabled by startup argument.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				case "-nosrv":
					DisableSRV = true;
					AddLog("SRV DNS records resolution has been disabled.", Color.yellow);
					break;
				case "-hidetag":
					UserSetting<int>.Set(MiscPrivacySetting.GlobalBadgeVisibility, 2);
					AddLog("Your global badge will be automatically hidden.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				case "-neverhidelocaltag":
					UserSetting<int>.Set(MiscPrivacySetting.LocalBadgeVisibility, 1);
					AddLog("Your local badge won't be automatically hidden.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				case "-hidelocaltag":
					UserSetting<int>.Set(MiscPrivacySetting.LocalBadgeVisibility, 2);
					AddLog("Your local badge will be automatically hidden.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				case "-nevercover":
					UserSetting<int>.Set(MiscPrivacySetting.BadgePreferences, 1);
					AddLog("Your global badge won't be covered.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				case "-skipipvalidation":
					SkipIpValidation = true;
					AddLog("IP validation will be skipped.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				case "-scs":
					DisplayCreateServer = true;
					AddLog("Create Server button will be displayed (startup argument).", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				case "-allow-syncbind":
					flag = true;
					AddLog("[WARNING] You have \"-allow-syncbind\" startup argument added.", Color.yellow);
					AddLog("[WARNING] Your command binding might be messed up, and your key might be logged by the server you join.", Color.yellow);
					AllowBindSyncing = true;
					if (File.Exists(SyncbindPath))
					{
						if (File.ReadAllText(SyncbindPath) == SystemInfo.deviceUniqueIdentifier)
						{
							AddLog("[WARNING] Bind syncing is ENABLED.", Color.red);
							BindSyncingEnabled = true;
						}
						else
						{
							AddLog("Bind syncing has been disabled - HWID mismatch.", Color.gray);
							File.Delete(SyncbindPath);
						}
					}
					else
					{
						BindSyncingEnabled = false;
					}
					break;
				case "-tdm":
					TranslationDebugMode = true;
					AddLog("Translation debug mode has been enabled (startup argument).", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
					break;
				}
			}
			if (!flag && File.Exists(SyncbindPath))
			{
				File.Delete(SyncbindPath);
			}
		}

		public static void RefreshPublicKey()
		{
		}

		public void ProceedButton()
		{
			if (_commandField.text != string.Empty)
			{
				TypeCommand(_commandField.text);
			}
			_commandField.text = string.Empty;
			EventSystem.current.SetSelectedGameObject(_commandField.gameObject);
		}

		protected override void OnToggled()
		{
			base.OnToggled();
			if (!ServerStatic.IsDedicated)
			{
				_background.SetActive(IsEnabled);
				_commandField.text = string.Empty;
				if (IsEnabled)
				{
					EventSystem.current.SetSelectedGameObject(_commandField.gameObject);
				}
			}
		}

		protected override void Awake()
		{
			if (Singleton != null)
			{
				UnityEngine.Object.DestroyImmediate(base.gameObject);
				return;
			}
			Singleton = this;
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			base.Awake();
		}

		private void Start()
		{
			SceneManager.sceneLoaded += OnSceneLoaded;
			AddLog("Hi there! Initializing console...", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
			AddLog("Done! Type 'help' to print the list of available commands.", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
			CentralAuthManager.InitAuth();
			HandleStartupArgs();
			_scaleNonAlloc[0] = _resizableWindow.CurrentSize.x;
			_scaleNonAlloc[1] = _resizableWindow.CurrentSize.y;
			_scaleNonAlloc = PlayerPrefsSl.Get("GameConsoleScale", _scaleNonAlloc);
			if (!ServerStatic.IsDedicated)
			{
				AddLog($"Loading console size preference: ({_scaleNonAlloc[0]:0.0},{_scaleNonAlloc[1]:0.0})", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
			}
			_resizableWindow.SetScaleAndResetPosition(new Vector2(_scaleNonAlloc[0], _scaleNonAlloc[1]));
			_resizableWindow.OnResizingEnded += OnWindowResized;
		}

		// Update/LateUpdate are client-only and were emptied in the server build; rebuilt after the SL 12 CE client.
		private void Update()
		{
			if (_refreshText && _scrollBar != null)
			{
				_refreshText = false;
				Canvas.ForceUpdateCanvases();
				_scrollBar.value = 0f;
			}
		}

		private void LateUpdate()
		{
			if (!IsEnabled || _commandField == null)
			{
				_clientCommandPosition = 0;
				return;
			}
			if (Input.GetKeyDown(KeyCode.Return) || Input.GetKeyDown(KeyCode.KeypadEnter))
			{
				string cmd = _commandField.text.Trim();
				_commandField.text = string.Empty;
				_clientCommandPosition = 0;
				if (cmd.Length > 0)
				{
					try
					{
						TypeCommand(cmd);
					}
					catch (Exception ex)
					{
						AddLog("Command execution failed! Error: " + ex.Message, Color.red);
					}
				}
				EventSystem.current?.SetSelectedGameObject(_commandField.gameObject);
				_commandField.ActivateInputField();
			}
			else if (Input.GetKeyDown(KeyCode.UpArrow))
			{
				if (_clientCommandPosition < _clientCommandLogs.Count)
				{
					_clientCommandPosition++;
					SetCommandFieldText(_clientCommandLogs[_clientCommandLogs.Count - _clientCommandPosition]);
				}
			}
			else if (Input.GetKeyDown(KeyCode.DownArrow) && _clientCommandPosition > 0)
			{
				_clientCommandPosition--;
				SetCommandFieldText(_clientCommandPosition == 0 ? string.Empty : _clientCommandLogs[_clientCommandLogs.Count - _clientCommandPosition]);
			}
		}

		private void SetCommandFieldText(string text)
		{
			_commandField.text = text;
			_commandField.caretPosition = text.Length;
		}

		private void FixedUpdate()
		{
			bool flag = false;
			ConsoleLog result;
			while (LogQueue.TryDequeue(out result))
			{
				string[] array = result.Text.Split('\n');
				bool nospace = result.NoSpace;
				string[] array2 = array;
				for (int i = 0; i < array2.Length; i++)
				{
					string text = array2[i].Replace("\r", string.Empty);
					ConsoleLog item = new ConsoleLog(text, result.Color, nospace);
					Logs.Enqueue(item);
					nospace = true;
					while (Logs.Count > 200)
					{
						Logs.Dequeue();
					}
				}
				flag = true;
			}
			if (flag)
			{
				RefreshConsoleScreen();
			}
		}

		private void OnApplicationQuit()
		{
			_resizableWindow.OnResizingEnded -= OnWindowResized;
			Shutdown.Quit(quit: false);
		}

		private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
		{
			AddLog("Scene Manager: Loaded scene '" + scene.name + "' [" + scene.path + "]", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
			RefreshConsoleScreen();
		}

		private void RefreshConsoleScreen()
		{
			if (_consoleText == null)
			{
				return;
			}
			if (Logs.Count == 0)
			{
				_content = string.Empty;
				_consoleText.text = _content;
				_refreshText = true;
				return;
			}
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			foreach (ConsoleLog log in Logs)
			{
				log.AppendFormatted(stringBuilder);
			}
			_content = StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			_consoleText.SetText(_content);
			_refreshText = true;
		}

		private void OnWindowResized(Vector2 size)
		{
			_scaleNonAlloc[0] = size.x;
			_scaleNonAlloc[1] = size.y;
			PlayerPrefsSl.Set("GameConsoleScale", _scaleNonAlloc);
			AddLog($"Console size preference set to ({_scaleNonAlloc[0]:0.0},{_scaleNonAlloc[1]:0.0})", new Color32(0, byte.MaxValue, 0, byte.MaxValue));
		}
	}
}
