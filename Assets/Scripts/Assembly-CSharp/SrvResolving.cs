internal static class SrvResolving
{
	private class DnsConsoleLogger : global::DnsClient.Logging.IErrorLogging
	{
		public void LogError(string message)
		{
		}

		public void LogException(string message, global::System.Exception e)
		{
		}

		public DnsConsoleLogger()
		{
		}
	}


	private static global::System.Net.IPEndPoint _dnsEndpoint;

	private static SrvResolving.DnsConsoleLogger _dnsLogger;

	private const ushort DnsMaxAttempts = 3;

	private const ushort DnsTimeout = 350;

	private const ushort DnsTimeoutInnerDelay = 60;

	internal static global::System.Threading.Tasks.Task<global::DnsClient.Data.Records.DnsRecord.SRVRecord> ResolveSRV(string domain)
	{
		return default;
	}

	private static global::DnsClient.Data.Records.DnsRecord.SRVRecord SelectRecord(global::System.Collections.Generic.IReadOnlyList<global::DnsClient.Data.Records.DnsRecord.DNSRecord> records, int randomWeight)
	{
		return default;
	}

	private static global::System.Net.IPAddress FindDnsServer(string defaultServer = "1.1.1.1")
	{
		return default;
	}

	private static global::System.Net.IPAddress FindInternetRoute(global::System.Net.IPAddress address)
	{
		return default;
	}
}
