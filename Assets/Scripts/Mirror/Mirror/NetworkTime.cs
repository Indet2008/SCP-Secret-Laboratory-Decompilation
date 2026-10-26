namespace Mirror
{
	public static class NetworkTime
	{
		public static float PingInterval = 2f;

		public static int PingWindowSize = 6;

		private static double lastPingTime;

		private static global::Mirror.ExponentialMovingAverage _rtt = new global::Mirror.ExponentialMovingAverage(PingWindowSize);

		[global::System.Obsolete("NetworkTime.PingFrequency was renamed to PingInterval, because we use it as seconds, not as Hz. Please rename all usages, but keep using it just as before.")]
		public static float PingFrequency
		{
			get
			{
				return PingInterval;
			}
			set
			{
				PingInterval = value;
			}
		}

		public static double localTime
		{
			[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
			get
			{
				return global::UnityEngine.Time.unscaledTimeAsDouble;
			}
		}

		public static double time
		{
			[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
			get
			{
				if (!global::Mirror.NetworkServer.active)
				{
					return global::Mirror.NetworkClient.localTimeline;
				}
				return localTime;
			}
		}

		public static double offset => localTime - time;

		public static double rtt => _rtt.Value;

		public static double rttVariance => _rtt.Variance;

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		public static void ResetStatics()
		{
			PingInterval = 2f;
			PingWindowSize = 6;
			lastPingTime = 0.0;
			_rtt = new global::Mirror.ExponentialMovingAverage(PingWindowSize);
		}

		internal static void UpdateClient()
		{
			if (localTime >= lastPingTime + (double)PingInterval)
			{
				global::Mirror.NetworkClient.Send(new global::Mirror.NetworkPingMessage(localTime), 1);
				lastPingTime = localTime;
			}
		}

		internal static void OnServerPing(global::Mirror.NetworkConnectionToClient conn, global::Mirror.NetworkPingMessage message)
		{
			global::Mirror.NetworkPongMessage message2 = new global::Mirror.NetworkPongMessage
			{
				localTime = message.localTime
			};
			conn.Send(message2, 1);
		}

		internal static void OnClientPong(global::Mirror.NetworkPongMessage message)
		{
			if (!(message.localTime > localTime))
			{
				double newValue = localTime - message.localTime;
				_rtt.Add(newValue);
			}
		}

		internal static void OnClientPing(global::Mirror.NetworkPingMessage message)
		{
			global::Mirror.NetworkClient.Send(new global::Mirror.NetworkPongMessage
			{
				localTime = message.localTime
			}, 1);
		}

		internal static void OnServerPong(global::Mirror.NetworkConnectionToClient conn, global::Mirror.NetworkPongMessage message)
		{
			if (!(message.localTime > localTime))
			{
				double newValue = localTime - message.localTime;
				conn._rtt.Add(newValue);
			}
		}
	}
}
