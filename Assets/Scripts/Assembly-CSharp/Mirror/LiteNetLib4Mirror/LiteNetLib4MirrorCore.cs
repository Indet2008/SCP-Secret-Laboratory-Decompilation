using System.Net.Sockets;
using LiteNetLib;

namespace Mirror.LiteNetLib4Mirror
{
	public static class LiteNetLib4MirrorCore
	{
		public enum States : byte
		{
			NonInitialized = 0,
			Idle = 1,
			Discovery = 2,
			ClientConnecting = 3,
			ClientConnected = 4,
			Server = 5
		}

		public const string TransportVersion = "1.2.8";

		public static SocketError LastError { get; internal set; }

		public static SocketError LastDisconnectError { get; internal set; }

		public static DisconnectReason LastDisconnectReason { get; internal set; }

		public static NetManager Host { get; internal set; }

		public static States State { get; internal set; }

		internal static string GetState()
		{
			return State switch
			{
				States.NonInitialized => "LiteNetLib4Mirror isn't initialized", 
				States.Idle => "LiteNetLib4Mirror Transport idle", 
				States.ClientConnecting => $"LiteNetLib4Mirror Client Connecting to {LiteNetLib4MirrorTransport.Singleton.clientAddress}:{LiteNetLib4MirrorTransport.Singleton.port}", 
				States.ClientConnected => $"LiteNetLib4Mirror Client Connected to {LiteNetLib4MirrorTransport.Singleton.clientAddress}:{LiteNetLib4MirrorTransport.Singleton.port}", 
				States.Server => $"LiteNetLib4Mirror Server active at IPv4:{LiteNetLib4MirrorTransport.Singleton.serverIPv4BindAddress} IPv6:{LiteNetLib4MirrorTransport.Singleton.serverIPv6BindAddress} Port:{LiteNetLib4MirrorTransport.Singleton.port}", 
				_ => "Invalid state!", 
			};
		}

		internal static void SetOptions(bool server)
		{
			Host.IPv6Enabled = LiteNetLib4MirrorTransport.Singleton.ipv6Enabled;
			Host.UpdateTime = LiteNetLib4MirrorTransport.Singleton.updateTime;
			Host.PingInterval = LiteNetLib4MirrorTransport.Singleton.pingInterval;
			Host.DisconnectTimeout = LiteNetLib4MirrorTransport.Singleton.disconnectTimeout;
			Host.ReconnectDelay = LiteNetLib4MirrorTransport.Singleton.reconnectDelay;
			Host.MaxConnectAttempts = LiteNetLib4MirrorTransport.Singleton.maxConnectAttempts;
			Host.UseNativeSockets = LiteNetLib4MirrorTransport.Singleton.useNativeSockets;
			Host.SimulatePacketLoss = LiteNetLib4MirrorTransport.Singleton.simulatePacketLoss;
			Host.SimulationPacketLossChance = LiteNetLib4MirrorTransport.Singleton.simulationPacketLossChance;
			Host.SimulateLatency = LiteNetLib4MirrorTransport.Singleton.simulateLatency;
			Host.SimulationMinLatency = LiteNetLib4MirrorTransport.Singleton.simulationMinLatency;
			Host.SimulationMaxLatency = LiteNetLib4MirrorTransport.Singleton.simulationMaxLatency;
			Host.BroadcastReceiveEnabled = server && LiteNetLib4MirrorDiscovery.Singleton != null;
			Host.ChannelsCount = (byte)LiteNetLib4MirrorTransport.Singleton.channels.Length;
		}

		internal static void StopTransport()
		{
			if (Host != null)
			{
				LiteNetLib4MirrorServer.Peers = null;
				Host.Stop();
				Host = null;
				LiteNetLib4MirrorTransport.Polling = false;
				State = States.Idle;
			}
		}

		internal static int GetMaxPacketSize(DeliveryMethod channel)
		{
			int num = ((Host != null && Host.FirstPeer != null) ? Host.FirstPeer.Mtu : NetConstants.MaxPacketSize);
			switch (channel)
			{
			case DeliveryMethod.ReliableUnordered:
			case DeliveryMethod.ReliableOrdered:
				return 65535 * (num - 6);
			case DeliveryMethod.Sequenced:
			case DeliveryMethod.ReliableSequenced:
				return num - 4;
			case DeliveryMethod.Unreliable:
				return num - 1;
			default:
				return num - 1;
			}
		}
	}
}
