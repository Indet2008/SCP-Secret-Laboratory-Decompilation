using System;

namespace LiteNetLib
{
	[Flags]
	public enum ConnectionState : byte
	{
		Outgoing = 2,
		Connected = 4,
		ShutdownRequested = 8,
		Disconnected = 0x10,
		EndPointChange = 0x20,
		Any = Outgoing | Connected | ShutdownRequested | EndPointChange
	}
}
