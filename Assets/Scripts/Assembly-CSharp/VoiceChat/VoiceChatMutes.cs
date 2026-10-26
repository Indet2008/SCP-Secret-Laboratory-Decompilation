using System;
using System.Collections.Generic;
using System.IO;
using CentralAuth;
using GameCore;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace VoiceChat
{
	public static class VoiceChatMutes
	{
		private const string Filename = "mutes.txt";

		private const string IntercomPrefix = "ICOM-";

		private static string _path;

		private static bool _everLoaded;

		private static readonly HashSet<string> Mutes = new HashSet<string>();

		private static readonly Dictionary<ReferenceHub, VcMuteFlags> Flags = new Dictionary<ReferenceHub, VcMuteFlags>();

		public static event Action<ReferenceHub, VcMuteFlags> OnFlagsSet;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ConfigFile.OnConfigReloaded = (Action)Delegate.Combine(ConfigFile.OnConfigReloaded, new Action(LoadMutes));
			CustomNetworkManager.OnClientReady += () =>
			{
				if (!_everLoaded)
				{
					LoadMutes();
				}
			};
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				if (GetFlags(hub) != VcMuteFlags.None)
				{
					OnFlagsSet?.Invoke(hub, VcMuteFlags.None);
				}
				Flags.Remove(hub);
			};
			PlayerAuthenticationManager.OnSyncedUserIdAssigned += (ReferenceHub hub) =>
			{
				if (!NetworkServer.active && QueryLocalMute(hub.authManager.SyncedUserId))
				{
					SetFlags(hub, VcMuteFlags.LocalRegular);
				}
			};
			LoadMutes();
		}

		private static void LoadMutes()
		{
			_path = ConfigSharing.Paths[1];
			if (string.IsNullOrEmpty(_path))
			{
				return;
			}
			_path += "mutes.txt";
			_everLoaded = true;
			try
			{
				using StreamReader streamReader = new StreamReader(_path);
				while (true)
				{
					string text = streamReader.ReadLine();
					if (text != null)
					{
						if (TryValidateId(text, intercom: false, out var validated))
						{
							Mutes.Add(validated);
						}
						continue;
					}
					break;
				}
			}
			catch
			{
				GameCore.Console.AddLog("Can't load the mute file!", Color.yellow);
			}
		}

		private static bool TryValidateId(string raw, bool intercom, out string validated)
		{
			validated = raw?.Trim();
			if (string.IsNullOrEmpty(raw))
			{
				return false;
			}
			if (intercom)
			{
				validated = "ICOM-" + validated;
			}
			return true;
		}

		private static bool TryGetHub(string userId, out ReferenceHub hub)
		{
			return ReferenceHub.AllHubs.TryGetFirst((ReferenceHub x) => CheckHub(x, userId), out hub);
		}

		private static bool CheckHub(ReferenceHub hub, string id)
		{
			PlayerAuthenticationManager authManager = hub.authManager;
			if (!(authManager.UserId == id))
			{
				if (NetworkServer.active)
				{
					return authManager.SyncedUserId == id;
				}
				return false;
			}
			return true;
		}

		private static VcMuteFlags GetLocalFlag(bool intercom)
		{
			if (!intercom)
			{
				return VcMuteFlags.LocalRegular;
			}
			return VcMuteFlags.LocalIntercom;
		}

		public static bool QueryLocalMute(string userId, bool intercom = false)
		{
			if (TryValidateId(userId, intercom, out var validated))
			{
				return Mutes.Contains(validated);
			}
			return false;
		}

		public static void IssueLocalMute(string userId, bool intercom = false)
		{
			if (TryValidateId(userId, intercom, out var validated) && Mutes.Add(validated))
			{
				File.AppendAllText(_path, "\r\n" + validated);
				if (TryGetHub(userId, out var hub))
				{
					SetFlags(hub, GetFlags(hub) | GetLocalFlag(intercom));
				}
			}
		}

		public static void RevokeLocalMute(string userId, bool intercom = false)
		{
			if (TryValidateId(userId, intercom, out var validated) && Mutes.Remove(validated))
			{
				FileManager.WriteToFile(Mutes, _path);
				if (TryGetHub(userId, out var hub))
				{
					SetFlags(hub, (VcMuteFlags)((uint)GetFlags(hub) & (uint)(byte)(~(int)GetLocalFlag(intercom))));
				}
			}
		}

		public static void SetFlags(ReferenceHub hub, VcMuteFlags flags)
		{
			Flags[hub] = flags;
			OnFlagsSet?.Invoke(hub, flags);
		}

		public static VcMuteFlags GetFlags(ReferenceHub hub)
		{
			if (!Flags.TryGetValue(hub, out var value))
			{
				return VcMuteFlags.None;
			}
			return value;
		}

		public static bool IsMuted(ReferenceHub hub, bool checkIntercom = false)
		{
			VcMuteFlags flags = GetFlags(hub);
			if (checkIntercom)
			{
				return flags != VcMuteFlags.None;
			}
			return (flags & (VcMuteFlags.LocalRegular | VcMuteFlags.GlobalRegular)) != 0;
		}
	}
}
