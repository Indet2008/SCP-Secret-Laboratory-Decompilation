namespace Mirror
{
	public struct NetworkPingMessage : global::Mirror.NetworkMessage
	{
		public double localTime;

		public NetworkPingMessage(double value)
		{
			localTime = value;
		}
	}
}
