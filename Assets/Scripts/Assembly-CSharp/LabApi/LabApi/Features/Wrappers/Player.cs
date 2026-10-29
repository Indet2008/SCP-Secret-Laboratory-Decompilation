namespace LabApi.Features.Wrappers
{
	public class Player
	{
		private static readonly global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Wrappers.Player> UserIdCache = new global::System.Collections.Generic.Dictionary<string, global::LabApi.Features.Wrappers.Player>(CustomNetworkManager.slots, global::System.StringComparer.OrdinalIgnoreCase);

		public static global::System.Collections.Generic.Dictionary<ReferenceHub, global::LabApi.Features.Wrappers.Player> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<ReferenceHub, global::LabApi.Features.Wrappers.Player>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Player> List => Dictionary.Values;

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> ReadyList => global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Player x) => x.IsDummy || (x.IsPlayer && x.IsReady));

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> NpcList => global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Player x) => x.IsNpc);

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> UnauthenticatedList => global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Player x) => x.IsPlayer && !x.IsReady);

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> DummyList => global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Player x) => x.IsDummy);

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> RegularNpcList => global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Player x) => x.IsNpc && !x.IsDummy);

		public static global::LabApi.Features.Wrappers.Player? Host => global::LabApi.Features.Wrappers.Server.Host;

		public static int Count => global::System.Linq.Enumerable.Count(ReadyList);

		public static int NonVerifiedCount => global::System.Linq.Enumerable.Count(UnauthenticatedList);

		public static int ConnectionsCount => global::Mirror.LiteNetLib4Mirror.LiteNetLib4MirrorCore.Host.ConnectedPeersCount;

		public ReferenceHub ReferenceHub { get; }

		public global::UnityEngine.GameObject? GameObject
		{
			get
			{
				if (!ReferenceHub)
				{
					return null;
				}
				return ReferenceHub.gameObject;
			}
		}

		public bool IsHost => ReferenceHub.isLocalPlayer;

		[global::System.Obsolete("Use IsHost instead")]
		public bool IsServer => ReferenceHub.isLocalPlayer;

		public bool IsNpc
		{
			get
			{
				if (!IsHost)
				{
					return ReferenceHub.connectionToClient.GetType() != typeof(global::Mirror.NetworkConnectionToClient);
				}
				return false;
			}
		}

		public bool IsPlayer => Connection.GetType() == typeof(global::Mirror.NetworkConnectionToClient);

		public bool IsDummy => ReferenceHub.authManager.InstanceMode == global::CentralAuth.ClientInstanceMode.Dummy;

		public string UserId => ReferenceHub.authManager.UserId;

		public uint NetworkId => ReferenceHub.characterClassManager.netId;

		public global::Mirror.NetworkConnection Connection
		{
			get
			{
				if (!IsHost)
				{
					return ReferenceHub.networkIdentity.connectionToClient;
				}
				return ReferenceHub.networkIdentity.connectionToServer;
			}
		}

		public global::Mirror.NetworkConnectionToClient ConnectionToClient => ReferenceHub.networkIdentity.connectionToClient;

		public int PlayerId => ReferenceHub.PlayerId;

		[global::System.Obsolete("Use IsDestroyed instead.")]
		public bool IsOffline => GameObject == null;

		[global::System.Obsolete("Use !IsDestroyed instead.")]
		public bool IsOnline => !IsOffline;

		public bool IsDestroyed => !ReferenceHub;

		public bool IsReady
		{
			get
			{
				if (ReferenceHub.authManager.InstanceMode != global::CentralAuth.ClientInstanceMode.Unverified)
				{
					return ReferenceHub.nicknameSync.NickSet;
				}
				return false;
			}
		}

		public string IpAddress => ReferenceHub.characterClassManager.connectionToClient.address;

		public global::PlayerRoles.RoleTypeId Role
		{
			get
			{
				return global::PlayerRoles.PlayerRolesUtils.GetRoleId(ReferenceHub);
			}
			set
			{
				ReferenceHub.roleManager.ServerSetRole(value, global::PlayerRoles.RoleChangeReason.RemoteAdmin);
			}
		}

		public global::PlayerRoles.PlayerRoleBase RoleBase => ReferenceHub.roleManager.CurrentRole;

		public int LifeId => RoleBase.UniqueLifeIdentifier;

		public string Nickname => ReferenceHub.nicknameSync.MyNick;

		public string DisplayName
		{
			get
			{
				return ReferenceHub.nicknameSync.DisplayName;
			}
			set
			{
				ReferenceHub.nicknameSync.DisplayName = value;
			}
		}

		public string LogName
		{
			get
			{
				if (!IsHost)
				{
					return Nickname + " (" + UserId + ")";
				}
				return "SERVER CONSOLE";
			}
		}

		public string CustomInfo
		{
			get
			{
				return ReferenceHub.nicknameSync.CustomPlayerInfo;
			}
			set
			{
				ReferenceHub.nicknameSync.CustomPlayerInfo = value;
			}
		}

		public PlayerInfoArea InfoArea
		{
			get
			{
				return ReferenceHub.nicknameSync.Network_playerInfoToShow;
			}
			set
			{
				ReferenceHub.nicknameSync.Network_playerInfoToShow = value;
			}
		}

		public float Health
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HealthStat>().CurValue;
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HealthStat>().CurValue = value;
			}
		}

		public float MaxHealth
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HealthStat>().MaxValue;
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HealthStat>().MaxValue = value;
			}
		}

		public float ArtificialHealth
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AhpStat>().CurValue;
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AhpStat>().ServerKillAllProcesses();
				if (value > 0f)
				{
					ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AhpStat>().ServerAddProcess(value, MaxArtificialHealth, 0f, 1f, 0f, persistant: false);
				}
			}
		}

		public float MaxArtificialHealth
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AhpStat>().MaxValue;
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AhpStat>().MaxValue = value;
			}
		}

		public float HumeShield
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HumeShieldStat>().CurValue;
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HumeShieldStat>().CurValue = value;
			}
		}

		public float MaxHumeShield
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HumeShieldStat>().MaxValue;
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HumeShieldStat>().MaxValue = value;
			}
		}

		public float HumeShieldRegenRate
		{
			get
			{
				if (!(ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.PlayableScps.HumeShield.IHumeShieldedRole humeShieldedRole))
				{
					return -1f;
				}
				return humeShieldedRole.HumeShieldModule.HsRegeneration;
			}
			set
			{
				if (ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.PlayableScps.HumeShield.IHumeShieldedRole humeShieldedRole)
				{
					((global::PlayerRoles.PlayableScps.HumeShield.DynamicHumeShieldController)humeShieldedRole.HumeShieldModule).RegenerationRate = value;
				}
			}
		}

		public float HumeShieldRegenCooldown
		{
			get
			{
				if (!(ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.PlayableScps.HumeShield.IHumeShieldedRole humeShieldedRole))
				{
					return -1f;
				}
				return ((global::PlayerRoles.PlayableScps.HumeShield.DynamicHumeShieldController)humeShieldedRole.HumeShieldModule).RegenerationCooldown;
			}
			set
			{
				if (ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.PlayableScps.HumeShield.IHumeShieldedRole humeShieldedRole)
				{
					((global::PlayerRoles.PlayableScps.HumeShield.DynamicHumeShieldController)humeShieldedRole.HumeShieldModule).RegenerationCooldown = value;
				}
			}
		}

		public global::UnityEngine.Vector3 Gravity
		{
			get
			{
				if (ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.FirstPersonControl.IFpcRole fpcRole)
				{
					return fpcRole.FpcModule.Motor.GravityController.Gravity;
				}
				return global::UnityEngine.Vector3.zero;
			}
			set
			{
				global::PlayerRoles.FirstPersonControl.FpcGravityController.ServerSetGravity(ReferenceHub, value);
			}
		}

		public bool RemoteAdminAccess => ReferenceHub.serverRoles.RemoteAdmin;

		public bool DoNotTrack => ReferenceHub.authManager.DoNotTrack;

		public bool IsOverwatchEnabled
		{
			get
			{
				return ReferenceHub.serverRoles.IsInOverwatch;
			}
			set
			{
				ReferenceHub.serverRoles.IsInOverwatch = value;
			}
		}

		public global::LabApi.Features.Wrappers.Player? CurrentlySpectating
		{
			get
			{
				if (!(RoleBase is global::PlayerRoles.Spectating.SpectatorRole spectatorRole))
				{
					return null;
				}
				if (!ReferenceHub.TryGetHubNetID(spectatorRole.SyncedSpectatedNetId, out var hub))
				{
					return null;
				}
				return Get(hub);
			}
		}

		public global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> CurrentSpectators
		{
			get
			{
				global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Player>.Shared.Rent();
				foreach (global::LabApi.Features.Wrappers.Player item in List)
				{
					if (global::PlayerRoles.Spectating.SpectatorNetworking.IsSpectatedBy(ReferenceHub, item.ReferenceHub))
					{
						list.Add(item);
					}
				}
				return list;
			}
		}

		public bool IsSpectatable
		{
			get
			{
				return !global::PlayerRoles.Spectating.SpectatableVisibilityManager.IsHidden(ReferenceHub);
			}
			set
			{
				global::PlayerRoles.Spectating.SpectatableVisibilityManager.SetHidden(ReferenceHub, !value);
			}
		}

		public global::LabApi.Features.Wrappers.Item? CurrentItem
		{
			get
			{
				return global::LabApi.Features.Wrappers.Item.Get(Inventory.CurInstance);
			}
			set
			{
				if (value == null || value.Type == ItemType.None)
				{
					Inventory.ServerSelectItem(0);
				}
				else
				{
					Inventory.ServerSelectItem(value.Serial);
				}
			}
		}

		public global::System.Collections.Generic.IEnumerable<global::CustomPlayerEffects.StatusEffectBase> ActiveEffects => global::System.Linq.Enumerable.Where(ReferenceHub.playerEffectsController.AllEffects, (global::CustomPlayerEffects.StatusEffectBase x) => x.Intensity > 0);

		public global::LabApi.Features.Wrappers.Room? Room
		{
			get
			{
				if (!global::LabApi.Features.Wrappers.Room.TryGetRoomAtPosition(Position, out global::LabApi.Features.Wrappers.Room room))
				{
					return null;
				}
				return room;
			}
		}

		public global::LabApi.Features.Wrappers.Room? CachedRoom
		{
			get
			{
				if (!global::MapGeneration.RoomUtils.TryGetCurrentRoom(ReferenceHub, out var room))
				{
					return null;
				}
				return global::LabApi.Features.Wrappers.Room.Get(room);
			}
		}

		public global::MapGeneration.FacilityZone Zone => Room?.Zone ?? global::MapGeneration.FacilityZone.None;

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Item> Items => global::System.Linq.Enumerable.Select(Inventory.UserInventory.Items.Values, global::LabApi.Features.Wrappers.Item.Get);

		public global::System.Collections.Generic.Dictionary<ItemType, ushort> Ammo => Inventory.UserInventory.ReserveAmmo;

		public string GroupColor
		{
			get
			{
				return ReferenceHub.serverRoles.Network_myColor;
			}
			set
			{
				ReferenceHub.serverRoles.SetColor(value);
			}
		}

		public string GroupName
		{
			get
			{
				return ReferenceHub.serverRoles.Network_myText;
			}
			set
			{
				ReferenceHub.serverRoles.SetText(value);
			}
		}

		public UserGroup? UserGroup
		{
			get
			{
				return ReferenceHub.serverRoles.Group;
			}
			set
			{
				ReferenceHub.serverRoles.SetGroup(value);
			}
		}

		public string? PermissionsGroupName => global::System.Collections.Generic.CollectionExtensions.GetValueOrDefault(ServerStatic.PermissionsHandler.Members, UserId);

		public int UnitId
		{
			get
			{
				if (!(RoleBase is global::PlayerRoles.HumanRole humanRole))
				{
					return -1;
				}
				return humanRole.UnitNameId;
			}
		}

		public bool HasReservedSlot => ReservedSlot.HasReservedSlot(UserId);

		public global::UnityEngine.Vector3 Velocity => global::PlayerRoles.FirstPersonControl.FpcExtensionMethods.GetVelocity(ReferenceHub);

		public global::InventorySystem.Inventory Inventory => ReferenceHub.inventory;

		public global::PlayerRoles.Voice.VoiceModuleBase? VoiceModule
		{
			get
			{
				if (!(RoleBase is global::PlayerRoles.Voice.IVoiceRole voiceRole))
				{
					return null;
				}
				return voiceRole.VoiceModule;
			}
		}

		public global::VoiceChat.VoiceChatChannel VoiceChannel => VoiceModule?.CurrentChannel ?? global::VoiceChat.VoiceChatChannel.None;

		public bool IsWithoutItems => Inventory.UserInventory.Items.Count == 0;

		public bool IsInventoryFull => Inventory.UserInventory.Items.Count >= 8;

		public bool IsOutOfAmmo => global::Utils.NonAllocLINQ.DictionaryExtensions.All(Inventory.UserInventory.ReserveAmmo, (global::System.Collections.Generic.KeyValuePair<ItemType, ushort> ammo) => ammo.Value == 0);

		public bool IsDisarmed
		{
			get
			{
				return global::InventorySystem.Disarming.DisarmedPlayers.IsDisarmed(Inventory);
			}
			set
			{
				if (value)
				{
					global::InventorySystem.Disarming.DisarmedPlayers.SetDisarmedStatus(Inventory, null);
					global::InventorySystem.Disarming.DisarmedPlayers.Entries.Add(new global::InventorySystem.Disarming.DisarmedPlayers.DisarmedEntry(ReferenceHub.networkIdentity.netId, 0u));
					global::Utils.Networking.NetworkUtils.SendToAuthenticated(new global::InventorySystem.Disarming.DisarmedPlayersListMessage(global::InventorySystem.Disarming.DisarmedPlayers.Entries));
				}
				else
				{
					global::InventorySystem.Disarming.DisarmedPlayers.SetDisarmedStatus(Inventory, null);
					global::Utils.Networking.NetworkUtils.SendToAuthenticated(new global::InventorySystem.Disarming.DisarmedPlayersListMessage(global::InventorySystem.Disarming.DisarmedPlayers.Entries));
				}
			}
		}

		public bool IsMuted => global::VoiceChat.VoiceChatMutes.IsMuted(ReferenceHub);

		public bool IsIntercomMuted => global::VoiceChat.VoiceChatMutes.IsMuted(ReferenceHub, checkIntercom: true);

		public bool IsUsingRadio => global::VoiceChat.Playbacks.PersonalRadioPlayback.IsTransmitting(ReferenceHub);

		public bool IsSpeaking
		{
			get
			{
				if (VoiceModule != null)
				{
					return VoiceModule.IsSpeaking;
				}
				return false;
			}
		}

		public bool IsGlobalModerator => ReferenceHub.authManager.RemoteAdminGlobalAccess;

		public bool IsNorthwoodStaff => ReferenceHub.authManager.NorthwoodStaff;

		public bool IsBypassEnabled
		{
			get
			{
				return ReferenceHub.serverRoles.BypassMode;
			}
			set
			{
				ReferenceHub.serverRoles.BypassMode = value;
			}
		}

		public bool IsGodModeEnabled
		{
			get
			{
				return ReferenceHub.characterClassManager.GodMode;
			}
			set
			{
				ReferenceHub.characterClassManager.GodMode = value;
			}
		}

		public bool IsNoclipEnabled
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AdminFlagsStat>().HasFlag(global::PlayerStatsSystem.AdminFlags.Noclip);
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AdminFlagsStat>().SetFlag(global::PlayerStatsSystem.AdminFlags.Noclip, value);
			}
		}

		public global::LabApi.Features.Wrappers.Player? DisarmedBy
		{
			get
			{
				if (!IsDisarmed)
				{
					return null;
				}
				return Get(global::InventorySystem.Disarming.DisarmedPlayers.Entries.Find((global::InventorySystem.Disarming.DisarmedPlayers.DisarmedEntry x) => x.DisarmedPlayer == NetworkId).Disarmer);
			}
			set
			{
				global::InventorySystem.Disarming.DisarmedPlayers.SetDisarmedStatus(Inventory, null);
				if (value != null)
				{
					global::InventorySystem.Disarming.DisarmedPlayers.Entries.Add(new global::InventorySystem.Disarming.DisarmedPlayers.DisarmedEntry(NetworkId, value.NetworkId));
					global::Utils.Networking.NetworkUtils.SendToAuthenticated(new global::InventorySystem.Disarming.DisarmedPlayersListMessage(global::InventorySystem.Disarming.DisarmedPlayers.Entries));
				}
			}
		}

		public global::PlayerRoles.Team Team => RoleBase.Team;

		public global::PlayerRoles.Faction Faction => global::PlayerRoles.PlayerRolesUtils.GetFaction(Team);

		public bool IsAlive => Team != global::PlayerRoles.Team.Dead;

		public bool IsSCP => Team == global::PlayerRoles.Team.SCPs;

		public bool IsHuman
		{
			get
			{
				if (IsAlive)
				{
					return !IsSCP;
				}
				return false;
			}
		}

		public bool IsNTF => Team == global::PlayerRoles.Team.FoundationForces;

		public bool IsChaos => Team == global::PlayerRoles.Team.ChaosInsurgency;

		public bool IsTutorial => Role == global::PlayerRoles.RoleTypeId.Tutorial;

		public global::UnityEngine.Transform Camera => ReferenceHub.PlayerCameraReference;

		public global::UnityEngine.Vector3 Position
		{
			get
			{
				if (!(RoleBase is global::PlayerRoles.FirstPersonControl.IFpcRole fpcRole))
				{
					return global::UnityEngine.Vector3.zero;
				}
				return fpcRole.FpcModule.Position;
			}
			set
			{
				global::PlayerRoles.FirstPersonControl.FpcExtensionMethods.TryOverridePosition(ReferenceHub, value);
			}
		}

		public global::UnityEngine.Quaternion Rotation
		{
			get
			{
				return GameObject.transform.rotation;
			}
			set
			{
				global::PlayerRoles.FirstPersonControl.FpcExtensionMethods.TryOverrideRotation(ReferenceHub, value.eulerAngles);
			}
		}

		public global::UnityEngine.Vector2 LookRotation
		{
			get
			{
				if (!(ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.FirstPersonControl.IFpcRole fpcRole))
				{
					return global::UnityEngine.Vector2.zero;
				}
				global::PlayerRoles.FirstPersonControl.FpcMouseLook mouseLook = fpcRole.FpcModule.MouseLook;
				return new global::UnityEngine.Vector2(mouseLook.CurrentVertical, mouseLook.CurrentHorizontal);
			}
			set
			{
				global::PlayerRoles.FirstPersonControl.FpcExtensionMethods.TryOverrideRotation(ReferenceHub, value);
			}
		}

		public global::UnityEngine.Vector3 Scale
		{
			get
			{
				if (!(ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.FirstPersonControl.IFpcRole fpcRole))
				{
					return global::UnityEngine.Vector3.zero;
				}
				return fpcRole.FpcModule.Motor.ScaleController.Scale;
			}
			set
			{
				if (ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.FirstPersonControl.IFpcRole fpcRole)
				{
					fpcRole.FpcModule.Motor.ScaleController.Scale = value;
				}
			}
		}

		public float StaminaRemaining
		{
			get
			{
				return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.StaminaStat>().CurValue;
			}
			set
			{
				ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.StaminaStat>().CurValue = value;
			}
		}

		public global::PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.EmotionPresetType Emotion
		{
			get
			{
				return global::PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.EmotionSync.GetEmotionPreset(ReferenceHub);
			}
			set
			{
				global::PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.EmotionSync.ServerSetEmotionPreset(ReferenceHub, value);
			}
		}

		public static bool ValidateCustomInfo(string text, out string rejectionReason)
		{
			return NicknameSync.ValidateCustomInfo(text, out rejectionReason);
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> GetAll(global::LabApi.Features.Enums.PlayerSearchFlags flags = global::LabApi.Features.Enums.PlayerSearchFlags.AuthenticatedAndDummy)
		{
			bool authenticated = (flags & global::LabApi.Features.Enums.PlayerSearchFlags.AuthenticatedPlayers) > global::LabApi.Features.Enums.PlayerSearchFlags.None;
			bool flag = (flags & global::LabApi.Features.Enums.PlayerSearchFlags.UnauthenticatedPlayers) > global::LabApi.Features.Enums.PlayerSearchFlags.None;
			bool dummyNpcs = (flags & global::LabApi.Features.Enums.PlayerSearchFlags.DummyNpcs) > global::LabApi.Features.Enums.PlayerSearchFlags.None;
			bool flag2 = (flags & global::LabApi.Features.Enums.PlayerSearchFlags.RegularNpcs) > global::LabApi.Features.Enums.PlayerSearchFlags.None;
			bool host = (flags & global::LabApi.Features.Enums.PlayerSearchFlags.Host) > global::LabApi.Features.Enums.PlayerSearchFlags.None;
			bool includePlayers = authenticated | flag;
			bool allPlayers = authenticated & flag;
			bool includeNpcs = dummyNpcs | flag2;
			bool allNpcs = dummyNpcs & flag2;
			foreach (global::LabApi.Features.Wrappers.Player item in List)
			{
				if ((includePlayers && item.IsPlayer && (allPlayers || item.IsReady == authenticated)) || (includeNpcs && item.IsNpc && (allNpcs || item.IsDummy == dummyNpcs)) || (host && item.IsHost))
				{
					yield return item;
				}
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("referenceHub")]
		public static global::LabApi.Features.Wrappers.Player? Get(ReferenceHub? referenceHub)
		{
			if (referenceHub == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(referenceHub, out global::LabApi.Features.Wrappers.Player value))
			{
				return CreatePlayerWrapper(referenceHub);
			}
			return value;
		}

		public static global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> Get(global::System.Collections.Generic.IEnumerable<ReferenceHub> referenceHubs)
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Player>.Shared.Rent();
			return GetNonAlloc(referenceHubs, list);
		}

		public static global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> GetNonAlloc(global::System.Collections.Generic.IEnumerable<ReferenceHub> referenceHubs, global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> list)
		{
			list.Clear();
			list.AddRange(global::System.Linq.Enumerable.Select(referenceHubs, Get));
			return list;
		}

		public static global::LabApi.Features.Wrappers.Player? Get(global::UnityEngine.GameObject? gameObject)
		{
			if (!TryGet(gameObject, out global::LabApi.Features.Wrappers.Player player))
			{
				return null;
			}
			return player;
		}

		public static bool TryGet(global::UnityEngine.GameObject? gameObject, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Player? player)
		{
			player = null;
			if (gameObject == null)
			{
				return false;
			}
			if (!ReferenceHub.TryGetHub(gameObject, out var hub))
			{
				return false;
			}
			player = Get(hub);
			return true;
		}

		public static global::LabApi.Features.Wrappers.Player? Get(global::Mirror.NetworkIdentity? identity)
		{
			if (!TryGet(identity, out global::LabApi.Features.Wrappers.Player player))
			{
				return null;
			}
			return player;
		}

		public static bool TryGet(global::Mirror.NetworkIdentity? identity, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Player? player)
		{
			player = null;
			if (identity == null)
			{
				return false;
			}
			if (!TryGet(identity.netId, out player))
			{
				return false;
			}
			return true;
		}

		public static global::LabApi.Features.Wrappers.Player? Get(uint netId)
		{
			if (!TryGet(netId, out global::LabApi.Features.Wrappers.Player player))
			{
				return null;
			}
			return player;
		}

		public static bool TryGet(uint netId, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Player? player)
		{
			player = null;
			if (!ReferenceHub.TryGetHubNetID(netId, out var hub))
			{
				return false;
			}
			player = Get(hub);
			return true;
		}

		public static global::LabApi.Features.Wrappers.Player? Get(global::CommandSystem.ICommandSender? sender)
		{
			if (!TryGet(sender, out global::LabApi.Features.Wrappers.Player player))
			{
				return null;
			}
			return player;
		}

		public static bool TryGet(global::CommandSystem.ICommandSender? sender, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Player? player)
		{
			player = null;
			if (!(sender is CommandSender commandSender))
			{
				return false;
			}
			return TryGet(commandSender.SenderId, out player);
		}

		public static global::LabApi.Features.Wrappers.Player? Get(string? userId)
		{
			if (!TryGet(userId, out global::LabApi.Features.Wrappers.Player player))
			{
				return null;
			}
			return player;
		}

		public static bool TryGet(string? userId, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Player? player)
		{
			player = null;
			if (string.IsNullOrEmpty(userId))
			{
				return false;
			}
			if (UserIdCache.TryGetValue(userId, out player) && player.IsOnline)
			{
				return true;
			}
			player = global::System.Linq.Enumerable.FirstOrDefault(List, (global::LabApi.Features.Wrappers.Player x) => x.UserId == userId);
			if (player == null)
			{
				return false;
			}
			UserIdCache[userId] = player;
			return true;
		}

		public static global::LabApi.Features.Wrappers.Player? Get(int playerId)
		{
			if (!TryGet(playerId, out global::LabApi.Features.Wrappers.Player player))
			{
				return null;
			}
			return player;
		}

		public static bool TryGet(int playerId, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Player? player)
		{
			player = global::System.Linq.Enumerable.FirstOrDefault(List, (global::LabApi.Features.Wrappers.Player n) => n.PlayerId == playerId);
			return player != null;
		}

		public static global::LabApi.Features.Wrappers.Player? GetByDisplayName(string input, bool requireFullMatch = false)
		{
			return GetByName(input, requireFullMatch, (global::LabApi.Features.Wrappers.Player p) => p.DisplayName);
		}

		public static global::LabApi.Features.Wrappers.Player? GetByNickname(string input, bool requireFullMatch = false)
		{
			return GetByName(input, requireFullMatch, (global::LabApi.Features.Wrappers.Player p) => p.Nickname);
		}

		public static global::LabApi.Features.Wrappers.Player? GetByName(string input, bool requireFullMatch, global::System.Func<global::LabApi.Features.Wrappers.Player, string> propertySelector)
		{
			foreach (global::LabApi.Features.Wrappers.Player item in global::System.Linq.Enumerable.OrderBy<global::LabApi.Features.Wrappers.Player, string>(List, propertySelector))
			{
				string text = propertySelector(item);
				if (requireFullMatch)
				{
					if (text.Equals(input, global::System.StringComparison.OrdinalIgnoreCase))
					{
						return item;
					}
				}
				else if (text.StartsWith(input, global::System.StringComparison.OrdinalIgnoreCase))
				{
					return item;
				}
			}
			return null;
		}

		public static bool TryGetPlayersByName(string input, out global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> players)
		{
			players = GetNonAlloc(global::System.Linq.Enumerable.Where(ReferenceHub.AllHubs, (ReferenceHub x) => x.nicknameSync.Network_myNickSync.StartsWith(input, global::System.StringComparison.OrdinalIgnoreCase)), global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Player>.Shared.Rent());
			return players.Count > 0;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			Dictionary.Clear();
			UserIdCache.Clear();
			ReferenceHub.OnPlayerAdded += AddPlayer;
			ReferenceHub.OnPlayerRemoved += RemovePlayer;
		}

		private static global::LabApi.Features.Wrappers.Player CreatePlayerWrapper(ReferenceHub referenceHub)
		{
			global::LabApi.Features.Wrappers.Player player = new global::LabApi.Features.Wrappers.Player(referenceHub);
			if (referenceHub.isLocalPlayer)
			{
				global::LabApi.Features.Wrappers.Server.Host = player;
			}
			return player;
		}

		private static void AddPlayer(ReferenceHub referenceHub)
		{
			try
			{
				if (!Dictionary.ContainsKey(referenceHub))
				{
					CreatePlayerWrapper(referenceHub);
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle player addition with exception: {arg}");
			}
		}

		private static void RemovePlayer(ReferenceHub referenceHub)
		{
			try
			{
				if (referenceHub.authManager.UserId != null)
				{
					UserIdCache.Remove(referenceHub.authManager.UserId);
				}
				if (TryGet(referenceHub.gameObject, out global::LabApi.Features.Wrappers.Player player))
				{
					global::LabApi.Features.Stores.CustomDataStoreManager.RemovePlayer(player);
				}
				if (referenceHub.isLocalPlayer)
				{
					global::LabApi.Features.Wrappers.Server.Host = null;
				}
				Dictionary.Remove(referenceHub);
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle player removal with exception: {arg}");
			}
		}

		internal Player(ReferenceHub referenceHub)
		{
			Dictionary.Add(referenceHub, this);
			ReferenceHub = referenceHub;
			global::LabApi.Features.Stores.CustomDataStoreManager.AddPlayer(this);
		}

		public void Move(global::UnityEngine.Vector3 delta)
		{
			global::PlayerRoles.FirstPersonControl.FpcExtensionMethods.TryOverridePosition(ReferenceHub, Position + delta);
		}

		public void Rotate(global::UnityEngine.Vector2 delta)
		{
			global::PlayerRoles.FirstPersonControl.FpcExtensionMethods.TryOverrideRotation(ReferenceHub, LookRotation + delta);
		}

		public void Jump(float jumpStrength)
		{
			if (ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.FirstPersonControl.IFpcRole fpcRole)
			{
				fpcRole.FpcModule.Motor.JumpController.ForceJump(jumpStrength);
			}
		}

		public void Jump()
		{
			if (ReferenceHub.roleManager.CurrentRole is global::PlayerRoles.FirstPersonControl.IFpcRole fpcRole)
			{
				Jump(fpcRole.FpcModule.JumpSpeed);
			}
		}

		public void ClearBroadcasts()
		{
			global::LabApi.Features.Wrappers.Server.ClearBroadcasts(this);
		}

		public void SendBroadcast(string message, ushort duration, Broadcast.BroadcastFlags type = Broadcast.BroadcastFlags.Normal, bool shouldClearPrevious = false)
		{
			global::LabApi.Features.Wrappers.Server.SendBroadcast(this, message, duration, type, shouldClearPrevious);
		}

		public void SendConsoleMessage(string message, string color = "green")
		{
			ReferenceHub.gameConsoleTransmission.SendToClient(message, color);
		}

		public void Mute(bool isTemporary = true)
		{
			if (isTemporary)
			{
				global::VoiceChat.VoiceChatMutes.SetFlags(ReferenceHub, global::VoiceChat.VoiceChatMutes.GetFlags(ReferenceHub) | global::VoiceChat.VcMuteFlags.LocalRegular);
			}
			else
			{
				global::VoiceChat.VoiceChatMutes.IssueLocalMute(UserId);
			}
		}

		public void Unmute(bool revokeMute)
		{
			if (revokeMute)
			{
				global::VoiceChat.VoiceChatMutes.RevokeLocalMute(UserId);
			}
			else
			{
				global::VoiceChat.VoiceChatMutes.SetFlags(ReferenceHub, global::VoiceChat.VoiceChatMutes.GetFlags(ReferenceHub) & ~global::VoiceChat.VcMuteFlags.LocalRegular);
			}
		}

		public void IntercomMute(bool isTemporary = false)
		{
			if (isTemporary)
			{
				global::VoiceChat.VoiceChatMutes.SetFlags(ReferenceHub, global::VoiceChat.VoiceChatMutes.GetFlags(ReferenceHub) | global::VoiceChat.VcMuteFlags.LocalIntercom);
			}
			else
			{
				global::VoiceChat.VoiceChatMutes.IssueLocalMute(UserId, intercom: true);
			}
		}

		public void IntercomUnmute(bool revokeMute)
		{
			if (revokeMute)
			{
				global::VoiceChat.VoiceChatMutes.RevokeLocalMute(UserId, intercom: true);
			}
			else
			{
				global::VoiceChat.VoiceChatMutes.SetFlags(ReferenceHub, global::VoiceChat.VoiceChatMutes.GetFlags(ReferenceHub) & ~global::VoiceChat.VcMuteFlags.LocalIntercom);
			}
		}

		public void AddAmmo(ItemType item, ushort amount)
		{
			global::InventorySystem.InventoryExtensions.ServerAddAmmo(Inventory, item, amount);
		}

		public global::LabApi.Features.Wrappers.Item? AddItem(ItemType item, global::InventorySystem.Items.ItemAddReason reason = global::InventorySystem.Items.ItemAddReason.AdminCommand)
		{
			return global::LabApi.Features.Wrappers.Item.Get(global::InventorySystem.InventoryExtensions.ServerAddItem(Inventory, item, reason, 0));
		}

		public global::LabApi.Features.Wrappers.Item? AddItem(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			return global::LabApi.Features.Wrappers.Item.Get(global::InventorySystem.InventoryExtensions.ServerAddItem(Inventory, pickup.Type, global::InventorySystem.Items.ItemAddReason.PickedUp, pickup.Serial, pickup.Base));
		}

		public void RemoveItem(global::LabApi.Features.Wrappers.Item item)
		{
			RemoveItem(item.Base);
		}

		public void RemoveItem(global::InventorySystem.Items.ItemBase item)
		{
			global::InventorySystem.InventoryExtensions.ServerRemoveItem(Inventory, item.ItemSerial, null);
		}

		public void RemoveItem(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			RemoveItem(pickup.Base);
		}

		public void RemoveItem(global::InventorySystem.Items.Pickups.ItemPickupBase pickup)
		{
			global::InventorySystem.InventoryExtensions.ServerRemoveItem(Inventory, pickup.Info.Serial, null);
		}

		public void RemoveItem(ItemType item, int maxAmount = 1)
		{
			int num = 0;
			global::LabApi.Features.Wrappers.Item[] array = global::System.Linq.Enumerable.ToArray(Items);
			for (int i = 0; i < array.Length; i++)
			{
				global::InventorySystem.Items.ItemBase itemBase = array[i].Base;
				if (itemBase.ItemTypeId == item)
				{
					RemoveItem(itemBase);
					if (++num >= maxAmount)
					{
						break;
					}
				}
			}
		}

		public global::LabApi.Features.Wrappers.Pickup DropItem(global::LabApi.Features.Wrappers.Item item)
		{
			return DropItem(item.Base);
		}

		public global::LabApi.Features.Wrappers.Pickup DropItem(global::InventorySystem.Items.ItemBase item)
		{
			return DropItem(item.ItemSerial);
		}

		public global::LabApi.Features.Wrappers.Pickup DropItem(ushort serial)
		{
			return global::LabApi.Features.Wrappers.Pickup.Get(global::InventorySystem.InventoryExtensions.ServerDropItem(Inventory, serial));
		}

		public global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Pickup> DropAllItems()
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Pickup> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Pickup>.Shared.Rent();
			global::LabApi.Features.Wrappers.Item[] array = global::System.Linq.Enumerable.ToArray(Items);
			foreach (global::LabApi.Features.Wrappers.Item item in array)
			{
				list.Add(DropItem(item));
			}
			return list;
		}

		public void SetAmmo(ItemType item, ushort amount)
		{
			global::InventorySystem.InventoryExtensions.ServerSetAmmo(Inventory, item, amount);
		}

		public ushort GetAmmo(ItemType item)
		{
			return global::InventorySystem.InventoryExtensions.GetCurAmmo(ReferenceHub.inventory, item);
		}

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.AmmoPickup> DropAmmo(ItemType item, ushort amount, bool checkMinimals = true)
		{
			return global::System.Linq.Enumerable.Select(global::InventorySystem.InventoryExtensions.ServerDropAmmo(Inventory, item, amount, checkMinimals), (global::InventorySystem.Items.Firearms.Ammo.AmmoPickup x) => global::LabApi.Features.Wrappers.AmmoPickup.Get(x));
		}

		public global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.AmmoPickup> DropAllAmmo()
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.AmmoPickup> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.AmmoPickup>.Shared.Rent();
			foreach (global::System.Collections.Generic.KeyValuePair<ItemType, ushort> item in global::System.Linq.Enumerable.ToDictionary(Ammo, (global::System.Collections.Generic.KeyValuePair<ItemType, ushort> e) => e.Key, (global::System.Collections.Generic.KeyValuePair<ItemType, ushort> e) => e.Value))
			{
				list.AddRange(DropAmmo(item.Key, item.Value));
			}
			return list;
		}

		public void DropEverything()
		{
			global::InventorySystem.InventoryExtensions.ServerDropEverything(Inventory);
		}

		public void ClearItems()
		{
			global::LabApi.Features.Wrappers.Item[] array = global::System.Linq.Enumerable.ToArray(Items);
			foreach (global::LabApi.Features.Wrappers.Item item in array)
			{
				RemoveItem(item);
			}
		}

		public void ClearAmmo()
		{
			if (global::Utils.NonAllocLINQ.DictionaryExtensions.Any(Ammo, (global::System.Collections.Generic.KeyValuePair<ItemType, ushort> x) => x.Value > 0))
			{
				Inventory.SendAmmoNextFrame = true;
			}
			Ammo.Clear();
		}

		public void ClearInventory(bool clearAmmo = true, bool clearItems = true)
		{
			if (clearAmmo)
			{
				ClearAmmo();
			}
			if (clearItems)
			{
				ClearItems();
			}
		}

		public void GiveCandy(global::InventorySystem.Items.Usables.Scp330.CandyKindID candy, global::InventorySystem.Items.ItemAddReason reason)
		{
			global::InventorySystem.InventoryExtensions.GrantCandy(ReferenceHub, candy, reason);
		}

		public void GiveRandomCandy(global::InventorySystem.Items.ItemAddReason reason = global::InventorySystem.Items.ItemAddReason.AdminCommand)
		{
			GiveCandy(global::InventorySystem.Items.Usables.Scp330.Scp330Candies.GetRandom(), reason);
		}

		public bool HasPermission(PlayerPermissions permission)
		{
			PlayerPermissions permissions = (PlayerPermissions)ReferenceHub.serverRoles.Permissions;
			return permissions.HasFlag(permission);
		}

		public void AddRegeneration(float rate, float duration)
		{
			global::InventorySystem.Items.Usables.Scp330.Scp330Bag.AddSimpleRegeneration(ReferenceHub, rate, duration);
		}

		public void Heal(float amount)
		{
			ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.HealthStat>().ServerHeal(amount);
		}

		public global::PlayerStatsSystem.AhpProcess CreateAhpProcess(float amount, float limit, float decay, float efficacy, float sustain, bool persistent)
		{
			return ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AhpStat>().ServerAddProcess(amount, limit, decay, efficacy, sustain, persistent);
		}

		public void ServerKillProcess(global::PlayerStatsSystem.AhpProcess process)
		{
			ReferenceHub.playerStats.GetModule<global::PlayerStatsSystem.AhpStat>().ServerKillProcess(process.KillCode);
		}

		public void SetRole(global::PlayerRoles.RoleTypeId newRole, global::PlayerRoles.RoleChangeReason reason = global::PlayerRoles.RoleChangeReason.RemoteAdmin, global::PlayerRoles.RoleSpawnFlags flags = global::PlayerRoles.RoleSpawnFlags.All)
		{
			ReferenceHub.roleManager.ServerSetRole(newRole, reason, flags);
		}

		public global::PlayerRoles.RoleTypeId GetRoleVisibilityFor(global::LabApi.Features.Wrappers.Player otherPlayer)
		{
			return global::PlayerRoles.FirstPersonControl.NetworkMessages.FpcServerPositionDistributor.GetVisibleRole(otherPlayer.ReferenceHub, ReferenceHub);
		}

		public void Disconnect(string? reason = null)
		{
			ServerConsole.Disconnect(GameObject, reason ?? string.Empty);
		}

		public void SendHint(string text, float duration = 3f)
		{
			SendHint(text, new global::Hints.HintParameter[1]
			{
				new global::Hints.StringHintParameter(string.Empty)
			}, null, duration);
		}

		public void SendHint(string text, global::Hints.HintEffect[] effects, float duration = 3f)
		{
			ReferenceHub.hints.Show(new global::Hints.TextHint(text, new global::Hints.HintParameter[1]
			{
				new global::Hints.StringHintParameter(string.Empty)
			}, effects, duration));
		}

		public void SendHint(string text, global::Hints.HintParameter[] parameters, global::Hints.HintEffect[]? effects = null, float duration = 3f)
		{
			ReferenceHub.hints.Show(new global::Hints.TextHint(text, (!parameters.IsEmpty()) ? parameters : new global::Hints.HintParameter[1]
			{
				new global::Hints.StringHintParameter(string.Empty)
			}, effects, duration));
		}

		public void SendHitMarker(float size = 1f)
		{
			Hitmarker.SendHitmarkerDirectly(Connection, size);
		}

		public T GetStatModule<T>() where T : global::PlayerStatsSystem.StatBase
		{
			return ReferenceHub.playerStats.GetModule<T>();
		}

		public bool HasEffect<T>() where T : global::CustomPlayerEffects.StatusEffectBase
		{
			if (ReferenceHub.playerEffectsController.TryGetEffect<T>(out var playerEffect) && playerEffect != null)
			{
				return playerEffect.IsEnabled;
			}
			return false;
		}

		public void DisableAllEffects()
		{
			ReferenceHub.playerEffectsController.DisableAllEffects();
		}

		public void DisableEffect<T>() where T : global::CustomPlayerEffects.StatusEffectBase
		{
			ReferenceHub.playerEffectsController.DisableEffect<T>();
		}

		public void DisableEffect(global::CustomPlayerEffects.StatusEffectBase? effect)
		{
			effect?.ServerDisable();
		}

		public void EnableEffect<T>(byte intensity = 1, float duration = 0f, bool addDuration = false) where T : global::CustomPlayerEffects.StatusEffectBase
		{
			ReferenceHub.playerEffectsController.ChangeState<T>(intensity, duration, addDuration);
		}

		public void EnableEffect(global::CustomPlayerEffects.StatusEffectBase? effect, byte intensity = 1, float duration = 0f, bool addDuration = false)
		{
			effect?.ServerSetState(intensity, duration, addDuration);
		}

		public bool TryGetEffect<T>([global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out T? effect) where T : global::CustomPlayerEffects.StatusEffectBase
		{
			if (ReferenceHub.playerEffectsController.TryGetEffect<T>(out effect))
			{
				return effect != null;
			}
			return false;
		}

		public bool TryGetEffect(string effectName, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::CustomPlayerEffects.StatusEffectBase? effect)
		{
			if (ReferenceHub.playerEffectsController.TryGetEffect(effectName, out effect))
			{
				return effect != null;
			}
			return false;
		}

		public T? GetEffect<T>() where T : global::CustomPlayerEffects.StatusEffectBase
		{
			return ReferenceHub.playerEffectsController.GetEffect<T>();
		}

		public void RedirectToServer(ushort port)
		{
			Connection.Send(new global::RoundRestarting.RoundRestartMessage(global::RoundRestarting.RoundRestartType.RedirectRestart, 0.1f, port, reconnect: true, extendedReconnectionPeriod: false));
		}

		public void Reconnect(float delay = 3f, bool isFastRestart = false)
		{
			Connection.Send(new global::RoundRestarting.RoundRestartMessage(isFastRestart ? global::RoundRestarting.RoundRestartType.FastRestart : global::RoundRestarting.RoundRestartType.FullRestart, delay, 0, reconnect: true, extendedReconnectionPeriod: false));
		}

		public void Kill()
		{
			Damage(new global::PlayerStatsSystem.UniversalDamageHandler(-1f, global::PlayerStatsSystem.DeathTranslations.Unknown));
		}

		public bool Kill(string reason, string cassieAnnouncement = "")
		{
			return Damage(new global::PlayerStatsSystem.CustomReasonDamageHandler(reason, -1f, cassieAnnouncement));
		}

		public bool Damage(float amount, string reason, string cassieAnnouncement = "")
		{
			return Damage(new global::PlayerStatsSystem.CustomReasonDamageHandler(reason, amount, cassieAnnouncement));
		}

		public bool Damage(float amount, global::LabApi.Features.Wrappers.Player attacker, global::UnityEngine.Vector3 force = default(global::UnityEngine.Vector3), int armorPenetration = 0)
		{
			return Damage(new global::PlayerStatsSystem.ExplosionDamageHandler(new global::Footprinting.Footprint(attacker.ReferenceHub), force, amount, armorPenetration, ExplosionType.Grenade));
		}

		public bool Damage(global::PlayerStatsSystem.DamageHandlerBase damageHandlerBase)
		{
			return ReferenceHub.playerStats.DealDamage(damageHandlerBase);
		}

		public bool Ban(global::LabApi.Features.Wrappers.Player issuer, string reason, long duration)
		{
			return global::LabApi.Features.Wrappers.Server.BanPlayer(this, issuer, reason, duration);
		}

		public bool Ban(string reason, long duration)
		{
			return global::LabApi.Features.Wrappers.Server.BanPlayer(this, reason, duration);
		}

		public bool Kick(global::LabApi.Features.Wrappers.Player issuer, string reason)
		{
			return global::LabApi.Features.Wrappers.Server.KickPlayer(this, issuer, reason);
		}

		public bool Kick(string reason)
		{
			return global::LabApi.Features.Wrappers.Server.KickPlayer(this, reason);
		}

		public TStore GetDataStore<TStore>() where TStore : global::LabApi.Features.Stores.CustomDataStore
		{
			return global::LabApi.Features.Stores.CustomDataStore.GetOrAdd<TStore>(this);
		}

		public override string ToString()
		{
			return $"[Player: DisplayName={DisplayName}, PlayerId={PlayerId}, NetworkId={NetworkId}, UserId={UserId}, IpAddress={IpAddress}, Role={Role}, IsHost={IsHost}, IsReady={IsReady}]";
		}
	}
}
