using System;
using GameCore;
using UnityEngine;

namespace ServerOutput
{
	public class NonDedicatedOutput : IServerOutput, IDisposable
	{
		public void Start()
		{
		}

		public void AddLog(string text, ConsoleColor color)
		{
			GameCore.Console.AddLog(ServerConsole.ColorText("[SRV] " + text, color), Color.gray);
		}

		public void AddLog(string text)
		{
			AddLog(text, ConsoleColor.Gray);
		}

		public void AddOutput(IOutputEntry entry)
		{
			if (entry is TextOutputEntry textOutputEntry)
			{
				AddLog(textOutputEntry.Text, (ConsoleColor)textOutputEntry.Color);
			}
			else
			{
				GameCore.Console.AddLog("[Control Message] " + entry.GetString(), Color.gray);
			}
		}

		public void Dispose()
		{
		}
	}
}
