using System;

namespace LiteNetLib
{
	[Flags]
	public enum LocalAddrType
	{
		IPv4 = 1,
		IPv6 = 2,
		All = IPv4 | IPv6
	}
}
