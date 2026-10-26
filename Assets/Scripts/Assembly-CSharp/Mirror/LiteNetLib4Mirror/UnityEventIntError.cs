using System;
using System.Net.Sockets;
using UnityEngine.Events;

namespace Mirror.LiteNetLib4Mirror
{
	[Serializable]
	public class UnityEventIntError : UnityEvent<int, SocketError>
	{
	}
}
