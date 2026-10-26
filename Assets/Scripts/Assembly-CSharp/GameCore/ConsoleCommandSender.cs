using System;
using UnityEngine;

namespace GameCore
{
	internal class ConsoleCommandSender : CommandSender
	{
		public override string SenderId => "GAME CONSOLE";

		public override string Nickname => "GAME CONSOLE";

		public override ulong Permissions => ulong.MaxValue;

		public override byte KickPower => byte.MaxValue;

		public override bool FullPermissions => true;

		public override void RaReply(string text, bool success, bool logToConsole, string overrideDisplay)
		{
			Console.AddLog("[RA Reply] " + text, success ? Color.green : Color.red);
		}

		public override void Print(string text)
		{
			Console.AddLog(text, Color.green);
		}

		public override void Print(string text, ConsoleColor c)
		{
			Console.AddLog(text, ServerConsole.ConsoleColorToColor(c));
		}

		public override void Print(string text, ConsoleColor c, Color rgbColor)
		{
			Console.AddLog(text, rgbColor);
		}

		public override bool Available()
		{
			return true;
		}

		public override void Respond(string message, bool success = true)
		{
			Console.AddLog(message, success ? Color.green : Color.red);
		}
	}
}
