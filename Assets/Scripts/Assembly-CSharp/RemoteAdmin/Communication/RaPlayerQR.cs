using RemoteAdmin.Interfaces;

namespace RemoteAdmin.Communication
{
	public class RaPlayerQR : IClientCommunication
	{
		public int DataId => 2;

		public void ReceiveData(string data, bool secure)
		{
			int num = data.IndexOf(' ');
			if (num <= 0 || !int.TryParse(data.Substring(0, num), out var result))
			{
				return;
			}
			string text = data.Substring(num + 1);
			if (result == 1)
			{
				LargeDataPrinter.Display(text, replaceToBr: true);
			}
			else if (string.IsNullOrEmpty(text))
			{
				PlayerInfoQR.Clear();
			}
			else
			{
				PlayerInfoQR.Display(text);
			}
		}

		public static void Send(CommandSender sender, bool isBig, string data)
		{
			sender.RaReply($"$2 {(isBig ? 1 : 0)} {data}", success: true, logToConsole: false, string.Empty);
		}
	}
}