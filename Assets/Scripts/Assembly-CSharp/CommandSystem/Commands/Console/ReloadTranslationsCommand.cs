using System;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class ReloadTranslationsCommand : ICommand
	{
		public string Command { get; } = "reloadtranslations";

		public string[] Aliases { get; }

		public string Description { get; } = "Reloads game translations";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.ServerConsoleCommands, out response))
			{
				return false;
			}
			TranslationReader.Refresh();
			response = "Translations have been reloaded! Some elements may require full level reload.";
			return true;
		}
	}
}
