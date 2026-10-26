using System.Net;
using System.Threading;
using LiteNetLib.Utils;

namespace LiteNetLib
{
	public class ConnectionRequest
	{
		private readonly LiteNetManager _listener;

		private int _used;

		internal NetConnectRequestPacket InternalPacket;

		public readonly IPEndPoint RemoteEndPoint;

		public NetDataReader Data => InternalPacket.Data;

		internal ConnectionRequestResult Result { get; private set; }

		internal void UpdateRequest(NetConnectRequestPacket connectRequest)
		{
			if (connectRequest.ConnectionTime >= InternalPacket.ConnectionTime && (connectRequest.ConnectionTime != InternalPacket.ConnectionTime || connectRequest.ConnectionNumber != InternalPacket.ConnectionNumber))
			{
				InternalPacket = connectRequest;
			}
		}

		private bool TryActivate()
		{
			return Interlocked.CompareExchange(ref _used, 1, 0) == 0;
		}

		internal ConnectionRequest(IPEndPoint remoteEndPoint, NetConnectRequestPacket requestPacket, LiteNetManager listener)
		{
			InternalPacket = requestPacket;
			RemoteEndPoint = remoteEndPoint;
			_listener = listener;
		}

		public LiteNetPeer AcceptIfKey(string key)
		{
			if (!TryActivate())
			{
				return null;
			}
			try
			{
				if (Data.GetString() == key)
				{
					Result = ConnectionRequestResult.Accept;
				}
			}
			catch
			{
				NetDebug.WriteError("[AC] Invalid incoming data");
			}
			if (Result == ConnectionRequestResult.Accept)
			{
				return _listener.OnConnectionSolved(this, null, 0, 0);
			}
			Result = ConnectionRequestResult.Reject;
			_listener.OnConnectionSolved(this, null, 0, 0);
			return null;
		}

		public LiteNetPeer Accept()
		{
			if (!TryActivate())
			{
				return null;
			}
			Result = ConnectionRequestResult.Accept;
			return _listener.OnConnectionSolved(this, null, 0, 0);
		}

		public void Reject(byte[] rejectData, int start, int length, bool force)
		{
			if (TryActivate())
			{
				Result = (force ? ConnectionRequestResult.RejectForce : ConnectionRequestResult.Reject);
				_listener.OnConnectionSolved(this, rejectData, start, length);
			}
		}

		public void Reject(byte[] rejectData, int start, int length)
		{
			Reject(rejectData, start, length, force: false);
		}

		public void RejectForce(byte[] rejectData, int start, int length)
		{
			Reject(rejectData, start, length, force: true);
		}

		public void RejectForce()
		{
			Reject(null, 0, 0, force: true);
		}

		public void RejectForce(byte[] rejectData)
		{
			Reject(rejectData, 0, rejectData.Length, force: true);
		}

		public void RejectForce(NetDataWriter rejectData)
		{
			Reject(rejectData.Data, 0, rejectData.Length, force: true);
		}

		public void Reject()
		{
			Reject(null, 0, 0, force: false);
		}

		public void Reject(byte[] rejectData)
		{
			Reject(rejectData, 0, rejectData.Length, force: false);
		}

		public void Reject(NetDataWriter rejectData)
		{
			Reject(rejectData.Data, 0, rejectData.Length, force: false);
		}
	}
}
