using System;
using System.Collections.Concurrent;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using LiteNetLib;
using LiteNetLib.Utils;
using UnityEngine;

namespace Mirror.LiteNetLib4Mirror
{
	public static class LiteNetLib4MirrorServer
	{
		public static ConcurrentDictionary<int, NetPeer> Peers;

		internal static string DisconnectMessage = null;

		private static readonly NetDataWriter Writer = new NetDataWriter();

		private static string _lastMessage;

		private static Thread _connectionRequestThread;

		private static ConcurrentQueue<ConnectionRequest> _connectionRequests;

		public static string Code { get; internal set; }

		public static int GetPing(int id)
		{
			return Peers[id].Ping;
		}

		internal static bool IsActive()
		{
			return LiteNetLib4MirrorCore.State == LiteNetLib4MirrorCore.States.Server;
		}

		internal static void StartServer(string code)
		{
			try
			{
				Code = code;
				EventBasedNetListener eventBasedNetListener = new EventBasedNetListener();
				LiteNetLib4MirrorCore.Host = new NetManager(eventBasedNetListener);
				eventBasedNetListener.ConnectionRequestEvent += OnConnectionRequest;
				eventBasedNetListener.PeerDisconnectedEvent += OnPeerDisconnected;
				eventBasedNetListener.NetworkErrorEvent += OnNetworkError;
				eventBasedNetListener.NetworkReceiveEvent += OnNetworkReceive;
				eventBasedNetListener.PeerConnectedEvent += OnPeerConnected;
				if (LiteNetLib4MirrorDiscovery.Singleton != null)
				{
					eventBasedNetListener.NetworkReceiveUnconnectedEvent += LiteNetLib4MirrorDiscovery.OnDiscoveryRequest;
				}
				LiteNetLib4MirrorCore.SetOptions(server: true);
				if (LiteNetLib4MirrorTransport.Singleton.useUpnP)
				{
					LiteNetLib4MirrorUtils.ForwardPort();
				}
				LiteNetLib4MirrorCore.Host.Start(LiteNetLib4MirrorUtils.Parse(LiteNetLib4MirrorTransport.Singleton.serverIPv4BindAddress), LiteNetLib4MirrorUtils.Parse(LiteNetLib4MirrorTransport.Singleton.serverIPv6BindAddress), LiteNetLib4MirrorTransport.Singleton.port);
				Peers = new ConcurrentDictionary<int, NetPeer>();
				LiteNetLib4MirrorTransport.Polling = true;
				LiteNetLib4MirrorCore.State = LiteNetLib4MirrorCore.States.Server;
				_connectionRequests = new ConcurrentQueue<ConnectionRequest>();
				_connectionRequestThread = new Thread(ConnectionRequestLoop)
				{
					Name = "ConnectionRequestThread",
					IsBackground = true
				};
				_connectionRequestThread.Start();
			}
			catch (Exception exception)
			{
				LiteNetLib4MirrorCore.State = LiteNetLib4MirrorCore.States.Idle;
				Debug.LogException(exception);
			}
		}

		private static void OnPeerConnected(NetPeer peer)
		{
			LiteNetLib4MirrorTransport.Singleton.Events.Enqueue(() =>
			{
				Peers[peer.Id + 1] = peer;
				LiteNetLib4MirrorTransport.Singleton.OnServerConnected(peer.Id + 1);
			});
		}

		private static void OnNetworkReceive(NetPeer peer, NetPacketReader reader, byte channel, DeliveryMethod deliverymethod)
		{
			LiteNetLib4MirrorTransport.Singleton.Events.Enqueue(() =>
			{
				LiteNetLib4MirrorTransport.Singleton.OnServerDataReceived(peer.Id + 1, reader.GetRemainingBytesSegment(), -1);
				reader.Recycle();
			});
		}

		private static void OnNetworkError(IPEndPoint endpoint, SocketError socketerror)
		{
			LiteNetLib4MirrorTransport.Singleton.Events.Enqueue(() =>
			{
				LiteNetLib4MirrorCore.LastError = socketerror;
				foreach (NetPeer value in Peers.Values)
				{
					if (value != null && value.EndPoint.Equals(endpoint))
					{
						LiteNetLib4MirrorTransport.Singleton.OnServerError(value.Id + 1, TransportError.Unexpected, $"Socket exception: {(int)socketerror}");
						LiteNetLib4MirrorTransport.Singleton.onServerSocketError.Invoke(value.Id + 1, socketerror);
						break;
					}
				}
			});
		}

		private static void OnPeerDisconnected(NetPeer peer, DisconnectInfo disconnectinfo)
		{
			LiteNetLib4MirrorTransport.Singleton.Events.Enqueue(() =>
			{
				LiteNetLib4MirrorCore.LastDisconnectError = disconnectinfo.SocketErrorCode;
				LiteNetLib4MirrorCore.LastDisconnectReason = disconnectinfo.Reason;
				LiteNetLib4MirrorTransport.Singleton.OnServerDisconnected(peer.Id + 1);
				Peers.TryRemove(peer.Id + 1, out var _);
			});
		}

		private static void ConnectionRequestLoop()
		{
			Debug.Log("ConnectionRequestLoop started");
			while (IsActive())
			{
				try
				{
					ConnectionRequest result;
					while (_connectionRequests.TryDequeue(out result))
					{
						try
						{
							LiteNetLib4MirrorTransport.Singleton.ProcessConnectionRequest(result);
						}
						catch (Exception ex)
						{
							Debug.LogError("Malformed join request! Rejecting... Error:" + ex.Message + "\n" + ex.StackTrace);
							result.Reject();
						}
					}
					Thread.Sleep(30);
				}
				catch (Exception ex2)
				{
					if (ex2 is ThreadAbortException)
					{
						break;
					}
					Debug.LogException(ex2);
				}
			}
			Debug.Log("ConnectionRequestLoop stopped");
		}

		private static void OnConnectionRequest(ConnectionRequest request)
		{
			_connectionRequests.Enqueue(request);
		}

		internal static bool Send(int connectionId, DeliveryMethod method, byte[] data, int start, int length, byte channelNumber)
		{
			try
			{
				Peers[connectionId].Send(data, start, length, channelNumber, method);
				return true;
			}
			catch
			{
				return false;
			}
		}

		internal static bool Disconnect(int connectionId)
		{
			try
			{
				if (DisconnectMessage == null)
				{
					Peers[connectionId].Disconnect();
				}
				else
				{
					Peers[connectionId].Disconnect(LiteNetLib4MirrorUtils.ReusePut(Writer, DisconnectMessage, ref _lastMessage));
				}
				return true;
			}
			catch
			{
				return false;
			}
		}

		internal static string GetClientAddress(int connectionId)
		{
			return Peers[connectionId].EndPoint.Address.ToString();
		}

		internal static void Stop()
		{
			if (_connectionRequestThread != null)
			{
				_connectionRequestThread.Join();
			}
			_connectionRequestThread = null;
		}

		internal static int GetPendingConnectionRequestsCount()
		{
			return _connectionRequests.Count;
		}
	}
}
