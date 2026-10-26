using System;
using System.Collections.Concurrent;
using System.IO;
using System.Threading;
using GameCore;
using UnityEngine;

namespace ServerOutput
{
	public class FileConsole : IServerOutput, IDisposable
	{
		private bool _disposing;

		private uint _logId;

		private readonly string _session;

		private readonly FileSystemWatcher _fsw;

		private readonly Thread _queueThread;

		private readonly ConcurrentQueue<IOutputEntry> _prompterQueue = new ConcurrentQueue<IOutputEntry>();

		public FileConsole(string session)
		{
			_session = (string.IsNullOrEmpty(session) ? "default" : session);
			_queueThread = new Thread(Prompt)
			{
				Priority = System.Threading.ThreadPriority.Lowest,
				IsBackground = true,
				Name = "Dedicated server console output"
			};
			_fsw = new FileSystemWatcher
			{
				Path = "SCPSL_Data/Dedicated/" + _session,
				NotifyFilter = NotifyFilters.FileName
			};
		}

		public void Start()
		{
			if (Directory.Exists("SCPSL_Data/Dedicated/" + _session) && Environment.GetCommandLineArgs().Contains<string>("-nodedicateddelete"))
			{
				string[] files = Directory.GetFiles("SCPSL_Data/Dedicated/" + _session);
				for (int i = 0; i < files.Length; i++)
				{
					File.Delete(files[i]);
				}
			}
			Directory.CreateDirectory("SCPSL_Data/Dedicated/" + _session);
			_queueThread.Start();
			_fsw.Created += (object sender, FileSystemEventArgs args) =>
			{
				if (args.Name.Contains("cs") && args.Name.Contains("mapi"))
				{
					new Thread(() =>
					{
						ReadLog(args.FullPath);
					}).Start();
				}
			};
			_fsw.EnableRaisingEvents = true;
		}

		public void Dispose()
		{
			_disposing = true;
			_fsw.Dispose();
			try
			{
				if (_queueThread.IsAlive)
				{
					_queueThread.Abort();
				}
			}
			catch
			{
			}
			if (!ServerStatic.KeepSession && Directory.Exists("SCPSL_Data/Dedicated/" + _session))
			{
				Directory.Delete("SCPSL_Data/Dedicated/" + _session, recursive: true);
			}
		}

		private void ReadLog(string path)
		{
			try
			{
				if (!File.Exists(path))
				{
					return;
				}
				string text = path.Remove(0, path.IndexOf("cs", StringComparison.Ordinal));
				string empty = string.Empty;
				string text2 = string.Empty;
				ConsoleColor color = ConsoleColor.Gray;
				try
				{
					text2 = "Error while reading the file: " + text;
					using StreamReader streamReader = new StreamReader("SCPSL_Data/Dedicated/" + _session + "/" + text);
					string text3 = streamReader.ReadToEnd();
					text2 = "Error while dedecting 'terminator end-of-message' signal.";
					if (text3.Contains("terminator"))
					{
						text3 = text3.Remove(text3.LastIndexOf("terminator", StringComparison.Ordinal));
					}
					text2 = "Error while sending message.";
					ServerConsole.PrompterQueue.Enqueue(text3);
					File.Delete("SCPSL_Data/Dedicated/" + _session + "/" + text);
					return;
				}
				catch
				{
					Debug.LogError("Error in server console: " + text2);
				}
				if (!string.IsNullOrEmpty(empty))
				{
					AddLog(empty, color);
				}
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		public void AddLog(string text, ConsoleColor color)
		{
			if (!string.IsNullOrWhiteSpace(text))
			{
				if (ServerStatic.IsDedicated)
				{
					_prompterQueue.Enqueue(new TextOutputEntry(text, color));
				}
				else
				{
					GameCore.Console.AddLog(text, Color.grey);
				}
			}
		}

		public void AddLog(string text)
		{
			AddLog(text, ConsoleColor.Gray);
		}

		public void AddOutput(IOutputEntry entry)
		{
			if (ServerStatic.IsDedicated)
			{
				_prompterQueue.Enqueue(entry);
			}
		}

		private void Prompt()
		{
			while (!_disposing)
			{
				IOutputEntry result;
				if (_prompterQueue.Count == 0)
				{
					Thread.Sleep(25);
				}
				else if (_prompterQueue.TryDequeue(out result))
				{
					StreamWriter streamWriter = new StreamWriter("SCPSL_Data/Dedicated/" + _session + "/sl" + _logId + ".mapi");
					_logId++;
					streamWriter.WriteLine(result.ToString());
					streamWriter.Close();
				}
			}
		}
	}
}
