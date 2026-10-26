namespace Mirror
{
	public enum TransportError : byte
	{
		DnsResolve = 0,
		Refused = 1,
		Timeout = 2,
		Congestion = 3,
		InvalidReceive = 4,
		InvalidSend = 5,
		ConnectionClosed = 6,
		Unexpected = 7
	}
}
