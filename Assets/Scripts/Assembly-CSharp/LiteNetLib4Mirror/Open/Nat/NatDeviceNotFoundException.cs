using System;
using System.Runtime.Serialization;

namespace LiteNetLib4Mirror.Open.Nat
{
	[Serializable]
	public class NatDeviceNotFoundException : Exception
	{
		public NatDeviceNotFoundException()
		{
		}

		public NatDeviceNotFoundException(string message)
			: base(message)
		{
		}

		public NatDeviceNotFoundException(string message, Exception innerException)
			: base(message, innerException)
		{
		}

		protected NatDeviceNotFoundException(SerializationInfo info, StreamingContext context)
			: base(info, context)
		{
		}
	}
}
