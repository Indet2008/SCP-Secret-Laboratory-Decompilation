using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Threading.Tasks;
using DnsClient;
using DnsClient.Data;
using DnsClient.Data.Records;
using DnsClient.Enums;
using DnsClient.Logging;
using UnityEngine;

// Rebuilt from the 14.2.8 client disassembly.
internal static class SrvResolving
{
	private class DnsConsoleLogger : IErrorLogging
	{
		public void LogError(string message)
		{
			GameCore.Console.AddLog("[DNS CLIENT] Error: " + message, Color.red);
		}

		public void LogException(string message, Exception e)
		{
			GameCore.Console.AddLog(string.Format("[DNS CLIENT] Error: {0}{1}Exception: {2} - {3}{4}{5}", message, Environment.NewLine, e.GetType().FullName, e.Message, Environment.NewLine, e.StackTrace), Color.red);
		}
	}

	private static IPEndPoint _dnsEndpoint;

	private static DnsConsoleLogger _dnsLogger;

	private const ushort DnsMaxAttempts = 3;

	private const ushort DnsTimeout = 350;

	private const ushort DnsTimeoutInnerDelay = 60;

	internal static async Task<DnsRecord.SRVRecord> ResolveSRV(string domain)
	{
		if (_dnsEndpoint == null)
		{
			IPAddress iPAddress = FindDnsServer();
			GameCore.Console.AddLog("Using DNS server: " + iPAddress, Color.gray);
			_dnsEndpoint = new IPEndPoint(iPAddress, 53);
		}
		if (_dnsLogger == null)
		{
			_dnsLogger = new DnsConsoleLogger();
		}
		DnsClientOptions value = new DnsClientOptions
		{
			Timeout = 350u,
			ErrorLogging = _dnsLogger,
			MaxAttempts = 3,
			TimeoutInnerDelay = 60
		};
		DnsResponse dnsResponse;
		using (global::DnsClient.DnsClient dnsClient = new global::DnsClient.DnsClient(_dnsEndpoint, value))
		{
			dnsResponse = await dnsClient.Query(new DnsQuery("_scpsl._udp." + domain, QType.SRV, acceptTruncated: false));
		}
		GameCore.Console.AddLog("DNS Query complete.", Color.gray);
		if (dnsResponse.ErrorCode != DnsErrorCode.NoError)
		{
			GameCore.Console.AddLog("DNS Query failed with error " + dnsResponse.ErrorCode.ToString() + ".", Color.red);
			return null;
		}
		if (dnsResponse.Records == null || dnsResponse.Records.Count == 0)
		{
			GameCore.Console.AddLog("No records returned by the DNS query.", Color.yellow);
			return null;
		}
		DnsRecord.DNSRecord[] array = dnsResponse.Records.Where((DnsRecord.DNSRecord r) => r is DnsRecord.SRVRecord).ToArray();
		if (array.Length == 0)
		{
			GameCore.Console.AddLog("No SRV records returned by the DNS query.", Color.yellow);
			return null;
		}
		int maxExclusive = array.Aggregate(0, (int sum, DnsRecord.DNSRecord r) => sum + ((DnsRecord.SRVRecord)r).Weight);
		DnsRecord.SRVRecord sRVRecord = SelectRecord(array, UnityEngine.Random.Range(0, maxExclusive));
		GameCore.Console.AddLog(string.Format("Resolved {0} to {1} and port {2} using a SRV Record! Total SRV records fetched: {3}.", domain, sRVRecord.Target, sRVRecord.Port, array.Length), Color.green);
		return sRVRecord;
	}

	private static DnsRecord.SRVRecord SelectRecord(IReadOnlyList<DnsRecord.DNSRecord> records, int randomWeight)
	{
		int num = 0;
		foreach (DnsRecord.DNSRecord record in records)
		{
			DnsRecord.SRVRecord sRVRecord = (DnsRecord.SRVRecord)record;
			num += sRVRecord.Weight;
			if (randomWeight < num)
			{
				return sRVRecord;
			}
		}
		GameCore.Console.AddLog(string.Format("Random weight picked ({0}) is higher than total sum of records! Selecting first record.", randomWeight), Color.yellow);
		return (DnsRecord.SRVRecord)records[0];
	}

	private static IPAddress FindDnsServer(string defaultServer = "1.1.1.1")
	{
		IPAddress iPAddress = IPAddress.Parse(defaultServer);
		try
		{
			IPAddress route = FindInternetRoute(iPAddress);
			NetworkInterface[] allNetworkInterfaces = NetworkInterface.GetAllNetworkInterfaces();
			foreach (NetworkInterface networkInterface in allNetworkInterfaces)
			{
				if (networkInterface.OperationalStatus != OperationalStatus.Up)
				{
					continue;
				}
				IPInterfaceProperties iPProperties = networkInterface.GetIPProperties();
				if (!iPProperties.UnicastAddresses.Any((UnicastIPAddressInformation u) => u.Address.Equals(route)))
				{
					continue;
				}
				foreach (IPAddress dnsAddress in iPProperties.DnsAddresses)
				{
					if (dnsAddress.AddressFamily == AddressFamily.InterNetwork)
					{
						return dnsAddress;
					}
				}
			}
		}
		catch (Exception ex)
		{
			GameCore.Console.AddLog("Failed to find DNS server: " + ex.Message, Color.yellow);
		}
		return iPAddress;
	}

	private static IPAddress FindInternetRoute(IPAddress address)
	{
		using Socket socket = new Socket(address.AddressFamily, SocketType.Dgram, ProtocolType.Udp);
		byte[] array = new byte[16];
		SocketAddress socketAddress = new IPEndPoint(address, 0).Serialize();
		byte[] array2 = new byte[socketAddress.Size];
		for (int i = 0; i < socketAddress.Size; i++)
		{
			array2[i] = socketAddress[i];
		}
		socket.IOControl(IOControlCode.RoutingInterfaceQuery, array2, array);
		SocketAddress socketAddress2 = new SocketAddress(address.AddressFamily, array.Length);
		for (int j = 0; j < array.Length; j++)
		{
			socketAddress2[j] = array[j];
		}
		if (!(new IPEndPoint(IPAddress.Any, 0).Create(socketAddress2) is IPEndPoint iPEndPoint))
		{
			throw new IndexOutOfRangeException("Couldn't find Internet route. EndPoint is not IPEndPoint! ");
		}
		return iPEndPoint.Address;
	}
}
