namespace RemoteAdmin.Interfaces
{
	public interface IServerCommunication
	{
		int DataId { get; }

		void ReceiveData(CommandSender sender, string data);
	}
}
