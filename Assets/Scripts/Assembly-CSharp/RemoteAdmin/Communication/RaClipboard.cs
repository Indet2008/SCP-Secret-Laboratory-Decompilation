using RemoteAdmin.Interfaces;

namespace RemoteAdmin.Communication
{
	public class RaClipboard : IClientCommunication
	{
		public enum RaClipBoardType
		{
			Ip = 0,
			UserId = 1,
			PlayerId = 2
		}

		public static string UserIds { get; set; } = string.Empty;

		public static string PlayerIps { get; set; } = string.Empty;

		public static string PlayerIds { get; set; } = string.Empty;

		public int DataId => 6;

		public static void Reset()
		{
			UserIds = string.Empty;
			PlayerIps = string.Empty;
			PlayerIds = string.Empty;
		}

		public void ReceiveData(string data, bool secure = true)
		{
			int num = data.IndexOf(' ');
			if (num > 0 && int.TryParse(data.Substring(0, num), out var result))
			{
				string text = data.Substring(num + 1);
				switch ((RaClipBoardType)result)
				{
				case RaClipBoardType.Ip:
					PlayerIps = text;
					break;
				case RaClipBoardType.UserId:
					UserIds = text;
					break;
				case RaClipBoardType.PlayerId:
					PlayerIds = text;
					break;
				}
			}
		}

		public static void Send(CommandSender sender, RaClipBoardType type, string data)
		{
			sender.RaReply($"$6 {(int)type} {data}", success: true, logToConsole: false, string.Empty);
		}
	}
}