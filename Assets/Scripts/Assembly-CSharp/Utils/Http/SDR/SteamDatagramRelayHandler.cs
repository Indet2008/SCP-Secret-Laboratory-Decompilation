using System;
using UnityEngine;

namespace Utils.Http.SDR
{
	public class SteamDatagramRelayHandler : MonoBehaviour
	{
		private const int MaxFragmentSize = 65536;

		private const int FragmentHeaderSize = 12;

		private const int FragmentTimeout = 1000;

		private const long CentralServerSteamId = 85568392935779951L;

		private const int CentralServerVirtualPort = 36547;

		private const int MaxFailures = 2;

		public static bool CanUseSDR
		{
			get
			{
				try
				{
					return false;
				}
				catch
				{
					return false;
				}
			}
		}

		public static bool ShouldUseSDR(string url)
		{
			return false;
		}

		public static void QueueRequest(string url, string method, string content = "", string contentType = "", Action<int, string> onComplete = null, bool log = true)
		{
		}

		public static void QueueRequest(string url, string method, byte[] content, string contentType = "", Action<int, string> onComplete = null, bool log = true)
		{
		}
	}
}
