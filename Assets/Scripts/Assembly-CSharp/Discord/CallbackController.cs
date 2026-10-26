namespace Discord
{
	public static class CallbackController
	{
		public delegate void OnDisconnectedInfo(int errorCode, string message);

		public delegate void OnErrorInfo(int errorCode, string message);

		public delegate void OnJoinInfo(string secret);

		public delegate void OnReadyInfo(ref global::Discord.Basic.DiscordUser connectedUser);

		public delegate void OnRequestInfo(ref global::Discord.Basic.DiscordUser request);

		public delegate void OnSpectateInfo(string secret);

		internal static global::Discord.Basic.EventHandlers Callbacks;

		public static bool IsConnected
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			private set
			{
			}
		}

		public static void Initialize(string applicationId, bool autoRegister, string optionalSteamId)
		{
		}

		public static void UpdatePresence(global::Discord.Basic.RichPresence presence)
		{
		}

		public static void RunCallbacks()
		{
		}

		public static void Shutdown()
		{
		}

		public static void Respond(string userId, global::Discord.Reply reply)
		{
		}

		[global::AOT.MonoPInvokeCallback(typeof(global::Discord.CallbackController.OnReadyInfo))]
		public static void ReadyCallback(ref global::Discord.Basic.DiscordUser connectedUser)
		{
		}

		[global::AOT.MonoPInvokeCallback(typeof(global::Discord.CallbackController.OnDisconnectedInfo))]
		public static void DisconnectedCallback(int errorCode, string message)
		{
		}

		[global::AOT.MonoPInvokeCallback(typeof(global::Discord.CallbackController.OnErrorInfo))]
		public static void ErrorCallback(int errorCode, string message)
		{
		}

		[global::AOT.MonoPInvokeCallback(typeof(global::Discord.CallbackController.OnJoinInfo))]
		public static void JoinCallback(string secret)
		{
		}

		[global::AOT.MonoPInvokeCallback(typeof(global::Discord.CallbackController.OnSpectateInfo))]
		public static void SpectateCallback(string secret)
		{
		}

		[global::AOT.MonoPInvokeCallback(typeof(global::Discord.CallbackController.OnRequestInfo))]
		public static void RequestCallback(ref global::Discord.Basic.DiscordUser request)
		{
		}

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern void InitializeInternal(string applicationId, ref global::Discord.Basic.EventHandlers handlers, bool autoRegister, string optionalSteamId);

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern void ShutdownInternal();

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern void RunCallbacksInternal();

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern void UpdatePresenceInternal(ref global::Discord.Basic.RichPresenceStruct presence);

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern void ClearPresenceInternal();

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern void RespondInternal(string userId, global::Discord.Reply reply);

		[global::System.Runtime.InteropServices.PreserveSig]
		private static extern void UpdateHandlersInternal(ref global::Discord.Basic.EventHandlers handlers);
	}
}
