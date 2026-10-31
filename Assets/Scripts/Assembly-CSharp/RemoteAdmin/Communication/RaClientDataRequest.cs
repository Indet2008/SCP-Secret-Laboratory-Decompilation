using System.Text;
using RemoteAdmin.Interfaces;

namespace RemoteAdmin.Communication
{
	public abstract class RaClientDataRequest : IServerCommunication, IClientCommunication
	{
		private readonly StringBuilder _stringBuilder = new StringBuilder();

		public abstract int DataId { get; }

		public event System.Action<string> OnDataReceived;

		public virtual void ReceiveData(string data, bool secure)
		{
			OnDataReceived?.Invoke(data);
		}

		public void Request()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && Mirror.NetworkClient.active)
			{
				hub.queryProcessor.SendQuery(string.Format("${0} 0", DataId));
			}
		}

		public virtual void ReceiveData(CommandSender sender, string data)
		{
			_stringBuilder.Clear();
			_stringBuilder.Append('$').Append(DataId).Append(' ');
			GatherData();
			sender.RaReply($"${DataId} {_stringBuilder}", success: true, logToConsole: false, string.Empty);
		}

		protected abstract void GatherData();

		protected void AppendData(object data)
		{
			_stringBuilder.Append(data).Append(',');
		}

		protected void AppendString(string str)
		{
			_stringBuilder.Append(str);
		}

		protected int CastBool(bool value)
		{
			if (!value)
			{
				return 0;
			}
			return 1;
		}
	}
}
