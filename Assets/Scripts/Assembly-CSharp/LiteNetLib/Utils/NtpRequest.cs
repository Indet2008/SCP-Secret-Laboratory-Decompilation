using System.Net;
using System.Net.Sockets;

namespace LiteNetLib.Utils
{
	internal sealed class NtpRequest
	{
		private const int ResendTimer = 1000;

		private const int KillTimer = 10000;

		public const int DefaultPort = 123;

		private readonly IPEndPoint _ntpEndPoint;

		private float _resendTime = 1000f;

		private float _killTime;

		public bool NeedToKill => _killTime >= 10000f;

		public NtpRequest(IPEndPoint endPoint)
		{
			_ntpEndPoint = endPoint;
		}

		public bool Send(Socket socket, float time)
		{
			_resendTime += time;
			_killTime += time;
			if (_resendTime < 1000f)
			{
				return false;
			}
			NtpPacket ntpPacket = new NtpPacket();
			try
			{
				return socket.SendTo(ntpPacket.Bytes, 0, ntpPacket.Bytes.Length, SocketFlags.None, _ntpEndPoint) == ntpPacket.Bytes.Length;
			}
			catch
			{
				return false;
			}
		}
	}
}
