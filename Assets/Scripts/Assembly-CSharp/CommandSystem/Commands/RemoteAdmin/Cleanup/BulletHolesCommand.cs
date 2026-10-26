using System;
using Decals;
using Utils.Networking;

namespace CommandSystem.Commands.RemoteAdmin.Cleanup
{
	[CommandHandler(typeof(CleanupCommand))]
	public class BulletHolesCommand : ICommand
	{
		public string Command { get; } = "bulletholes";

		public string[] Aliases { get; } = new string[2] { "bh", "bullets" };

		public string Description { get; } = "Cleans up bulled holes from the map.";

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			if (!sender.CheckPermission(PlayerPermissions.FacilityManagement, out response))
			{
				return false;
			}
			if (!arguments.Array.TryGet(2, out var element) || !int.TryParse(element, out var result))
			{
				result = int.MaxValue;
			}
			DecalPoolType[] values = EnumUtils<DecalPoolType>.Values;
			foreach (DecalPoolType decalPoolType in values)
			{
				if (decalPoolType != DecalPoolType.None && decalPoolType != DecalPoolType.Blood)
				{
					new DecalCleanupMessage(decalPoolType, result).SendToAuthenticated();
				}
			}
			response = "Cleaned up bullet holes!";
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, sender.LogName + " has force-cleaned up bullet holes.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
			return true;
		}
	}
}
