using System.Collections.Generic;
using System.Net.NetworkInformation;

namespace LiteNetLib
{
	internal class NetworkSorter : IComparer<NetworkInterface>
	{
		public int Compare(NetworkInterface a, NetworkInterface b)
		{
			bool num = a.NetworkInterfaceType == NetworkInterfaceType.Wman || a.NetworkInterfaceType == NetworkInterfaceType.Wwanpp || a.NetworkInterfaceType == NetworkInterfaceType.Wwanpp2;
			bool flag = b.NetworkInterfaceType == NetworkInterfaceType.Wman || b.NetworkInterfaceType == NetworkInterfaceType.Wwanpp || b.NetworkInterfaceType == NetworkInterfaceType.Wwanpp2;
			bool flag2 = a.NetworkInterfaceType == NetworkInterfaceType.Wireless80211;
			bool flag3 = b.NetworkInterfaceType == NetworkInterfaceType.Wireless80211;
			bool flag4 = a.NetworkInterfaceType == NetworkInterfaceType.Ethernet || a.NetworkInterfaceType == NetworkInterfaceType.Ethernet3Megabit || a.NetworkInterfaceType == NetworkInterfaceType.GigabitEthernet || a.NetworkInterfaceType == NetworkInterfaceType.FastEthernetFx || a.NetworkInterfaceType == NetworkInterfaceType.FastEthernetT;
			bool flag5 = b.NetworkInterfaceType == NetworkInterfaceType.Ethernet || b.NetworkInterfaceType == NetworkInterfaceType.Ethernet3Megabit || b.NetworkInterfaceType == NetworkInterfaceType.GigabitEthernet || b.NetworkInterfaceType == NetworkInterfaceType.FastEthernetFx || b.NetworkInterfaceType == NetworkInterfaceType.FastEthernetT;
			bool flag6 = !num && !flag2 && !flag4;
			bool flag7 = !flag && !flag3 && !flag5;
			int num2 = (flag4 ? 3 : (flag2 ? 2 : (flag6 ? 1 : 0)));
			int num3 = (flag5 ? 3 : (flag3 ? 2 : (flag7 ? 1 : 0)));
			if (num2 <= num3)
			{
				if (num2 >= num3)
				{
					return 0;
				}
				return 1;
			}
			return -1;
		}
	}
}
