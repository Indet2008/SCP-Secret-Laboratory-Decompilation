namespace Mirror
{
	public static class NetworkDiagnostics
	{
		public readonly struct MessageInfo
		{
			public readonly global::Mirror.NetworkMessage message;

			public readonly int channel;

			public readonly int bytes;

			public readonly int count;

			internal MessageInfo(global::Mirror.NetworkMessage message, int channel, int bytes, int count)
			{
				this.message = message;
				this.channel = channel;
				this.bytes = bytes;
				this.count = count;
			}
		}

		public static event global::System.Action<global::Mirror.NetworkDiagnostics.MessageInfo> OutMessageEvent;

		public static event global::System.Action<global::Mirror.NetworkDiagnostics.MessageInfo> InMessageEvent;

		[global::UnityEngine.RuntimeInitializeOnLoadMethod]
		private static void ResetStatics()
		{
			InMessageEvent = null;
			OutMessageEvent = null;
		}

		internal static void OnSend<T>(T message, int channel, int bytes, int count) where T : struct, global::Mirror.NetworkMessage
		{
			if (count > 0 && OutMessageEvent != null)
			{
				global::Mirror.NetworkDiagnostics.MessageInfo obj = new global::Mirror.NetworkDiagnostics.MessageInfo(message, channel, bytes, count);
				OutMessageEvent?.Invoke(obj);
			}
		}

		internal static void OnReceive<T>(T message, int channel, int bytes) where T : struct, global::Mirror.NetworkMessage
		{
			if (InMessageEvent != null)
			{
				global::Mirror.NetworkDiagnostics.MessageInfo obj = new global::Mirror.NetworkDiagnostics.MessageInfo(message, channel, bytes, 1);
				InMessageEvent?.Invoke(obj);
			}
		}
	}
}
