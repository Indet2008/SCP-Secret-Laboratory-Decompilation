using System.Collections.Concurrent;
using System.Net;
using System.Net.Sockets;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	public sealed class NatPunchModule
	{
		private struct RequestEventData
		{
			public IPEndPoint LocalEndPoint;

			public IPEndPoint RemoteEndPoint;

			public string Token;
		}

		private struct SuccessEventData
		{
			public IPEndPoint TargetEndPoint;

			public NatAddressType Type;

			public string Token;
		}

		private class NatIntroduceRequestPacket
		{
			public IPEndPoint Internal
			{
				[Preserve]
				get;
				[Preserve]
				set;
			}

			public string Token
			{
				[Preserve]
				get;
				[Preserve]
				set;
			}
		}

		private class NatIntroduceResponsePacket
		{
			public IPEndPoint Internal
			{
				[Preserve]
				get;
				[Preserve]
				set;
			}

			public IPEndPoint External
			{
				[Preserve]
				get;
				[Preserve]
				set;
			}

			public string Token
			{
				[Preserve]
				get;
				[Preserve]
				set;
			}
		}

		private class NatPunchPacket
		{
			public string Token
			{
				[Preserve]
				get;
				[Preserve]
				set;
			}

			public bool IsExternal
			{
				[Preserve]
				get;
				[Preserve]
				set;
			}
		}

		private readonly LiteNetManager _socket;

		private readonly ConcurrentQueue<RequestEventData> _requestEvents = new ConcurrentQueue<RequestEventData>();

		private readonly ConcurrentQueue<SuccessEventData> _successEvents = new ConcurrentQueue<SuccessEventData>();

		private readonly NetDataReader _cacheReader = new NetDataReader();

		private readonly NetDataWriter _cacheWriter = new NetDataWriter();

		private readonly NetPacketProcessor _netPacketProcessor = new NetPacketProcessor(256);

		private INatPunchListener _natPunchListener;

		public const int MaxTokenLength = 256;

		public bool UnsyncedEvents;

		internal NatPunchModule(LiteNetManager socket)
		{
			_socket = socket;
			_netPacketProcessor.SubscribeReusable<NatIntroduceResponsePacket>(OnNatIntroductionResponse);
			_netPacketProcessor.SubscribeReusable<NatIntroduceRequestPacket, IPEndPoint>(OnNatIntroductionRequest);
			_netPacketProcessor.SubscribeReusable<NatPunchPacket, IPEndPoint>(OnNatPunch);
		}

		internal void ProcessMessage(IPEndPoint senderEndPoint, NetPacket packet)
		{
			lock (_cacheReader)
			{
				_cacheReader.SetSource(packet.RawData, 1, packet.Size);
				_netPacketProcessor.ReadAllPackets(_cacheReader, senderEndPoint);
			}
		}

		public void Init(INatPunchListener listener)
		{
			_natPunchListener = listener;
		}

		private void Send<T>(T packet, IPEndPoint target) where T : class, new()
		{
			_cacheWriter.Reset();
			_cacheWriter.Put((byte)16);
			_netPacketProcessor.Write(_cacheWriter, packet);
			_socket.SendRaw(_cacheWriter.Data, 0, _cacheWriter.Length, target);
		}

		public void NatIntroduce(IPEndPoint hostInternal, IPEndPoint hostExternal, IPEndPoint clientInternal, IPEndPoint clientExternal, string additionalInfo)
		{
			NatIntroduceResponsePacket natIntroduceResponsePacket = new NatIntroduceResponsePacket
			{
				Token = additionalInfo
			};
			natIntroduceResponsePacket.Internal = hostInternal;
			natIntroduceResponsePacket.External = hostExternal;
			Send(natIntroduceResponsePacket, clientExternal);
			natIntroduceResponsePacket.Internal = clientInternal;
			natIntroduceResponsePacket.External = clientExternal;
			Send(natIntroduceResponsePacket, hostExternal);
		}

		public void PollEvents()
		{
			if (!UnsyncedEvents && _natPunchListener != null && (!_successEvents.IsEmpty || !_requestEvents.IsEmpty))
			{
				SuccessEventData result;
				while (_successEvents.TryDequeue(out result))
				{
					_natPunchListener.OnNatIntroductionSuccess(result.TargetEndPoint, result.Type, result.Token);
				}
				RequestEventData result2;
				while (_requestEvents.TryDequeue(out result2))
				{
					_natPunchListener.OnNatIntroductionRequest(result2.LocalEndPoint, result2.RemoteEndPoint, result2.Token);
				}
			}
		}

		public void SendNatIntroduceRequest(string host, int port, string additionalInfo)
		{
			SendNatIntroduceRequest(NetUtils.MakeEndPoint(host, port), additionalInfo);
		}

		public void SendNatIntroduceRequest(IPEndPoint masterServerEndPoint, string additionalInfo)
		{
			string localIp = NetUtils.GetLocalIp(LocalAddrType.IPv4);
			if (string.IsNullOrEmpty(localIp) || masterServerEndPoint.AddressFamily == AddressFamily.InterNetworkV6)
			{
				localIp = NetUtils.GetLocalIp(LocalAddrType.IPv6);
			}
			Send(new NatIntroduceRequestPacket
			{
				Internal = NetUtils.MakeEndPoint(localIp, _socket.LocalPort),
				Token = additionalInfo
			}, masterServerEndPoint);
		}

		private void OnNatIntroductionRequest(NatIntroduceRequestPacket req, IPEndPoint senderEndPoint)
		{
			if (UnsyncedEvents)
			{
				_natPunchListener.OnNatIntroductionRequest(req.Internal, senderEndPoint, req.Token);
				return;
			}
			_requestEvents.Enqueue(new RequestEventData
			{
				LocalEndPoint = req.Internal,
				RemoteEndPoint = senderEndPoint,
				Token = req.Token
			});
		}

		private void OnNatIntroductionResponse(NatIntroduceResponsePacket req)
		{
			NatPunchPacket natPunchPacket = new NatPunchPacket
			{
				Token = req.Token
			};
			Send(natPunchPacket, req.Internal);
			_socket.Ttl = 2;
			_socket.SendRaw(new byte[1] { 17 }, 0, 1, req.External);
			_socket.Ttl = 255;
			natPunchPacket.IsExternal = true;
			Send(natPunchPacket, req.External);
		}

		private void OnNatPunch(NatPunchPacket req, IPEndPoint senderEndPoint)
		{
			if (UnsyncedEvents)
			{
				_natPunchListener.OnNatIntroductionSuccess(senderEndPoint, req.IsExternal ? NatAddressType.External : NatAddressType.Internal, req.Token);
				return;
			}
			_successEvents.Enqueue(new SuccessEventData
			{
				TargetEndPoint = senderEndPoint,
				Type = (req.IsExternal ? NatAddressType.External : NatAddressType.Internal),
				Token = req.Token
			});
		}
	}
}
