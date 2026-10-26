using System;
using System.Collections.Generic;
using RemoteAdmin.Interfaces;
using Utils;

namespace RemoteAdmin.Communication
{
	public class RaPlayerAuth : IServerCommunication
	{
		public int DataId => 3;

		public void ReceiveData(CommandSender sender, string data)
		{
			if (sender is PlayerCommandSender playerCommandSender && !playerCommandSender.ReferenceHub.authManager.RemoteAdminGlobalAccess && !CommandProcessor.CheckPermissions(sender, PlayerPermissions.PlayerSensitiveDataAccess))
			{
				return;
			}
			List<ReferenceHub> list = RAUtils.ProcessPlayerIdOrNamesList(new ArraySegment<string>(data.Split(' ')), 0, out var _);
			if (list.Count != 0 && list.Count <= 1)
			{
				if (list[0].authManager.AuthenticationResponse.AuthToken == null)
				{
					sender.RaReply("PlayerInfo#Can't obtain auth token. Is server using offline mode or you selected the host?", success: false, logToConsole: true, "PlayerInfo");
					return;
				}
				ServerLogs.AddLog(ServerLogs.Modules.DataAccess, $"{sender.LogName} accessed authentication token of player {list[0].PlayerId} ({list[0].nicknameSync.MyNick}).", ServerLogs.ServerLogType.RemoteAdminActivity_Misc);
				sender.RaReply("PlayerInfo#<color=white>Displayed Authentication token of player " + list[0].LoggedNameFromRefHub() + "</color>", success: true, logToConsole: true, "null");
				RaPlayerQR.Send(sender, isBig: true, list[0].authManager.GetAuthToken());
			}
		}
	}
}
