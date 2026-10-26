using System;
using System.Collections.Generic;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;

namespace LiteNetLib
{
	public static class NetUtils
	{
		private static readonly NetworkSorter NetworkSorter = new NetworkSorter();

		private static readonly List<string> IpList = new List<string>();

		public static IPEndPoint MakeEndPoint(string hostStr, int port)
		{
			return new IPEndPoint(ResolveAddress(hostStr), port);
		}

		public static IPAddress ResolveAddress(string hostStr)
		{
			if (hostStr == "localhost")
			{
				return IPAddress.Loopback;
			}
			if (!IPAddress.TryParse(hostStr, out var address))
			{
				if (LiteNetManager.IPv6Support)
				{
					address = ResolveAddress(hostStr, AddressFamily.InterNetworkV6);
				}
				if (address == null)
				{
					address = ResolveAddress(hostStr, AddressFamily.InterNetwork);
				}
			}
			if (address == null)
			{
				throw new ArgumentException("Invalid address: " + hostStr);
			}
			return address;
		}

		public static IPAddress ResolveAddress(string hostStr, AddressFamily addressFamily)
		{
			IPAddress[] addressList = Dns.GetHostEntry(hostStr).AddressList;
			foreach (IPAddress iPAddress in addressList)
			{
				if (iPAddress.AddressFamily == addressFamily)
				{
					return iPAddress;
				}
			}
			return null;
		}

		public static List<string> GetLocalIpList(LocalAddrType addrType)
		{
			List<string> list = new List<string>();
			GetLocalIpList(list, addrType);
			return list;
		}

		public static void GetLocalIpList(IList<string> targetList, LocalAddrType addrType)
		{
			bool flag = (addrType & LocalAddrType.IPv4) == LocalAddrType.IPv4;
			bool flag2 = (addrType & LocalAddrType.IPv6) == LocalAddrType.IPv6;
			try
			{
				NetworkInterface[] allNetworkInterfaces = NetworkInterface.GetAllNetworkInterfaces();
				Array.Sort(allNetworkInterfaces, NetworkSorter);
				NetworkInterface[] array = allNetworkInterfaces;
				foreach (NetworkInterface networkInterface in array)
				{
					if (networkInterface.NetworkInterfaceType == NetworkInterfaceType.Loopback || networkInterface.OperationalStatus != OperationalStatus.Up)
					{
						continue;
					}
					IPInterfaceProperties iPProperties = networkInterface.GetIPProperties();
					if (iPProperties.GatewayAddresses.Count == 0)
					{
						continue;
					}
					foreach (UnicastIPAddressInformation unicastAddress in iPProperties.UnicastAddresses)
					{
						IPAddress address = unicastAddress.Address;
						if ((flag && address.AddressFamily == AddressFamily.InterNetwork) || (flag2 && address.AddressFamily == AddressFamily.InterNetworkV6))
						{
							targetList.Add(address.ToString());
						}
					}
				}
				if (targetList.Count == 0)
				{
					IPAddress[] addressList = Dns.GetHostEntry(Dns.GetHostName()).AddressList;
					foreach (IPAddress iPAddress in addressList)
					{
						if ((flag && iPAddress.AddressFamily == AddressFamily.InterNetwork) || (flag2 && iPAddress.AddressFamily == AddressFamily.InterNetworkV6))
						{
							targetList.Add(iPAddress.ToString());
						}
					}
				}
			}
			catch
			{
			}
			if (targetList.Count == 0)
			{
				if (flag)
				{
					targetList.Add("127.0.0.1");
				}
				if (flag2)
				{
					targetList.Add("::1");
				}
			}
		}

		public static string GetLocalIp(LocalAddrType addrType)
		{
			lock (IpList)
			{
				IpList.Clear();
				GetLocalIpList(IpList, addrType);
				return (IpList.Count == 0) ? string.Empty : IpList[0];
			}
		}

		internal static void PrintInterfaceInfos()
		{
			try
			{
				NetworkInterface[] allNetworkInterfaces = NetworkInterface.GetAllNetworkInterfaces();
				for (int i = 0; i < allNetworkInterfaces.Length; i++)
				{
					foreach (UnicastIPAddressInformation unicastAddress in allNetworkInterfaces[i].GetIPProperties().UnicastAddresses)
					{
						if (unicastAddress.Address.AddressFamily != AddressFamily.InterNetwork)
						{
							_ = unicastAddress.Address.AddressFamily;
							_ = 23;
						}
					}
				}
			}
			catch (Exception)
			{
			}
		}

		internal static int RelativeSequenceNumber(int number, int expected)
		{
			return (number - expected + 32768 + 16384) % 32768 - 16384;
		}

		internal static T[] AllocatePinnedUninitializedArray<T>(int count) where T : unmanaged
		{
			return new T[count];
		}
	}
}
