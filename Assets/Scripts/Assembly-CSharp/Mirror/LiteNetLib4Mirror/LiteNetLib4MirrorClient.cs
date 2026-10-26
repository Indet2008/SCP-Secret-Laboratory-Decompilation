using System;
using System.Net;
using System.Net.Sockets;
using LiteNetLib;
using LiteNetLib.Utils;
using UnityEngine;

namespace Mirror.LiteNetLib4Mirror
{
	public static class LiteNetLib4MirrorClient
	{
		public static string LastDisconnectReason { get; private set; }

		public static int GetPing()
		{
			return LiteNetLib4MirrorCore.Host.FirstPeer.Ping;
		}

		internal static bool IsConnected()
		{
			if (LiteNetLib4MirrorCore.State != LiteNetLib4MirrorCore.States.ClientConnected)
			{
				return LiteNetLib4MirrorCore.State == LiteNetLib4MirrorCore.States.ClientConnecting;
			}
			return true;
		}

		internal static void ConnectClient(NetDataWriter data)
		{
			try
			{
				if (LiteNetLib4MirrorCore.State == LiteNetLib4MirrorCore.States.Discovery)
				{
					LiteNetLib4MirrorCore.StopTransport();
				}
				EventBasedNetListener eventBasedNetListener = new EventBasedNetListener();
				LiteNetLib4MirrorCore.Host = new NetManager(eventBasedNetListener);
				eventBasedNetListener.NetworkReceiveEvent += OnNetworkReceive;
				eventBasedNetListener.NetworkErrorEvent += OnNetworkError;
				eventBasedNetListener.PeerConnectedEvent += OnPeerConnected;
				eventBasedNetListener.PeerDisconnectedEvent += OnPeerDisconnected;
				LiteNetLib4MirrorCore.SetOptions(server: false);
				LiteNetLib4MirrorCore.Host.Start();
				LiteNetLib4MirrorCore.Host.Connect(LiteNetLib4MirrorUtils.Parse(LiteNetLib4MirrorTransport.Singleton.clientAddress, LiteNetLib4MirrorTransport.Singleton.port), data);
				LiteNetLib4MirrorTransport.Polling = true;
				LiteNetLib4MirrorCore.State = LiteNetLib4MirrorCore.States.ClientConnecting;
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
				LastDisconnectReason = null;
				LiteNetLib4MirrorCore.State = LiteNetLib4MirrorCore.States.ClientConnected;
				LiteNetLib4MirrorTransport.Singleton.OnClientConnected();
			});
		}

		private static void OnPeerDisconnected(NetPeer peer, DisconnectInfo disconnectinfo)
		{
			LiteNetLib4MirrorTransport.Singleton.Events.Enqueue(() =>
			{
				DisconnectReason reason = disconnectinfo.Reason;
				if (reason != DisconnectReason.DisconnectPeerCalled)
				{
					if (reason != DisconnectReason.ConnectionRejected)
					{
						goto IL_0055;
					}
					LiteNetLib4MirrorTransport.Singleton.OnConncetionRefused(disconnectinfo);
					LastDisconnectReason = null;
				}
				else
				{
					if (!disconnectinfo.AdditionalData.TryGetString(out var result) || string.IsNullOrWhiteSpace(result))
					{
						goto IL_0055;
					}
					LastDisconnectReason = LiteNetLib4MirrorUtils.FromBase64(result);
				}
				goto IL_005b;
				IL_005b:
				LiteNetLib4MirrorCore.State = LiteNetLib4MirrorCore.States.Idle;
				LiteNetLib4MirrorCore.LastDisconnectError = disconnectinfo.SocketErrorCode;
				LiteNetLib4MirrorCore.LastDisconnectReason = disconnectinfo.Reason;
				LiteNetLib4MirrorTransport.Singleton.OnClientDisconnected();
				LiteNetLib4MirrorCore.StopTransport();
				return;
				IL_0055:
				LastDisconnectReason = null;
				goto IL_005b;
			});
		}

		private static void OnNetworkReceive(NetPeer peer, NetPacketReader reader, byte channel, DeliveryMethod deliverymethod)
		{
			LiteNetLib4MirrorTransport.Singleton.Events.Enqueue(() =>
			{
				LiteNetLib4MirrorTransport.Singleton.OnClientDataReceived(reader.GetRemainingBytesSegment(), -1);
				reader.Recycle();
			});
		}

		private static void OnNetworkError(IPEndPoint endpoint, SocketError socketerror)
		{
			LiteNetLib4MirrorTransport.Singleton.Events.Enqueue(() =>
			{
				LiteNetLib4MirrorCore.LastError = socketerror;
				LiteNetLib4MirrorTransport.Singleton.OnClientError(TransportError.Unexpected, $"Socket exception: {(int)socketerror}");
				LiteNetLib4MirrorTransport.Singleton.onClientSocketError.Invoke(socketerror);
			});
		}

		internal static bool Send(DeliveryMethod method, byte[] data, int start, int length, byte channelNumber)
		{
			try
			{
				LiteNetLib4MirrorCore.Host.FirstPeer.Send(data, start, length, channelNumber, method);
				return true;
			}
			catch
			{
				return false;
			}
		}
	}
}
