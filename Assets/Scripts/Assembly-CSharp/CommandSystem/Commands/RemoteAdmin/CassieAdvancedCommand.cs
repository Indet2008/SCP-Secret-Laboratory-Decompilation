using System;
using Cassie;
using Utils;

namespace CommandSystem.Commands.RemoteAdmin
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class CassieAdvancedCommand : ICommand, IUsageProvider
	{
		public string Command { get; } = "cassieadvanced";

		public string[] Aliases { get; }

		public string Description { get; } = "Sends an announcement over the CASSIE system with custom subtitle.";

		public string[] Usage { get; } = new string[1] { "message" };

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.Announcer, out response))
			{
				return false;
			}
			CassieTtsPayload.SubtitleMode[] array = new CassieTtsPayload.SubtitleMode[3]
			{
				CassieTtsPayload.SubtitleMode.None,
				CassieTtsPayload.SubtitleMode.Automatic,
				CassieTtsPayload.SubtitleMode.Custom
			};
			if (arguments.Count < 1 || !Enum.TryParse<CassieTtsPayload.SubtitleMode>(arguments.At(0), ignoreCase: true, out var result) || !array.Contains(result))
			{
				response = "First argument should specify one of the following subtitle modes: ";
				for (int i = 0; i < array.Length; i++)
				{
					if (i > 0)
					{
						response += ", ";
					}
					response += array[i];
				}
				return false;
			}
			if (arguments.Count < 2 || !bool.TryParse(arguments.At(1), out var result2))
			{
				response = "Second argument should be a bool specifying if background noises should play.";
				return false;
			}
			if (arguments.Count < 3)
			{
				response = "Announcement is empty";
				return false;
			}
			if (result == CassieTtsPayload.SubtitleMode.Custom)
			{
				string text = PlayCustomSubtitles(arguments, result2);
				if (!string.IsNullOrEmpty(text))
				{
					response = text;
					return false;
				}
			}
			else
			{
				string customAnnouncement = RAUtils.FormatArguments(arguments, 2).ToUpper();
				bool autoGenerateSubtitles = result == CassieTtsPayload.SubtitleMode.Automatic;
				new CassieAnnouncement(new CassieTtsPayload(customAnnouncement, autoGenerateSubtitles, result2), 0f, 0f).AddToQueue();
			}
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " started an advanced cassie announcement: " + RAUtils.FormatArguments(arguments, 0) + ".", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			response = "Announcement sent!";
			return true;
		}

		private static string PlayCustomSubtitles(ArraySegment<string> arguments, bool playBackground)
		{
			if (!int.TryParse(arguments.At(2), out var result))
			{
				return "For custom subtitles, the third argument should represent the number of words to be used as the custom subtitle content.";
			}
			if (arguments.Count < 4)
			{
				return "Announcement is empty";
			}
			string customSubtitles = RAUtils.FormatArguments(arguments, 3, result);
			new CassieAnnouncement(new CassieTtsPayload(RAUtils.FormatArguments(arguments, 3 + result).ToUpper(), customSubtitles, playBackground), 0f, 0f).AddToQueue();
			return null;
		}
	}
}
