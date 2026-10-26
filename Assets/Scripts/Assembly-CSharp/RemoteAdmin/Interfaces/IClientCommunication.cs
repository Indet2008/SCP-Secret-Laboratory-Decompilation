namespace RemoteAdmin.Interfaces
{
	public interface IClientCommunication
	{
		int DataId { get; }

		void ReceiveData(string data, bool secure = true);
	}
}
