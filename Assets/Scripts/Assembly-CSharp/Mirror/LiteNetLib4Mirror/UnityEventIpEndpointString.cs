using System;
using System.Net;
using UnityEngine.Events;

namespace Mirror.LiteNetLib4Mirror
{
	[Serializable]
	public class UnityEventIpEndpointString : UnityEvent<IPEndPoint, string>
	{
	}
}
