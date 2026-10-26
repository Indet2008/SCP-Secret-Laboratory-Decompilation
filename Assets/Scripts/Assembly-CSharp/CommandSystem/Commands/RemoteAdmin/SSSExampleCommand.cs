using System;
using UserSettings.ServerSpecific.Examples;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class SSSExampleCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "sssimplementationexample";

		public string[] Aliases { get; } = new string[1] { "sssexample" };

		public string Description { get; } = "Allows to active server specific settings implementation example.";

		public string[] Usage { get; } = new string[1] { "Example index (Optional, will list all available examples if not provided)" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.PermissionsManagement))
			{
				response = "You are not authorized to run this command";
				return false;
			}
			if (arguments.Count < 1)
			{
				response = "Example implementations of server-specific setting:";
				for (int i = 0; i < SSExampleImplementationBase.AllExamples.Length; i++)
				{
					response += $"\n - ('{i}') - {SSExampleImplementationBase.AllExamples[i].Name}";
				}
				response += "\n\nUse 'stop' as argument to deactivate current implementation example.";
				return true;
			}
			if (string.Equals(arguments.At(0), "stop", StringComparison.InvariantCultureIgnoreCase))
			{
				if (SSExampleImplementationBase.TryDeactivateExample(out var disabledName))
				{
					response = disabledName + " successfully deactivated.";
					return true;
				}
				response = "No example implementation active.";
				return false;
			}
			if (!int.TryParse(arguments.At(0), out var result))
			{
				response = "Invalid argument. Provide a number or 'stop' to deactivate current implementation example. Provide no arguments to list available examples.";
				return false;
			}
			return SSExampleImplementationBase.TryActivateExample(result, out response);
		}
	}
}
