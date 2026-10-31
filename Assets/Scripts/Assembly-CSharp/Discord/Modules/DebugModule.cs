using Discord.Basic;
using UnityEngine;

namespace Discord.Modules
{
	public class DebugModule : DiscordModuleBase
	{
		protected override void OnDestroy()
		{
			base.OnDestroy();
			CallbackController.Callbacks.disconnectedCallback -= OnDisconnectedCallback;
			CallbackController.Callbacks.readyCallback -= OnReadyCallback;
			CallbackController.Callbacks.spectateCallback -= OnSpectateCallback;
			CallbackController.Callbacks.errorCallback -= OnErrorCallback;
		}

		private void Start()
		{
			CallbackController.Callbacks.disconnectedCallback += OnDisconnectedCallback;
			CallbackController.Callbacks.readyCallback += OnReadyCallback;
			CallbackController.Callbacks.spectateCallback += OnSpectateCallback;
			CallbackController.Callbacks.errorCallback += OnErrorCallback;
		}

		private void OnReadyCallback(ref DiscordUser connectedUser)
		{
			if (IsEnabled)
			{
				Debug.Log("Discord: Connected to " + connectedUser.username + "#" + connectedUser.discriminator + ": " + connectedUser.userId);
				GameCore.Console.AddLog("Discord: Ready!", Color.gray, nospace: true);
			}
		}

		private void OnDisconnectedCallback(int errorCode, string message)
		{
			if (IsEnabled)
			{
				Debug.Log(string.Format("Discord: Disconnect {0}: {1}", errorCode, message));
			}
		}

		private void OnErrorCallback(int errorCode, string message)
		{
			if (IsEnabled)
			{
				Debug.Log(string.Format("Discord: Error {0}: {1}", errorCode, message));
				GameCore.Console.AddLog(string.Format("Discord: Error - {0} ({1})", message, errorCode), Color.red, nospace: true);
			}
		}

		private void OnSpectateCallback(string secret)
		{
			if (IsEnabled)
			{
				Debug.Log("Discord: Spectate (" + secret + ")");
				GameCore.Console.AddLog("Discord: SpectateCallback fired.", Color.gray, nospace: true);
			}
		}
	}
}
