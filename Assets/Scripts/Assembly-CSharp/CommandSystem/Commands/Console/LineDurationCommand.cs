using System;
using DrawableLine;
using Mirror;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(LineCommand))]
	public class LineDurationCommand : ICommand
	{
		public string Command { get; } = "setduration";

		public string[] Aliases { get; } = new string[4] { "setdur", "duration", "dur", "d" };

		public string Description { get; } = "Overrides the duration of any new lines to the specified value.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (NetworkServer.active && !sender.CheckPermission(PlayerPermissions.PermissionsManagement, out response))
			{
				return false;
			}
			if (arguments.Count == 0 || !float.TryParse(arguments.At(0), out var result))
			{
				if (DrawableLines.DurationOverride.HasValue)
				{
					ResetOverride(out response);
					return true;
				}
				response = "You must specify a valid duration!";
				return false;
			}
			if (result <= 0f)
			{
				ResetOverride(out response);
				return true;
			}
			DrawableLines.DurationOverride = result;
			DrawableLinesManager.ApplyMaxDurationRetroactively(result);
			response = $"<color=white>The drawable line system now has a default duration of <b>{result:F2}s</b>.</color>";
			return true;
		}

		private static void ResetOverride(out string response)
		{
			DrawableLines.DurationOverride = null;
			DrawableLinesManager.ApplyMaxDurationRetroactively(0f);
			response = "Duration override value has been reset.";
		}
	}
}
