using System;
using System.Runtime.InteropServices;
using AOT;
using Discord.Basic;
using UnityEngine;

namespace Discord
{
	public static class CallbackController
	{
		public delegate void OnDisconnectedInfo(int errorCode, string message);

		public delegate void OnErrorInfo(int errorCode, string message);

		public delegate void OnJoinInfo(string secret);

		public delegate void OnReadyInfo(ref DiscordUser connectedUser);

		public delegate void OnRequestInfo(ref DiscordUser request);

		public delegate void OnSpectateInfo(string secret);

		internal static EventHandlers Callbacks;

		public static bool IsConnected { get; private set; }

		public static void Initialize(string applicationId, bool autoRegister, string optionalSteamId)
		{
			try
			{
				EventHandlers handlers = new EventHandlers
				{
					readyCallback = ReadyCallback,
					disconnectedCallback = DisconnectedCallback,
					errorCallback = ErrorCallback,
					joinCallback = JoinCallback,
					spectateCallback = SpectateCallback,
					requestCallback = RequestCallback
				};
				InitializeInternal(applicationId, ref handlers, autoRegister, optionalSteamId);
				IsConnected = true;
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		public static void UpdatePresence(RichPresence presence)
		{
			try
			{
				RichPresenceStruct presence2 = presence.GetStruct();
				UpdatePresenceInternal(ref presence2);
				presence.FreeMem();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		public static void RunCallbacks()
		{
			if (!IsConnected)
			{
				return;
			}
			try
			{
				RunCallbacksInternal();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		public static void Shutdown()
		{
			try
			{
				ShutdownInternal();
				IsConnected = false;
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		public static void Respond(string userId, Reply reply)
		{
			if (!IsConnected)
			{
				return;
			}
			try
			{
				RespondInternal(userId, reply);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}

		[MonoPInvokeCallback(typeof(OnReadyInfo))]
		public static void ReadyCallback(ref DiscordUser connectedUser)
		{
			Callbacks.readyCallback?.Invoke(ref connectedUser);
		}

		[MonoPInvokeCallback(typeof(OnDisconnectedInfo))]
		public static void DisconnectedCallback(int errorCode, string message)
		{
			Callbacks.disconnectedCallback?.Invoke(errorCode, message);
		}

		[MonoPInvokeCallback(typeof(OnErrorInfo))]
		public static void ErrorCallback(int errorCode, string message)
		{
			Callbacks.errorCallback?.Invoke(errorCode, message);
		}

		[MonoPInvokeCallback(typeof(OnJoinInfo))]
		public static void JoinCallback(string secret)
		{
			Callbacks.joinCallback?.Invoke(secret);
		}

		[MonoPInvokeCallback(typeof(OnSpectateInfo))]
		public static void SpectateCallback(string secret)
		{
			Callbacks.spectateCallback?.Invoke(secret);
		}

		[MonoPInvokeCallback(typeof(OnRequestInfo))]
		public static void RequestCallback(ref DiscordUser request)
		{
			Callbacks.requestCallback?.Invoke(ref request);
		}

		[DllImport("discord-rpc", CallingConvention = CallingConvention.Cdecl, EntryPoint = "Discord_Initialize")]
		private static extern void InitializeInternal(string applicationId, ref EventHandlers handlers, bool autoRegister, string optionalSteamId);

		[DllImport("discord-rpc", CallingConvention = CallingConvention.Cdecl, EntryPoint = "Discord_Shutdown")]
		private static extern void ShutdownInternal();

		[DllImport("discord-rpc", CallingConvention = CallingConvention.Cdecl, EntryPoint = "Discord_RunCallbacks")]
		private static extern void RunCallbacksInternal();

		[DllImport("discord-rpc", CallingConvention = CallingConvention.Cdecl, EntryPoint = "Discord_UpdatePresence")]
		private static extern void UpdatePresenceInternal(ref RichPresenceStruct presence);

		[DllImport("discord-rpc", CallingConvention = CallingConvention.Cdecl, EntryPoint = "Discord_ClearPresence")]
		private static extern void ClearPresenceInternal();

		[DllImport("discord-rpc", CallingConvention = CallingConvention.Cdecl, EntryPoint = "Discord_Respond")]
		private static extern void RespondInternal(string userId, Reply reply);

		[DllImport("discord-rpc", CallingConvention = CallingConvention.Cdecl, EntryPoint = "Discord_UpdateHandlers")]
		private static extern void UpdateHandlersInternal(ref EventHandlers handlers);
	}
}
