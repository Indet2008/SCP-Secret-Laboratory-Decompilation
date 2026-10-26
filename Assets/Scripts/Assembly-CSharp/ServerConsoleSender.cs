using System;

public class ServerConsoleSender : CommandSender
{
	public override string SenderId => "SERVER CONSOLE";

	public override string Nickname => "SERVER CONSOLE";

	public override ulong Permissions => ulong.MaxValue;

	public override byte KickPower => byte.MaxValue;

	public override bool FullPermissions => true;

	public override void RaReply(string text, bool success, bool logToConsole, string overrideDisplay)
	{
		Print(text);
	}

	public override void Print(string text)
	{
		ServerConsole.AddLog(text);
	}

	public override void Print(string text, ConsoleColor c)
	{
		ServerConsole.AddLog(text, c);
	}

	public override bool Available()
	{
		return true;
	}
}
