using System;

namespace LiteNetLib4Mirror.Open.Nat
{
	internal class DeviceEventArgs : EventArgs
	{
		public NatDevice Device { get; private set; }

		public DeviceEventArgs(NatDevice device)
		{
			Device = device;
		}
	}
}
