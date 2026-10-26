using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Threading;
using GameCore;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using NorthwoodLib.Pools;
using UnityEngine;

public class ServerLogs : MonoBehaviour
{
	public enum ServerLogType : byte
	{
		ConnectionUpdate = 0,
		RemoteAdminActivity_GameChanging = 1,
		RemoteAdminActivity_Misc = 2,
		KillLog = 3,
		GameEvent = 4,
		InternalMessage = 5,
		AuthRateLimit = 6,
		Teamkill = 7,
		Suicide = 8,
		AdminChat = 9,
		Query = 10
	}

	public enum Modules : byte
	{
		Warhead = 0,
		Networking = 1,
		ClassChange = 2,
		Permissions = 3,
		Administrative = 4,
		GameLogic = 5,
		DataAccess = 6,
		Detector = 7,
		Throwable = 8,
		Door = 9,
		Elevator = 10
	}

	private enum LoggingState : byte
	{
		Off = 0,
		Standby = 1,
		Write = 2,
		Terminate = 3,
		Restart = 4
	}

	public readonly struct ServerLog : IEquatable<ServerLog>
	{
		public readonly string Content;

		public readonly string Type;

		public readonly string Module;

		public readonly string Time;

		public ServerLog(string content, string type, string module, string time)
		{
			Content = content;
			Type = type;
			Module = module;
			Time = time;
		}

		public bool Equals(ServerLog other)
		{
			if (Content == other.Content && Type == other.Type && Module == other.Module)
			{
				return Time == other.Time;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is ServerLog other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (((((((Content != null) ? Content.GetHashCode() : 0) * 397) ^ ((Type != null) ? Type.GetHashCode() : 0)) * 397) ^ ((Module != null) ? Module.GetHashCode() : 0)) * 397) ^ ((Time != null) ? Time.GetHashCode() : 0);
		}

		public static bool operator ==(ServerLog left, ServerLog right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(ServerLog left, ServerLog right)
		{
			return !left.Equals(right);
		}
	}

	private static readonly string[] Txt;

	private static readonly string[] Modulestxt;

	private static readonly Queue<ServerLog> Queue;

	private static readonly object LockObject;

	public static readonly ConcurrentDictionary<string, IOutput> LiveLogOutput;

	private static Thread _appendThread;

	private static readonly int _maxlen;

	private static readonly int _modulemaxlen;

	private static volatile LoggingState _state;

	static ServerLogs()
	{
		Txt = new string[11]
		{
			"Connection update", "Remote Admin", "Remote Admin - Misc", "Kill", "Game Event", "Internal", "Auth Rate Limit", "Teamkill", "Suicide", "AdminChat",
			"Query"
		};
		Modulestxt = new string[11]
		{
			"Warhead", "Networking", "Class change", "Permissions", "Administrative", "Game logic", "Data access", "FF Detector", "Throwable", "Door",
			"Elevator"
		};
		Queue = new Queue<ServerLog>();
		LockObject = new object();
		LiveLogOutput = new ConcurrentDictionary<string, IOutput>();
		string[] txt = Txt;
		foreach (string text in txt)
		{
			_maxlen = Math.Max(_maxlen, text.Length);
		}
		txt = Modulestxt;
		foreach (string text2 in txt)
		{
			_modulemaxlen = Math.Max(_modulemaxlen, text2.Length);
		}
	}

	internal static void StartLogging()
	{
		if (!NetworkServer.active)
		{
			return;
		}
		if (_state != LoggingState.Off)
		{
			_state = LoggingState.Restart;
			return;
		}
		Thread appendThread = _appendThread;
		if (appendThread == null || !appendThread.IsAlive)
		{
			_appendThread = new Thread(AppendLog)
			{
				Name = "Saving server logs to file",
				Priority = System.Threading.ThreadPriority.BelowNormal,
				IsBackground = true
			};
			_appendThread.Start();
		}
	}

	public static void AddLog(Modules module, string msg, ServerLogType type, bool init = false)
	{
		string time = TimeBehaviour.Rfc3339Time();
		lock (LockObject)
		{
			Queue.Enqueue(new ServerLog(msg, Txt[(uint)type], Modulestxt[(uint)module], time));
		}
		if (!init)
		{
			_state = LoggingState.Write;
		}
	}

	private void OnApplicationQuit()
	{
		_state = LoggingState.Terminate;
	}

	private static void AppendLog()
	{
		_state = LoggingState.Standby;
		StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
		while (_state != LoggingState.Terminate)
		{
			lock (LockObject)
			{
				Queue.Clear();
				_state = LoggingState.Standby;
			}
			while (!NetworkServer.active)
			{
				if (_state == LoggingState.Terminate)
				{
					_state = LoggingState.Off;
					StringBuilderPool.Shared.Return(stringBuilder);
					return;
				}
				Thread.Sleep(200);
			}
			string text = TimeBehaviour.FormatTime("yyyy-MM-dd HH.mm.ss");
			string text2 = LiteNetLib4MirrorTransport.Singleton.port.ToString();
			AddLog(Modules.GameLogic, "Started logging.", ServerLogType.InternalMessage, init: true);
			AddLog(Modules.GameLogic, "Game version: " + GameCore.Version.VersionString + ".", ServerLogType.InternalMessage, init: true);
			AddLog(Modules.GameLogic, "Build type: " + GameCore.Version.BuildType.ToString() + ".", ServerLogType.InternalMessage, init: true);
			AddLog(Modules.GameLogic, "Build timestamp: 2026-10-12 18:32:38Z.", ServerLogType.InternalMessage, init: true);
			AddLog(Modules.GameLogic, "Headless: " + PlatformInfo.singleton.IsHeadless + ".", ServerLogType.InternalMessage, init: true);
			while (NetworkServer.active && _state != LoggingState.Terminate && _state != LoggingState.Restart)
			{
				Thread.Sleep(100);
				if (_state == LoggingState.Standby)
				{
					continue;
				}
				if (!Directory.Exists(FileManager.GetAppFolder()))
				{
					return;
				}
				if (!Directory.Exists(FileManager.GetAppFolder() + "ServerLogs"))
				{
					Directory.CreateDirectory(FileManager.GetAppFolder() + "ServerLogs");
				}
				if (!Directory.Exists(FileManager.GetAppFolder() + "ServerLogs/" + text2))
				{
					Directory.CreateDirectory(FileManager.GetAppFolder() + "ServerLogs/" + text2);
				}
				lock (LockObject)
				{
					ServerLog result;
					while (Queue.TryDequeue(out result))
					{
						string text3 = result.Time + " | " + ToMax(result.Type, _maxlen) + " | " + ToMax(result.Module, _modulemaxlen) + " | " + result.Content;
						stringBuilder.AppendLine(text3);
						PrintOnOutputs(text3);
					}
				}
				using (StreamWriter streamWriter = new StreamWriter(FileManager.GetAppFolder() + "ServerLogs/" + text2 + "/Round " + text + ".txt", append: true))
				{
					streamWriter.Write(stringBuilder.ToString());
				}
				stringBuilder.Clear();
				LoggingState state = _state;
				if (state == LoggingState.Terminate || state == LoggingState.Restart)
				{
					break;
				}
				_state = LoggingState.Standby;
			}
		}
		_state = LoggingState.Off;
		StringBuilderPool.Shared.Return(stringBuilder);
	}

	private static void PrintOnOutputs(string text)
	{
		try
		{
			if (LiveLogOutput == null)
			{
				return;
			}
			foreach (KeyValuePair<string, IOutput> output in LiveLogOutput)
			{
				IOutput value;
				try
				{
					if (output.Value == null || !output.Value.Available())
					{
						LiveLogOutput.TryRemove(output.Key, out value);
						continue;
					}
					if (output.Value is ServerConsoleSender)
					{
						ServerConsole.AddLog(text, ConsoleColor.Gray, hideFromOutputs: true);
						continue;
					}
					MainThreadDispatcher.Dispatch(() =>
					{
						output.Value.Print(text);
					});
				}
				catch
				{
					LiveLogOutput.TryRemove(output.Key, out value);
				}
			}
		}
		catch (Exception ex)
		{
			ServerConsole.AddLog("Failed to print log to outputs: " + ex.Message + "\n" + ex.StackTrace, ConsoleColor.Red);
		}
	}

	private static string ToMax(string text, int max)
	{
		while (text.Length < max)
		{
			text += " ";
		}
		return text;
	}
}
