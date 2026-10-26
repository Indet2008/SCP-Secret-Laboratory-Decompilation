using System;
using CommandSystem;
using ServerOutput;

namespace _Scripts.CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class BufferSizeCommand : ICommand
	{
		public string Command { get; } = "buffer";

		public string[] Aliases { get; } = new string[1] { "bs" };

		public string Description { get; } = "Returns TcpConsole buffers sizes.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			if (!(ServerStatic.ServerOutput is TcpConsole tcpConsole))
			{
				response = "Current ServerOutput is not TcpConsole!";
				return false;
			}
			response = $"RX Buffer Size: {tcpConsole.ReceiveBufferSize}\nTX Buffer Size: {tcpConsole.SendBufferSize}\n\nSpecified RX Buffer Size: {tcpConsole.SpecifiedReceiveBufferSize}\nSpecified TX Buffer Size: {tcpConsole.SpecifiedSendBufferSize}\n\nDefault RX Buffer Size: {25000}\nDefault TX Buffer Size: {200000}";
			return true;
		}
	}
}
