using System;
using System.Linq;
using RemoteAdmin.Interfaces;

namespace RemoteAdmin.Communication
{
	public class RaGlobalBan : IServerCommunication, IClientCommunication
	{
		public int DataId => 5;

		public void ReceiveData(CommandSender sender, string data)
		{
			string[] array = data.Split(' ');
			if (array.Length < 2 || !int.TryParse(array[0], out var result))
			{
				return;
			}
			bool flag = result == 1;
			data = string.Join(" ", array.Skip(1));
			if (!(sender is PlayerCommandSender playerCommandSender) || !playerCommandSender.ReferenceHub.authManager.RemoteAdminGlobalAccess)
			{
				return;
			}
			ReferenceHub referenceHub = null;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((flag && allHub.PlayerId.ToString() == data) || (!flag && string.Equals(allHub.nicknameSync.MyNick, data, StringComparison.OrdinalIgnoreCase)))
				{
					referenceHub = allHub;
					break;
				}
			}
			if (referenceHub == null || referenceHub.authManager.AuthenticationResponse.SignedAuthToken == null)
			{
				sender.RaReply($"${DataId} 0", success: true, logToConsole: false, string.Empty);
			}
			else
			{
				sender.RaReply($"${DataId} 1 {referenceHub.authManager.GetAuthToken()}", success: true, logToConsole: false, string.Empty);
			}
		}

		public void ReceiveData(string data, bool secure)
		{
		}
	}
}
