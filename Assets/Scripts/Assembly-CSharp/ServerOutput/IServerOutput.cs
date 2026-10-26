using System;

namespace ServerOutput
{
	public interface IServerOutput : IDisposable
	{
		void Start();

		void AddLog(string text, ConsoleColor color);

		void AddLog(string text);

		void AddOutput(IOutputEntry entry);
	}
}
