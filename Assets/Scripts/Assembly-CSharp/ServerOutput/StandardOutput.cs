using System;

namespace ServerOutput
{
	public class StandardOutput : IServerOutput, IDisposable
	{
		public void Start()
		{
		}

		public void AddLog(string text, ConsoleColor color)
		{
			Console.ForegroundColor = color;
			Console.WriteLine(text);
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
				AddLog("[Control Message] " + entry.GetString(), ConsoleColor.Gray);
			}
		}

		public void Dispose()
		{
		}
	}
}
