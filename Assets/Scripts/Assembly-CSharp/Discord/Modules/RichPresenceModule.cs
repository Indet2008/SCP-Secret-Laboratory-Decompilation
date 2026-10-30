using System;
using System.Collections.Generic;
using CentralAuth;
using Discord.Basic;
using Discord.Elements;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using NorthwoodLib;
using PlayerRoles;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Discord.Modules
{
	public class RichPresenceModule : DiscordModuleBase
	{
		public static readonly Dictionary<DiscordGameStatus, DiscordGameStateElement> GameState = new Dictionary<DiscordGameStatus, DiscordGameStateElement>();

		public static readonly Dictionary<RoleTypeId, DiscordRoleElement> PlayableRoles = new Dictionary<RoleTypeId, DiscordRoleElement>();

		public static readonly Dictionary<Team, DiscordTeamElement> PlayableTeams = new Dictionary<Team, DiscordTeamElement>();

		private static bool _dictionariesPopulated;

		[SerializeField]
		private DiscordElementBase[] _elements;

		private DiscordElementBase _elementBase;

		private long _timeSinceJoin;

		public override bool IsEnabled
		{
			get
			{
				return base.IsEnabled;
			}
			set
			{
				base.IsEnabled = value;
				if (!value)
				{
					CallbackController.UpdatePresence(new RichPresence());
				}
			}
		}

		private string ServerAddress
		{
			get
			{
				LiteNetLib4MirrorTransport singleton = LiteNetLib4MirrorTransport.Singleton;
				if (NetworkServer.active || !NetworkClient.active || !singleton.clientAddress.Contains("."))
				{
					return string.Empty;
				}
				return StringUtils.Base64Encode(singleton.clientAddress + ":" + singleton.port + ":" + GameCore.Version.VersionString);
			}
		}

		public void RefreshPresence()
		{
			if (!IsEnabled || _elementBase == null)
			{
				return;
			}
			string serverAddress = ServerAddress;
			int partyMax = CustomNetworkManager.slots;
			if (ReferenceHub.TryGetHostHub(out var hub))
			{
				partyMax = hub.characterClassManager.MaxPlayers;
			}
			CallbackController.UpdatePresence(new RichPresence
			{
				partyId = "LOBBY#" + serverAddress,
				joinSecret = serverAddress,
				state = _elementBase.Title,
				smallImageKey = _elementBase.SmallImageId,
				largeImageKey = _elementBase.LargeImageId,
				startTimestamp = _timeSinceJoin,
				partyMax = partyMax,
				partySize = ReferenceHub.GetPlayerCount(ClientInstanceMode.ReadyClient, ClientInstanceMode.Host)
			});
		}

		public void SetStatus(DiscordGameStatus status, bool updatePresence = true)
		{
			if (GameState.TryGetValue(status, out var value))
			{
				_elementBase = value;
				if (updatePresence)
				{
					RefreshPresence();
				}
			}
		}

		public void SetStatus(RoleTypeId roleTypeId, bool refreshPresence = true)
		{
			if (PlayableRoles.TryGetValue(roleTypeId, out var value))
			{
				_elementBase = value;
				if (refreshPresence)
				{
					RefreshPresence();
				}
			}
		}

		public void SetStatus(Team team, bool updatePresence = true)
		{
			if (PlayableTeams.TryGetValue(team, out var value))
			{
				_elementBase = value;
				if (updatePresence)
				{
					RefreshPresence();
				}
			}
		}

		public void ResetTimer(bool updatePresence = true)
		{
			_timeSinceJoin = GenerateUnixTime();
			if (updatePresence)
			{
				RefreshPresence();
			}
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			ReferenceHub.OnPlayerAdded -= OnPlayerAdded;
			SceneManager.sceneLoaded -= OnLevelFinishedLoading;
		}

		private void Start()
		{
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			ReferenceHub.OnPlayerAdded += OnPlayerAdded;
			SceneManager.sceneLoaded += OnLevelFinishedLoading;
			_timeSinceJoin = GenerateUnixTime();
		}

		private void Awake()
		{
			if (!_dictionariesPopulated)
			{
				PopulateDictionaries();
			}
		}

		private void ClearPresence()
		{
			CallbackController.UpdatePresence(new RichPresence());
		}

		private long GenerateUnixTime()
		{
			return (long)(DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc)).TotalSeconds;
		}

		private void OnPlayerAdded(ReferenceHub _)
		{
			RefreshPresence();
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (!(userHub != ReferenceHub.LocalHub) && !(newRole == null))
			{
				if (PlayableRoles.ContainsKey(newRole.RoleTypeId))
				{
					SetStatus(newRole.RoleTypeId);
				}
				else
				{
					SetStatus(newRole.Team);
				}
			}
		}

		private void OnLevelFinishedLoading(Scene scene, LoadSceneMode _)
		{
			if (scene.name.Contains("Menu"))
			{
				SetStatus(DiscordGameStatus.MainMenu);
			}
			else if (scene.name == "Facility")
			{
				SetStatus(DiscordGameStatus.Lobby);
			}
		}

		private void PopulateDictionaries()
		{
			_dictionariesPopulated = true;
			DiscordElementBase[] elements = _elements;
			foreach (DiscordElementBase discordElementBase in elements)
			{
				if (discordElementBase is DiscordRoleElement discordRoleElement)
				{
					PlayableRoles[discordRoleElement.RoleId] = discordRoleElement;
					continue;
				}
				if (discordElementBase is DiscordGameStateElement discordGameStateElement)
				{
					GameState[discordGameStateElement.Status] = discordGameStateElement;
					continue;
				}
				if (discordElementBase is DiscordTeamElement discordTeamElement)
				{
					PlayableTeams[discordTeamElement.TeamId] = discordTeamElement;
					continue;
				}
				Debug.LogWarning("Attempted to populate DiscordManager's elements with an unknown type.");
			}
		}
	}
}
