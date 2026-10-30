using System;
using System.Collections.Generic;
using RemoteAdmin.Communication;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace RemoteAdmin
{
	public static class RemoteAdminClient
	{
		private const string WikiUrl = "https://link.scpslgame.com/rawiki";

		public static void RegisterHandlers()
		{
			EncryptedChannelManager.ReplaceClientHandler(EncryptedChannelManager.EncryptedChannel.RemoteAdmin, HandleRemoteAdminMessage);
			EncryptedChannelManager.ReplaceClientHandler(EncryptedChannelManager.EncryptedChannel.AdminChat, HandleAdminChatMessage);
		}

		public static bool SendQuery(string query, bool logQuery = true)
		{
			if (string.IsNullOrEmpty(query) || !ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			if (!hub.encryptedChannelManager.TrySendMessageToServer(query, EncryptedChannelManager.EncryptedChannel.RemoteAdmin))
			{
				TextBasedRemoteAdmin.AddLog("<color=red>Failed to send the command to the server.</color>");
				return false;
			}
			if (logQuery && !query.StartsWith("$", StringComparison.Ordinal))
			{
				string text = query.Replace("<", "＜").Replace(">", "＞").Replace("\n", string.Empty).Replace("\r", string.Empty);
				TextBasedRemoteAdmin.AddLog("<color=#c77dff>> " + text + "</color>");
			}
			return true;
		}

		public static bool SendAdminChat(string message)
		{
			if (string.IsNullOrEmpty(message) || !ReferenceHub.TryGetLocalHub(out var hub))
			{
				return false;
			}
			return hub.encryptedChannelManager.TrySendMessageToServer(message, EncryptedChannelManager.EncryptedChannel.AdminChat);
		}

		private static void HandleRemoteAdminMessage(EncryptedChannelManager.EncryptedMessage message, EncryptedChannelManager.SecurityLevel level)
		{
			byte[] content = message.Content;
			RemoteAdminResponse remoteAdminResponse = RemoteAdminResponse.Deserialize(content, content.Length);
			ProcessReply(remoteAdminResponse.Content ?? string.Empty, remoteAdminResponse.HasFlag(RemoteAdminResponse.RemoteAdminResponseFlags.Successful), remoteAdminResponse.HasFlag(RemoteAdminResponse.RemoteAdminResponseFlags.LogInConsole), remoteAdminResponse.OverrideDisplay ?? string.Empty, level == EncryptedChannelManager.SecurityLevel.EncryptedAndAuthenticated);
		}

		private static void HandleAdminChatMessage(EncryptedChannelManager.EncryptedMessage message, EncryptedChannelManager.SecurityLevel level)
		{
			string text = message.ToString();
			TextBasedRemoteAdmin.AddLog("<color=#ffb347>[ADMIN CHAT]</color> " + text);
			if (StaffChatNotification.UnreadMessagesCount < byte.MaxValue)
			{
				StaffChatNotification.UnreadMessagesCount++;
			}
			string content = text;
			QueryProcessor.ParseAdminChat(ref content, out var _, out var time, out var silent);
			if (!silent)
			{
				Broadcast.AddElement(content, (time == 0) ? ((ushort)5) : time, Broadcast.BroadcastFlags.AdminChat);
			}
		}

		public static void ProcessReply(string content, bool isSuccess, bool logInConsole, string overrideDisplay, bool secure)
		{
			if (content.StartsWith("%", StringComparison.Ordinal))
			{
				QueryProcessor queryProcessor = ReferenceHub.LocalHub.queryProcessor;
				if (!(DateTime.Now < queryProcessor.ExpectingURL))
				{
					TextBasedRemoteAdmin.AddLog("<color=white>[</color><color=red><link=TBRA_InternalError> (INTERNAL ERROR)</link></color><color=white>]</color> <color=red>Server attempted to send us a URL that we did not query for! Rejected.</color>");
					return;
				}
				queryProcessor.ExpectingURL = default(DateTime);
				if (content.Contains("disabled"))
				{
					TextBasedRemoteAdmin.AddLog("<color=white>[</color><color=red><link=TBRA_InternalError> (INTERNAL ERROR)</link></color><color=white>]</color> <color=red>Server attempted to send us a URL but external lookup is disabled! (This should never happen!)</color>");
					return;
				}
				string text5 = content.Substring(1, content.Length - 1);
				int num3 = text5.IndexOf("%", 0, StringComparison.Ordinal);
				string text6;
				if (num3 > 0)
				{
					string text7 = text5.Substring(0, num3);
					text6 = text7 + ((text7.IndexOf("?", StringComparison.Ordinal) >= 0) ? "&" : "?") + "lookup=" + text5.Substring(num3 + 1, text5.Length - num3 - 1);
				}
				else
				{
					text6 = text5;
				}
				if (text6.IndexOf("fullauth", StringComparison.Ordinal) >= 0)
				{
					text6 += ReferenceHub.LocalHub.authManager.GetAuthToken();
				}
				if (SteamManager.IsSteamReady())
				{
					Steamworks.SteamFriends.OpenWebOverlay(text6);
				}
				else
				{
					Application.OpenURL(text6);
				}
				return;
			}
			if (content.StartsWith("$", StringComparison.Ordinal))
			{
				int num = content.IndexOf(' ');
				string s = ((num < 0) ? content.Substring(1) : content.Substring(1, num - 1));
				string data = ((num < 0) ? string.Empty : content.Substring(num + 1));
				if (int.TryParse(s, out var result) && CommunicationProcessor.ClientCommunication.TryGetValue(result, out var value))
				{
					value.ReceiveData(data, secure);
				}
				return;
			}
			string text = string.Empty;
			string text2 = content;
			int num2 = content.IndexOf('#');
			if (num2 >= 0)
			{
				text = content.Substring(0, num2);
				text2 = content.Substring(num2 + 1);
			}
			if (logInConsole)
			{
				TextBasedRemoteAdmin.AddLog((secure ? string.Empty : "<color=white>[</color><color=red><link=TBRA_EncryptionError> (UNECRYPTED)</link></color><color=white>]</color>") + "<color=white>[</color><link=TBRA_CommandSuccess>" + (isSuccess ? "<color=green></color><color=white></link>] " : "<link=TBRA_CommandFail><color=red></color><color=white></link>]</color> <color=orange>") + "[" + text + "] " + text2 + "</color>");
			}
			if (string.IsNullOrEmpty(text) || overrideDisplay == "void")
			{
				return;
			}
			if (string.Equals(text, "WIKI", StringComparison.OrdinalIgnoreCase))
			{
				Application.OpenURL(WikiUrl);
			}
			if (string.Equals(text, "LOGOUT", StringComparison.OrdinalIgnoreCase) && RemoteAdminUIController.Singleton != null)
			{
				RemoteAdminUIController.Singleton.SetLoggedIn(state: false);
			}
			SubmenuSelector singleton = SubmenuSelector.Singleton;
			if (singleton != null && singleton.SelectedMenu != null)
			{
				singleton.SelectedMenu.SetResponse(isSuccess, text2);
			}
		}

		public static void UpdateCommandList(QueryProcessor.CommandData[] commands)
		{
			List<QueryProcessor.CommandData> commands2 = TextBasedRemoteAdmin.Commands;
			commands2.Clear();
			if (commands == null)
			{
				return;
			}
			HashSet<string> hashSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
			for (int i = 0; i < commands.Length; i++)
			{
				QueryProcessor.CommandData item = commands[i];
				if (!string.IsNullOrEmpty(item.Command) && hashSet.Add(item.Command))
				{
					item.Command = item.Command.ToLowerInvariant();
					commands2.Add(item);
				}
			}
		}
	}
}
