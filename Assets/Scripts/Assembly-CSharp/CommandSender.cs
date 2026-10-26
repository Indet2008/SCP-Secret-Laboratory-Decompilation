using System;
using CommandSystem;
using UnityEngine;

public abstract class CommandSender : IOutput, ICommandSender
{
	public abstract string SenderId { get; }

	public string OutputId => SenderId;

	public abstract string Nickname { get; }

	public abstract ulong Permissions { get; }

	public abstract byte KickPower { get; }

	public abstract bool FullPermissions { get; }

	public virtual string LogName => Nickname;

	public abstract void RaReply(string text, bool success, bool logToConsole, string overrideDisplay);

	public abstract void Print(string text);

	public virtual void Print(string text, ConsoleColor c)
	{
		Print(text);
	}

	public virtual void Print(string text, ConsoleColor c, Color rgbColor)
	{
		Print(text, c);
	}

	public abstract bool Available();

	public virtual void Respond(string message, bool success = true)
	{
		RaReply(message, success, logToConsole: true, string.Empty);
	}
}
