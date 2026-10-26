using System;
using System.Collections.Generic;
using CentralAuth;
using Mirror;

namespace Utils.Networking
{
	public static class NetworkUtils
	{
		private static ArraySegment<byte> _segmentNonAlloc;

		public static Dictionary<uint, NetworkIdentity> SpawnedNetIds
		{
			get
			{
				if (NetworkServer.active)
				{
					return NetworkServer.spawned;
				}
				if (NetworkClient.active)
				{
					return NetworkClient.spawned;
				}
				throw new Exception("SpawnedNetIds was accessed before NetworkServer/NetworkClient were active.");
			}
		}

		public static void SendToAuthenticated<T>(this T message, int channelId = 0) where T : struct, NetworkMessage
		{
			message.SendToHubsConditionally((ReferenceHub x) => x.Mode != ClientInstanceMode.Unverified, channelId);
		}

		public static void SendToHubsConditionally<T>(this T msg, Func<ReferenceHub, bool> predicate, int channelId = 0) where T : struct, NetworkMessage
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Can not use SendToHubsConditionally because NetworkServer is not active!");
			}
			using NetworkWriterPooled networkWriterPooled = NetworkWriterPool.Get();
			bool flag = false;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (predicate(allHub))
				{
					if (!flag)
					{
						NetworkMessages.Pack(msg, networkWriterPooled);
						_segmentNonAlloc = networkWriterPooled.ToArraySegment();
						flag = true;
					}
					allHub.connectionToClient.Send(_segmentNonAlloc, channelId);
				}
			}
		}
	}
}
