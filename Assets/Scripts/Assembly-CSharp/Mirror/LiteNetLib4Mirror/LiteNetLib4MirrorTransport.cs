using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Net.Sockets;
using System.Threading;
using LiteNetLib;
using LiteNetLib.Utils;
using LiteNetLib4Mirror.Open.Nat;
using UnityEngine;

namespace Mirror.LiteNetLib4Mirror
{
	public class LiteNetLib4MirrorTransport : Transport
	{
		public static LiteNetLib4MirrorTransport Singleton;

		public string clientAddress = "127.0.0.1";

		public string serverIPv4BindAddress = "0.0.0.0";

		public string serverIPv6BindAddress = "::";

		public ushort port = 7777;

		public bool useUpnP = true;

		public ushort maxConnections = 20;

		public bool ipv6Enabled = true;

		public DeliveryMethod[] channels = new DeliveryMethod[5]
		{
			DeliveryMethod.ReliableOrdered,
			DeliveryMethod.Unreliable,
			DeliveryMethod.Sequenced,
			DeliveryMethod.ReliableSequenced,
			DeliveryMethod.ReliableUnordered
		};

		public string authCode;

		public int updateTime = 15;

		public int pingInterval = 1000;

		public int disconnectTimeout = 5000;

		public int reconnectDelay = 500;

		public int maxConnectAttempts = 10;

		public bool useNativeSockets;

		public bool simulatePacketLoss;

		public int simulationPacketLossChance = 10;

		public bool simulateLatency;

		public int simulationMinLatency = 30;

		public int simulationMaxLatency = 100;

		public UnityEventError onClientSocketError;

		public UnityEventIntError onServerSocketError;

		internal static bool Polling;

		internal ConcurrentQueue<Action> Events;

		private static readonly NetDataWriter ConnectWriter = new NetDataWriter();

		private Thread _pollThread;

		protected virtual void GetConnectData(NetDataWriter writer)
		{
			writer.Put(GetConnectKey());
		}

		protected internal virtual void ProcessConnectionRequest(ConnectionRequest request)
		{
			if (LiteNetLib4MirrorCore.Host.ConnectedPeersCount >= maxConnections)
			{
				request.Reject();
			}
			else if (request.AcceptIfKey(LiteNetLib4MirrorServer.Code) == null)
			{
				Debug.LogWarning("Client tried to join with an invalid auth code! Current code:" + LiteNetLib4MirrorServer.Code);
			}
		}

		protected internal virtual void OnConncetionRefused(DisconnectInfo disconnectinfo)
		{
		}

		internal void InitializeTransport()
		{
			if (Singleton == null)
			{
				Singleton = this;
				LiteNetLib4MirrorCore.State = LiteNetLib4MirrorCore.States.Idle;
			}
		}

		private static string GetConnectKey()
		{
			return LiteNetLib4MirrorUtils.ToBase64(Application.productName + Application.companyName + Application.unityVersion + "1.2.8" + Singleton.authCode);
		}

		private void Awake()
		{
			InitializeTransport();
		}

		private new void LateUpdate()
		{
			if (Polling && Events != null)
			{
				Action result;
				while (Events.TryDequeue(out result))
				{
					result();
				}
			}
		}

		private void OnDestroy()
		{
			LiteNetLib4MirrorCore.StopTransport();
			if (LiteNetLib4MirrorUtils.LastForwardedPort != 0)
			{
				NatDiscoverer.ReleaseAll();
				LiteNetLib4MirrorUtils.LastForwardedPort = 0;
			}
		}

		private void StartThreads()
		{
			Events = new ConcurrentQueue<Action>();
			_pollThread = new Thread(PollingLoop)
			{
				Name = "NetworkPollThread",
				IsBackground = true
			};
			_pollThread.Start();
		}

		private void StopThreads()
		{
			if (_pollThread != null)
			{
				_pollThread.Join();
			}
			_pollThread = null;
		}

		private void PollingLoop()
		{
			Debug.Log("PollingLoop started");
			while (LiteNetLib4MirrorClient.IsConnected() || LiteNetLib4MirrorServer.IsActive())
			{
				try
				{
					LiteNetLib4MirrorCore.Host.PollEvents();
				}
				catch (Exception ex)
				{
					if (ex is ThreadAbortException)
					{
						break;
					}
					Debug.LogException(ex);
				}
				Thread.Sleep(30);
			}
			Debug.Log("PollingLoop stopped");
		}

		public override bool Available()
		{
			return Application.platform != RuntimePlatform.WebGLPlayer;
		}

		public override bool ClientConnected()
		{
			return LiteNetLib4MirrorClient.IsConnected();
		}

		public override void ClientConnect(string address)
		{
			clientAddress = address;
			ConnectWriter.Reset();
			GetConnectData(ConnectWriter);
			LiteNetLib4MirrorClient.ConnectClient(ConnectWriter);
			StartThreads();
		}

		public override void ClientSend(ArraySegment<byte> data, int channelId = 0)
		{
			byte b = (byte)((channelId < channels.Length) ? ((uint)channelId) : 0u);
			LiteNetLib4MirrorClient.Send(channels[b], data.Array, data.Offset, data.Count, b);
		}

		public override void ClientDisconnect()
		{
			if (!LiteNetLib4MirrorServer.IsActive())
			{
				LiteNetLib4MirrorCore.StopTransport();
				LiteNetLib4MirrorCore.LastDisconnectError = SocketError.Success;
				LiteNetLib4MirrorCore.LastDisconnectReason = DisconnectReason.DisconnectPeerCalled;
				OnClientDisconnected();
			}
		}

		public override Uri ServerUri()
		{
			return new Uri($"{serverIPv4BindAddress}:{port}");
		}

		public override bool ServerActive()
		{
			return LiteNetLib4MirrorServer.IsActive();
		}

		public override void ServerStart()
		{
			LiteNetLib4MirrorServer.StartServer(GetConnectKey());
			StartThreads();
		}

		public bool ServerSend(List<int> connectionIds, int channelId, ArraySegment<byte> data)
		{
			byte channelNumber = (byte)((channelId < channels.Length) ? ((uint)channelId) : 0u);
			bool flag = true;
			foreach (int connectionId in connectionIds)
			{
				flag &= LiteNetLib4MirrorServer.Send(connectionId, channels[0], data.Array, data.Offset, data.Count, channelNumber);
			}
			return flag;
		}

		public override void ServerSend(int connectionId, ArraySegment<byte> data, int channelId = 0)
		{
			byte b = (byte)((channelId < channels.Length) ? ((uint)channelId) : 0u);
			LiteNetLib4MirrorServer.Send(connectionId, channels[b], data.Array, data.Offset, data.Count, b);
		}

		public override void ServerDisconnect(int connectionId)
		{
			if (connectionId != 0)
			{
				LiteNetLib4MirrorServer.Disconnect(connectionId);
			}
		}

		public override void ServerStop()
		{
			LiteNetLib4MirrorCore.StopTransport();
			LiteNetLib4MirrorServer.Stop();
			StopThreads();
		}

		public override string ServerGetClientAddress(int connectionId)
		{
			return LiteNetLib4MirrorServer.GetClientAddress(connectionId);
		}

		public override void Shutdown()
		{
			LiteNetLib4MirrorCore.StopTransport();
			LiteNetLib4MirrorServer.Stop();
			StopThreads();
		}

		public override int GetMaxPacketSize(int channelId = 0)
		{
			return LiteNetLib4MirrorCore.GetMaxPacketSize(channels[channelId]);
		}

		public override string ToString()
		{
			return LiteNetLib4MirrorCore.GetState();
		}
	}
}
