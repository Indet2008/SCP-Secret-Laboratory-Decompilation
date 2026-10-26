using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using Achievements;
using AdminToys;
using Cassie;
using CentralAuth;
using CommandSystem.Commands.RemoteAdmin.Cleanup;
using CommandSystem.Commands.RemoteAdmin.Stripdown;
using CustomPlayerEffects;
using DrawableLine;
using Hints;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Disarming;
using InventorySystem.Items;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Ammo;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.BasicMessages;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Jailbird;
using InventorySystem.Items.Keycards;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.Radio;
using InventorySystem.Items.ThrowableProjectiles;
using InventorySystem.Items.ToggleableLights;
using InventorySystem.Items.Usables;
using InventorySystem.Items.Usables.Scp1344;
using InventorySystem.Items.Usables.Scp1576;
using InventorySystem.Items.Usables.Scp244.Hypothermia;
using InventorySystem.Items.Usables.Scp330;
using InventorySystem.Searching;
using LightContainmentZoneDecontamination;
using MapGeneration;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.NetworkMessages;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.PlayableScps.Scp049.Zombies;
using PlayerRoles.PlayableScps.Scp106;
using PlayerRoles.Ragdolls;
using PlayerRoles.RoleAssign;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using PlayerRoles.Voice;
using PlayerStatsSystem;
using RelativePositioning;
using RemoteAdmin;
using Respawning;
using Respawning.NamingRules;
using Respawning.Waves;
using RoundRestarting;
using Scp914;
using Subtitles;
using UnityEngine;
using UserSettings.ServerSpecific;
using Utils;
using Utils.Networking;
using VoiceChat;
using VoiceChat.Networking;
using VoiceChat.Playbacks;

namespace Mirror
{
	[StructLayout(LayoutKind.Auto, CharSet = CharSet.Auto)]
	public static class GeneratedNetworkCode
	{
		public static TimeSnapshotMessage _Read_Mirror_002ETimeSnapshotMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002ETimeSnapshotMessage(NetworkWriter writer, TimeSnapshotMessage value)
		{
		}

		public static ReadyMessage _Read_Mirror_002EReadyMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EReadyMessage(NetworkWriter writer, ReadyMessage value)
		{
		}

		public static NotReadyMessage _Read_Mirror_002ENotReadyMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002ENotReadyMessage(NetworkWriter writer, NotReadyMessage value)
		{
		}

		public static AddPlayerMessage _Read_Mirror_002EAddPlayerMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EAddPlayerMessage(NetworkWriter writer, AddPlayerMessage value)
		{
		}

		public static SceneMessage _Read_Mirror_002ESceneMessage(NetworkReader reader)
		{
			return new SceneMessage
			{
				sceneName = reader.ReadString(),
				sceneOperation = _Read_Mirror_002ESceneOperation(reader),
				customHandling = reader.ReadBool()
			};
		}

		public static SceneOperation _Read_Mirror_002ESceneOperation(NetworkReader reader)
		{
			return (SceneOperation)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_Mirror_002ESceneMessage(NetworkWriter writer, SceneMessage value)
		{
			writer.WriteString(value.sceneName);
			_Write_Mirror_002ESceneOperation(writer, value.sceneOperation);
			writer.WriteBool(value.customHandling);
		}

		public static void _Write_Mirror_002ESceneOperation(NetworkWriter writer, SceneOperation value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static CommandMessage _Read_Mirror_002ECommandMessage(NetworkReader reader)
		{
			return new CommandMessage
			{
				netId = reader.ReadUInt(),
				componentIndex = NetworkReaderExtensions.ReadByte(reader),
				functionHash = reader.ReadUShort(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002ECommandMessage(NetworkWriter writer, CommandMessage value)
		{
			writer.WriteUInt(value.netId);
			NetworkWriterExtensions.WriteByte(writer, value.componentIndex);
			writer.WriteUShort(value.functionHash);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static RpcMessage _Read_Mirror_002ERpcMessage(NetworkReader reader)
		{
			return new RpcMessage
			{
				netId = reader.ReadUInt(),
				componentIndex = NetworkReaderExtensions.ReadByte(reader),
				functionHash = reader.ReadUShort(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002ERpcMessage(NetworkWriter writer, RpcMessage value)
		{
			writer.WriteUInt(value.netId);
			NetworkWriterExtensions.WriteByte(writer, value.componentIndex);
			writer.WriteUShort(value.functionHash);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static SpawnMessage _Read_Mirror_002ESpawnMessage(NetworkReader reader)
		{
			return new SpawnMessage
			{
				netId = reader.ReadUInt(),
				isLocalPlayer = reader.ReadBool(),
				isOwner = reader.ReadBool(),
				sceneId = reader.ReadULong(),
				assetId = reader.ReadUInt(),
				position = reader.ReadVector3(),
				rotation = reader.ReadQuaternion(),
				scale = reader.ReadVector3(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002ESpawnMessage(NetworkWriter writer, SpawnMessage value)
		{
			writer.WriteUInt(value.netId);
			writer.WriteBool(value.isLocalPlayer);
			writer.WriteBool(value.isOwner);
			writer.WriteULong(value.sceneId);
			writer.WriteUInt(value.assetId);
			writer.WriteVector3(value.position);
			writer.WriteQuaternion(value.rotation);
			writer.WriteVector3(value.scale);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static ChangeOwnerMessage _Read_Mirror_002EChangeOwnerMessage(NetworkReader reader)
		{
			return new ChangeOwnerMessage
			{
				netId = reader.ReadUInt(),
				isOwner = reader.ReadBool(),
				isLocalPlayer = reader.ReadBool()
			};
		}

		public static void _Write_Mirror_002EChangeOwnerMessage(NetworkWriter writer, ChangeOwnerMessage value)
		{
			writer.WriteUInt(value.netId);
			writer.WriteBool(value.isOwner);
			writer.WriteBool(value.isLocalPlayer);
		}

		public static ObjectSpawnStartedMessage _Read_Mirror_002EObjectSpawnStartedMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EObjectSpawnStartedMessage(NetworkWriter writer, ObjectSpawnStartedMessage value)
		{
		}

		public static ObjectSpawnFinishedMessage _Read_Mirror_002EObjectSpawnFinishedMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_Mirror_002EObjectSpawnFinishedMessage(NetworkWriter writer, ObjectSpawnFinishedMessage value)
		{
		}

		public static ObjectDestroyMessage _Read_Mirror_002EObjectDestroyMessage(NetworkReader reader)
		{
			return new ObjectDestroyMessage
			{
				netId = reader.ReadUInt()
			};
		}

		public static void _Write_Mirror_002EObjectDestroyMessage(NetworkWriter writer, ObjectDestroyMessage value)
		{
			writer.WriteUInt(value.netId);
		}

		public static ObjectHideMessage _Read_Mirror_002EObjectHideMessage(NetworkReader reader)
		{
			return new ObjectHideMessage
			{
				netId = reader.ReadUInt()
			};
		}

		public static void _Write_Mirror_002EObjectHideMessage(NetworkWriter writer, ObjectHideMessage value)
		{
			writer.WriteUInt(value.netId);
		}

		public static EntityStateMessage _Read_Mirror_002EEntityStateMessage(NetworkReader reader)
		{
			return new EntityStateMessage
			{
				netId = reader.ReadUInt(),
				payload = reader.ReadArraySegmentAndSize()
			};
		}

		public static void _Write_Mirror_002EEntityStateMessage(NetworkWriter writer, EntityStateMessage value)
		{
			writer.WriteUInt(value.netId);
			writer.WriteArraySegmentAndSize(value.payload);
		}

		public static NetworkPingMessage _Read_Mirror_002ENetworkPingMessage(NetworkReader reader)
		{
			return new NetworkPingMessage
			{
				localTime = reader.ReadDouble()
			};
		}

		public static void _Write_Mirror_002ENetworkPingMessage(NetworkWriter writer, NetworkPingMessage value)
		{
			writer.WriteDouble(value.localTime);
		}

		public static NetworkPongMessage _Read_Mirror_002ENetworkPongMessage(NetworkReader reader)
		{
			return new NetworkPongMessage
			{
				localTime = reader.ReadDouble()
			};
		}

		public static void _Write_Mirror_002ENetworkPongMessage(NetworkWriter writer, NetworkPongMessage value)
		{
			writer.WriteDouble(value.localTime);
		}

		public static DeadmanSwitch.DeadMansSequenceActiveMessage _Read_DeadmanSwitch_002FDeadMansSequenceActiveMessage(NetworkReader reader)
		{
			return new DeadmanSwitch.DeadMansSequenceActiveMessage
			{
				IsActive = reader.ReadBool()
			};
		}

		public static void _Write_DeadmanSwitch_002FDeadMansSequenceActiveMessage(NetworkWriter writer, DeadmanSwitch.DeadMansSequenceActiveMessage value)
		{
			writer.WriteBool(value.IsActive);
		}

		public static Hitmarker.HitmarkerMessage _Read_Hitmarker_002FHitmarkerMessage(NetworkReader reader)
		{
			return new Hitmarker.HitmarkerMessage
			{
				Size = NetworkReaderExtensions.ReadByte(reader),
				Audio = reader.ReadBool(),
				Hitmarker = _Read_HitmarkerType(reader)
			};
		}

		public static HitmarkerType _Read_HitmarkerType(NetworkReader reader)
		{
			return (HitmarkerType)reader.ReadInt();
		}

		public static void _Write_Hitmarker_002FHitmarkerMessage(NetworkWriter writer, Hitmarker.HitmarkerMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.Size);
			writer.WriteBool(value.Audio);
			_Write_HitmarkerType(writer, value.Hitmarker);
		}

		public static void _Write_HitmarkerType(NetworkWriter writer, HitmarkerType value)
		{
			writer.WriteInt((int)value);
		}

		public static Escape.EscapeMessage _Read_Escape_002FEscapeMessage(NetworkReader reader)
		{
			return new Escape.EscapeMessage
			{
				ScenarioId = NetworkReaderExtensions.ReadByte(reader),
				EscapeTime = reader.ReadUShort()
			};
		}

		public static void _Write_Escape_002FEscapeMessage(NetworkWriter writer, Escape.EscapeMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.ScenarioId);
			writer.WriteUShort(value.EscapeTime);
		}

		public static ServerShutdown.ServerShutdownMessage _Read_ServerShutdown_002FServerShutdownMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_ServerShutdown_002FServerShutdownMessage(NetworkWriter writer, ServerShutdown.ServerShutdownMessage value)
		{
		}

		public static VoiceChatMuteIndicator.SyncMuteMessage _Read_VoiceChat_002EVoiceChatMuteIndicator_002FSyncMuteMessage(NetworkReader reader)
		{
			return new VoiceChatMuteIndicator.SyncMuteMessage
			{
				Flags = NetworkReaderExtensions.ReadByte(reader)
			};
		}

		public static void _Write_VoiceChat_002EVoiceChatMuteIndicator_002FSyncMuteMessage(NetworkWriter writer, VoiceChatMuteIndicator.SyncMuteMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.Flags);
		}

		public static VoiceChatPrivacySettings.VcPrivacyMessage _Read_VoiceChat_002EVoiceChatPrivacySettings_002FVcPrivacyMessage(NetworkReader reader)
		{
			return new VoiceChatPrivacySettings.VcPrivacyMessage
			{
				Flags = NetworkReaderExtensions.ReadByte(reader)
			};
		}

		public static void _Write_VoiceChat_002EVoiceChatPrivacySettings_002FVcPrivacyMessage(NetworkWriter writer, VoiceChatPrivacySettings.VcPrivacyMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.Flags);
		}

		public static PersonalRadioPlayback.TransmitterPositionMessage _Read_VoiceChat_002EPlaybacks_002EPersonalRadioPlayback_002FTransmitterPositionMessage(NetworkReader reader)
		{
			return new PersonalRadioPlayback.TransmitterPositionMessage
			{
				Transmitter = reader.ReadRecyclablePlayerId(),
				WaypointId = NetworkReaderExtensions.ReadByte(reader)
			};
		}

		public static void _Write_VoiceChat_002EPlaybacks_002EPersonalRadioPlayback_002FTransmitterPositionMessage(NetworkWriter writer, PersonalRadioPlayback.TransmitterPositionMessage value)
		{
			writer.WriteRecyclablePlayerId(value.Transmitter);
			NetworkWriterExtensions.WriteByte(writer, value.WaypointId);
		}

		public static LockerWaypoint.LockerWaypointAssignMessage _Read_RelativePositioning_002ELockerWaypoint_002FLockerWaypointAssignMessage(NetworkReader reader)
		{
			return new LockerWaypoint.LockerWaypointAssignMessage
			{
				LockerNetId = reader.ReadUInt(),
				Chamber = NetworkReaderExtensions.ReadByte(reader),
				WaypointId = NetworkReaderExtensions.ReadByte(reader)
			};
		}

		public static void _Write_RelativePositioning_002ELockerWaypoint_002FLockerWaypointAssignMessage(NetworkWriter writer, LockerWaypoint.LockerWaypointAssignMessage value)
		{
			writer.WriteUInt(value.LockerNetId);
			NetworkWriterExtensions.WriteByte(writer, value.Chamber);
			NetworkWriterExtensions.WriteByte(writer, value.WaypointId);
		}

		public static VoiceChatReceivePrefs.GroupMuteFlagsMessage _Read_PlayerRoles_002EVoice_002EVoiceChatReceivePrefs_002FGroupMuteFlagsMessage(NetworkReader reader)
		{
			return new VoiceChatReceivePrefs.GroupMuteFlagsMessage
			{
				Flags = NetworkReaderExtensions.ReadByte(reader)
			};
		}

		public static void _Write_PlayerRoles_002EVoice_002EVoiceChatReceivePrefs_002FGroupMuteFlagsMessage(NetworkWriter writer, VoiceChatReceivePrefs.GroupMuteFlagsMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.Flags);
		}

		public static OverwatchSettingsController.OverwatchSettingsInfoMessage _Read_PlayerRoles_002ESpectating_002EOverwatchSettingsController_002FOverwatchSettingsInfoMessage(NetworkReader reader)
		{
			return new OverwatchSettingsController.OverwatchSettingsInfoMessage
			{
				SpatialAudio = reader.ReadBool(),
				EnabledChannels = reader.ReadUInt(),
				EnablePlayerInfo = reader.ReadBool(),
				EnableHitregLog = reader.ReadBool()
			};
		}

		public static void _Write_PlayerRoles_002ESpectating_002EOverwatchSettingsController_002FOverwatchSettingsInfoMessage(NetworkWriter writer, OverwatchSettingsController.OverwatchSettingsInfoMessage value)
		{
			writer.WriteBool(value.SpatialAudio);
			writer.WriteUInt(value.EnabledChannels);
			writer.WriteBool(value.EnablePlayerInfo);
			writer.WriteBool(value.EnableHitregLog);
		}

		public static SpectatorNetworking.SpectatedNetIdSyncMessage _Read_PlayerRoles_002ESpectating_002ESpectatorNetworking_002FSpectatedNetIdSyncMessage(NetworkReader reader)
		{
			return new SpectatorNetworking.SpectatedNetIdSyncMessage
			{
				NetId = reader.ReadUInt()
			};
		}

		public static void _Write_PlayerRoles_002ESpectating_002ESpectatorNetworking_002FSpectatedNetIdSyncMessage(NetworkWriter writer, SpectatorNetworking.SpectatedNetIdSyncMessage value)
		{
			writer.WriteUInt(value.NetId);
		}

		public static Scp106PocketItemManager.WarningMessage _Read_PlayerRoles_002EPlayableScps_002EScp106_002EScp106PocketItemManager_002FWarningMessage(NetworkReader reader)
		{
			return new Scp106PocketItemManager.WarningMessage
			{
				Position = reader.ReadRelativePosition()
			};
		}

		public static void _Write_PlayerRoles_002EPlayableScps_002EScp106_002EScp106PocketItemManager_002FWarningMessage(NetworkWriter writer, Scp106PocketItemManager.WarningMessage value)
		{
			writer.WriteRelativePosition(value.Position);
		}

		public static ZombieConfirmationBox.ScpReviveBlockMessage _Read_PlayerRoles_002EPlayableScps_002EScp049_002EZombies_002EZombieConfirmationBox_002FScpReviveBlockMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_PlayerRoles_002EPlayableScps_002EScp049_002EZombies_002EZombieConfirmationBox_002FScpReviveBlockMessage(NetworkWriter writer, ZombieConfirmationBox.ScpReviveBlockMessage value)
		{
		}

		public static DynamicHumeShieldController.ShieldBreakMessage _Read_PlayerRoles_002EPlayableScps_002EHumeShield_002EDynamicHumeShieldController_002FShieldBreakMessage(NetworkReader reader)
		{
			return new DynamicHumeShieldController.ShieldBreakMessage
			{
				Target = reader.ReadReferenceHub()
			};
		}

		public static void _Write_PlayerRoles_002EPlayableScps_002EHumeShield_002EDynamicHumeShieldController_002FShieldBreakMessage(NetworkWriter writer, DynamicHumeShieldController.ShieldBreakMessage value)
		{
			writer.WriteReferenceHub(value.Target);
		}

		public static FpcRotationOverrideMessage _Read_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcRotationOverrideMessage(NetworkReader reader)
		{
			return new FpcRotationOverrideMessage
			{
				Rotation = reader.ReadVector2()
			};
		}

		public static void _Write_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcRotationOverrideMessage(NetworkWriter writer, FpcRotationOverrideMessage value)
		{
			writer.WriteVector2(value.Rotation);
		}

		public static FpcNoclipToggleMessage _Read_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcNoclipToggleMessage(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcNoclipToggleMessage(NetworkWriter writer, FpcNoclipToggleMessage value)
		{
		}

		public static EmotionSync.EmotionSyncMessage _Read_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionSync_002FEmotionSyncMessage(NetworkReader reader)
		{
			return new EmotionSync.EmotionSyncMessage
			{
				HubNetId = reader.ReadUInt(),
				Data = _Read_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionPresetType(reader)
			};
		}

		public static EmotionPresetType _Read_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionPresetType(NetworkReader reader)
		{
			return (EmotionPresetType)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionSync_002FEmotionSyncMessage(NetworkWriter writer, EmotionSync.EmotionSyncMessage value)
		{
			writer.WriteUInt(value.HubNetId);
			_Write_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionPresetType(writer, value.Data);
		}

		public static void _Write_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionPresetType(NetworkWriter writer, EmotionPresetType value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static ExplosionUtils.GrenadeExplosionMessage _Read_Utils_002EExplosionUtils_002FGrenadeExplosionMessage(NetworkReader reader)
		{
			return new ExplosionUtils.GrenadeExplosionMessage
			{
				GrenadeType = NetworkReaderExtensions.ReadByte(reader),
				Pos = reader.ReadRelativePosition()
			};
		}

		public static void _Write_Utils_002EExplosionUtils_002FGrenadeExplosionMessage(NetworkWriter writer, ExplosionUtils.GrenadeExplosionMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.GrenadeType);
			writer.WriteRelativePosition(value.Pos);
		}

		public static SeedSynchronizer.SeedMessage _Read_MapGeneration_002ESeedSynchronizer_002FSeedMessage(NetworkReader reader)
		{
			return new SeedSynchronizer.SeedMessage
			{
				Value = reader.ReadInt()
			};
		}

		public static void _Write_MapGeneration_002ESeedSynchronizer_002FSeedMessage(NetworkWriter writer, SeedSynchronizer.SeedMessage value)
		{
			writer.WriteInt(value.Value);
		}

		public static CustomPlayerEffects.AntiScp207.BreakMessage _Read_CustomPlayerEffects_002EAntiScp207_002FBreakMessage(NetworkReader reader)
		{
			return new CustomPlayerEffects.AntiScp207.BreakMessage
			{
				SoundPos = reader.ReadVector3()
			};
		}

		public static void _Write_CustomPlayerEffects_002EAntiScp207_002FBreakMessage(NetworkWriter writer, CustomPlayerEffects.AntiScp207.BreakMessage value)
		{
			writer.WriteVector3(value.SoundPos);
		}

		public static Prismatic.BreakMessage _Read_CustomPlayerEffects_002EPrismatic_002FBreakMessage(NetworkReader reader)
		{
			return new Prismatic.BreakMessage
			{
				SoundPos = reader.ReadVector3()
			};
		}

		public static void _Write_CustomPlayerEffects_002EPrismatic_002FBreakMessage(NetworkWriter writer, Prismatic.BreakMessage value)
		{
			writer.WriteVector3(value.SoundPos);
		}

		public static GhostlyWalkThroughMessage _Read_CustomPlayerEffects_002EGhostlyWalkThroughMessage(NetworkReader reader)
		{
			return new GhostlyWalkThroughMessage
			{
				Position = reader.ReadVector3()
			};
		}

		public static void _Write_CustomPlayerEffects_002EGhostlyWalkThroughMessage(NetworkWriter writer, GhostlyWalkThroughMessage value)
		{
			writer.WriteVector3(value.Position);
		}

		public static InfluenceUpdateMessage _Read_Respawning_002EInfluenceUpdateMessage(NetworkReader reader)
		{
			return new InfluenceUpdateMessage
			{
				Faction = _Read_PlayerRoles_002EFaction(reader),
				Influence = reader.ReadFloat()
			};
		}

		public static Faction _Read_PlayerRoles_002EFaction(NetworkReader reader)
		{
			return (Faction)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_Respawning_002EInfluenceUpdateMessage(NetworkWriter writer, InfluenceUpdateMessage value)
		{
			_Write_PlayerRoles_002EFaction(writer, value.Faction);
			writer.WriteFloat(value.Influence);
		}

		public static void _Write_PlayerRoles_002EFaction(NetworkWriter writer, Faction value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static StripdownNetworking.StripdownResponse _Read_CommandSystem_002ECommands_002ERemoteAdmin_002EStripdown_002EStripdownNetworking_002FStripdownResponse(NetworkReader reader)
		{
			return new StripdownNetworking.StripdownResponse
			{
				Lines = _Read_System_002EString_005B_005D(reader)
			};
		}

		public static string[] _Read_System_002EString_005B_005D(NetworkReader reader)
		{
			return reader.ReadArray<string>();
		}

		public static void _Write_CommandSystem_002ECommands_002ERemoteAdmin_002EStripdown_002EStripdownNetworking_002FStripdownResponse(NetworkWriter writer, StripdownNetworking.StripdownResponse value)
		{
			_Write_System_002EString_005B_005D(writer, value.Lines);
		}

		public static void _Write_System_002EString_005B_005D(NetworkWriter writer, string[] value)
		{
			writer.WriteArray(value);
		}

		public static AchievementManager.AchievementMessage _Read_Achievements_002EAchievementManager_002FAchievementMessage(NetworkReader reader)
		{
			return new AchievementManager.AchievementMessage
			{
				AchievementId = NetworkReaderExtensions.ReadByte(reader)
			};
		}

		public static void _Write_Achievements_002EAchievementManager_002FAchievementMessage(NetworkWriter writer, AchievementManager.AchievementMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.AchievementId);
		}

		public static HumeShieldSubEffect.HumeBlockMsg _Read_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHumeShieldSubEffect_002FHumeBlockMsg(NetworkReader reader)
		{
			return default;
		}

		public static void _Write_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHumeShieldSubEffect_002FHumeBlockMsg(NetworkWriter writer, HumeShieldSubEffect.HumeBlockMsg value)
		{
		}

		public static Hypothermia.ForcedHypothermiaMessage _Read_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHypothermia_002FForcedHypothermiaMessage(NetworkReader reader)
		{
			return new Hypothermia.ForcedHypothermiaMessage
			{
				IsForced = reader.ReadBool(),
				Exposure = reader.ReadFloat(),
				PlayerHub = reader.ReadReferenceHub()
			};
		}

		public static void _Write_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHypothermia_002FForcedHypothermiaMessage(NetworkWriter writer, Hypothermia.ForcedHypothermiaMessage value)
		{
			writer.WriteBool(value.IsForced);
			writer.WriteFloat(value.Exposure);
			writer.WriteReferenceHub(value.PlayerHub);
		}

		public static Scp1576SpectatorWarningHandler.SpectatorWarningMessage _Read_InventorySystem_002EItems_002EUsables_002EScp1576_002EScp1576SpectatorWarningHandler_002FSpectatorWarningMessage(NetworkReader reader)
		{
			return new Scp1576SpectatorWarningHandler.SpectatorWarningMessage
			{
				IsStop = reader.ReadBool()
			};
		}

		public static void _Write_InventorySystem_002EItems_002EUsables_002EScp1576_002EScp1576SpectatorWarningHandler_002FSpectatorWarningMessage(NetworkWriter writer, Scp1576SpectatorWarningHandler.SpectatorWarningMessage value)
		{
			writer.WriteBool(value.IsStop);
		}

		public static Scp1344StatusMessage _Read_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344StatusMessage(NetworkReader reader)
		{
			return new Scp1344StatusMessage
			{
				Serial = reader.ReadUShort(),
				NewState = _Read_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344Status(reader)
			};
		}

		public static Scp1344Status _Read_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344Status(NetworkReader reader)
		{
			return (Scp1344Status)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344StatusMessage(NetworkWriter writer, Scp1344StatusMessage value)
		{
			writer.WriteUShort(value.Serial);
			_Write_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344Status(writer, value.NewState);
		}

		public static void _Write_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344Status(NetworkWriter writer, Scp1344Status value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static DamageIndicatorMessage _Read_InventorySystem_002EItems_002EFirearms_002EBasicMessages_002EDamageIndicatorMessage(NetworkReader reader)
		{
			return new DamageIndicatorMessage
			{
				ReceivedDamage = NetworkReaderExtensions.ReadByte(reader),
				DamagePosition = reader.ReadRelativePosition()
			};
		}

		public static void _Write_InventorySystem_002EItems_002EFirearms_002EBasicMessages_002EDamageIndicatorMessage(NetworkWriter writer, DamageIndicatorMessage value)
		{
			NetworkWriterExtensions.WriteByte(writer, value.ReceivedDamage);
			writer.WriteRelativePosition(value.DamagePosition);
		}

		public static void _Write_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(NetworkWriter writer, DoorPermissionFlags value)
		{
			writer.WriteUShort((ushort)value);
		}

		public static DoorPermissionFlags _Read_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(NetworkReader reader)
		{
			return (DoorPermissionFlags)reader.ReadUShort();
		}

		public static ServerConfigSynchronizer.PredefinedBanTemplate _Read_ServerConfigSynchronizer_002FPredefinedBanTemplate(NetworkReader reader)
		{
			return new ServerConfigSynchronizer.PredefinedBanTemplate
			{
				Duration = reader.ReadInt(),
				FormattedDuration = reader.ReadString(),
				Reason = reader.ReadString()
			};
		}

		public static void _Write_ServerConfigSynchronizer_002FPredefinedBanTemplate(NetworkWriter writer, ServerConfigSynchronizer.PredefinedBanTemplate value)
		{
			writer.WriteInt(value.Duration);
			writer.WriteString(value.FormattedDuration);
			writer.WriteString(value.Reason);
		}

		public static void _Write_Broadcast_002FBroadcastFlags(NetworkWriter writer, Broadcast.BroadcastFlags value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static Broadcast.BroadcastFlags _Read_Broadcast_002FBroadcastFlags(NetworkReader reader)
		{
			return (Broadcast.BroadcastFlags)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_UnityEngine_002EKeyCode(NetworkWriter writer, KeyCode value)
		{
			writer.WriteInt((int)value);
		}

		public static KeyCode _Read_UnityEngine_002EKeyCode(NetworkReader reader)
		{
			return (KeyCode)reader.ReadInt();
		}

		public static void _Write_PlayerInfoArea(NetworkWriter writer, PlayerInfoArea value)
		{
			writer.WriteInt((int)value);
		}

		public static PlayerInfoArea _Read_PlayerInfoArea(NetworkReader reader)
		{
			return (PlayerInfoArea)reader.ReadInt();
		}

		public static void _Write_RoundSummary_002FSumInfo_ClassList(NetworkWriter writer, RoundSummary.SumInfo_ClassList value)
		{
			writer.WriteInt(value.class_ds);
			writer.WriteInt(value.scientists);
			writer.WriteInt(value.chaos_insurgents);
			writer.WriteInt(value.mtf_and_guards);
			writer.WriteInt(value.scps_except_zombies);
			writer.WriteInt(value.zombies);
			writer.WriteInt(value.warhead_kills);
			writer.WriteInt(value.flamingos);
		}

		public static void _Write_RoundSummary_002FLeadingTeam(NetworkWriter writer, RoundSummary.LeadingTeam value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static RoundSummary.SumInfo_ClassList _Read_RoundSummary_002FSumInfo_ClassList(NetworkReader reader)
		{
			return new RoundSummary.SumInfo_ClassList
			{
				class_ds = reader.ReadInt(),
				scientists = reader.ReadInt(),
				chaos_insurgents = reader.ReadInt(),
				mtf_and_guards = reader.ReadInt(),
				scps_except_zombies = reader.ReadInt(),
				zombies = reader.ReadInt(),
				warhead_kills = reader.ReadInt(),
				flamingos = reader.ReadInt()
			};
		}

		public static RoundSummary.LeadingTeam _Read_RoundSummary_002FLeadingTeam(NetworkReader reader)
		{
			return (RoundSummary.LeadingTeam)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_ServerRoles_002FBadgePreferences(NetworkWriter writer, ServerRoles.BadgePreferences value)
		{
			writer.WriteInt((int)value);
		}

		public static void _Write_ServerRoles_002FBadgeVisibilityPreferences(NetworkWriter writer, ServerRoles.BadgeVisibilityPreferences value)
		{
			writer.WriteInt((int)value);
		}

		public static ServerRoles.BadgePreferences _Read_ServerRoles_002FBadgePreferences(NetworkReader reader)
		{
			return (ServerRoles.BadgePreferences)reader.ReadInt();
		}

		public static ServerRoles.BadgeVisibilityPreferences _Read_ServerRoles_002FBadgeVisibilityPreferences(NetworkReader reader)
		{
			return (ServerRoles.BadgeVisibilityPreferences)reader.ReadInt();
		}

		public static void _Write_RemoteAdmin_002EQueryProcessor_002FCommandData_005B_005D(NetworkWriter writer, QueryProcessor.CommandData[] value)
		{
			writer.WriteArray(value);
		}

		public static void _Write_RemoteAdmin_002EQueryProcessor_002FCommandData(NetworkWriter writer, QueryProcessor.CommandData value)
		{
			writer.WriteString(value.Command);
			_Write_System_002EString_005B_005D(writer, value.Usage);
			writer.WriteString(value.Description);
			writer.WriteString(value.AliasOf);
			writer.WriteBool(value.Hidden);
		}

		public static QueryProcessor.CommandData[] _Read_RemoteAdmin_002EQueryProcessor_002FCommandData_005B_005D(NetworkReader reader)
		{
			return reader.ReadArray<QueryProcessor.CommandData>();
		}

		public static QueryProcessor.CommandData _Read_RemoteAdmin_002EQueryProcessor_002FCommandData(NetworkReader reader)
		{
			return new QueryProcessor.CommandData
			{
				Command = reader.ReadString(),
				Usage = _Read_System_002EString_005B_005D(reader),
				Description = reader.ReadString(),
				AliasOf = reader.ReadString(),
				Hidden = reader.ReadBool()
			};
		}

		public static void _Write_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus(NetworkWriter writer, DecontaminationController.DecontaminationStatus value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static DecontaminationController.DecontaminationStatus _Read_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus(NetworkReader reader)
		{
			return (DecontaminationController.DecontaminationStatus)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_AdminToys_002EInvisibleInteractableToy_002FColliderShape(NetworkWriter writer, InvisibleInteractableToy.ColliderShape value)
		{
			writer.WriteInt((int)value);
		}

		public static InvisibleInteractableToy.ColliderShape _Read_AdminToys_002EInvisibleInteractableToy_002FColliderShape(NetworkReader reader)
		{
			return (InvisibleInteractableToy.ColliderShape)reader.ReadInt();
		}

		public static void _Write_UnityEngine_002ELightShadows(NetworkWriter writer, LightShadows value)
		{
			writer.WriteInt((int)value);
		}

		public static void _Write_UnityEngine_002ELightType(NetworkWriter writer, LightType value)
		{
			writer.WriteInt((int)value);
		}

		public static void _Write_UnityEngine_002ELightShape(NetworkWriter writer, LightShape value)
		{
			writer.WriteInt((int)value);
		}

		public static LightShadows _Read_UnityEngine_002ELightShadows(NetworkReader reader)
		{
			return (LightShadows)reader.ReadInt();
		}

		public static LightType _Read_UnityEngine_002ELightType(NetworkReader reader)
		{
			return (LightType)reader.ReadInt();
		}

		public static LightShape _Read_UnityEngine_002ELightShape(NetworkReader reader)
		{
			return (LightShape)reader.ReadInt();
		}

		public static void _Write_UnityEngine_002EPrimitiveType(NetworkWriter writer, PrimitiveType value)
		{
			writer.WriteInt((int)value);
		}

		public static void _Write_AdminToys_002EPrimitiveFlags(NetworkWriter writer, PrimitiveFlags value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static PrimitiveType _Read_UnityEngine_002EPrimitiveType(NetworkReader reader)
		{
			return (PrimitiveType)reader.ReadInt();
		}

		public static PrimitiveFlags _Read_AdminToys_002EPrimitiveFlags(NetworkReader reader)
		{
			return (PrimitiveFlags)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_Scp914_002EScp914KnobSetting(NetworkWriter writer, Scp914KnobSetting value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static Scp914KnobSetting _Read_Scp914_002EScp914KnobSetting(NetworkReader reader)
		{
			return (Scp914KnobSetting)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_Interactables_002EInterobjects_002EElevatorGroup(NetworkWriter writer, ElevatorGroup value)
		{
			writer.WriteInt((int)value);
		}

		public static ElevatorGroup _Read_Interactables_002EInterobjects_002EElevatorGroup(NetworkReader reader)
		{
			return (ElevatorGroup)reader.ReadInt();
		}

		public static void _Write_InventorySystem_002EItems_002EItemIdentifier_005B_005D(NetworkWriter writer, ItemIdentifier[] value)
		{
			writer.WriteArray(value);
		}

		public static void _Write_InventorySystem_002EItems_002EItemIdentifier(NetworkWriter writer, ItemIdentifier value)
		{
			_Write_ItemType(writer, value.TypeId);
			writer.WriteUShort(value.SerialNumber);
		}

		public static void _Write_ItemType(NetworkWriter writer, ItemType value)
		{
			writer.WriteInt((int)value);
		}

		public static ItemIdentifier[] _Read_InventorySystem_002EItems_002EItemIdentifier_005B_005D(NetworkReader reader)
		{
			return reader.ReadArray<ItemIdentifier>();
		}

		public static ItemIdentifier _Read_InventorySystem_002EItems_002EItemIdentifier(NetworkReader reader)
		{
			return new ItemIdentifier
			{
				TypeId = _Read_ItemType(reader),
				SerialNumber = reader.ReadUShort()
			};
		}

		public static ItemType _Read_ItemType(NetworkReader reader)
		{
			return (ItemType)reader.ReadInt();
		}

		public static void _Write_System_002EUInt16_005B_005D(NetworkWriter writer, ushort[] value)
		{
			writer.WriteArray(value);
		}

		public static ushort[] _Read_System_002EUInt16_005B_005D(NetworkReader reader)
		{
			return reader.ReadArray<ushort>();
		}

		public static void _Write_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID(NetworkWriter writer, CandyKindID value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static CandyKindID _Read_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID(NetworkReader reader)
		{
			return (CandyKindID)NetworkReaderExtensions.ReadByte(reader);
		}

		public static void _Write_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState(NetworkWriter writer, JailbirdWearState value)
		{
			writer.WriteInt((int)value);
		}

		public static JailbirdWearState _Read_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState(NetworkReader reader)
		{
			return (JailbirdWearState)reader.ReadInt();
		}

		public static void _Write_PlayerRoles_002ETeam(NetworkWriter writer, Team value)
		{
			NetworkWriterExtensions.WriteByte(writer, (byte)value);
		}

		public static Team _Read_PlayerRoles_002ETeam(NetworkReader reader)
		{
			return (Team)NetworkReaderExtensions.ReadByte(reader);
		}

		[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
		public static void InitReadWriters()
		{
			Writer<byte>.write = NetworkWriterExtensions.WriteByte;
			Writer<byte?>.write = NetworkWriterExtensions.WriteByteNullable;
			Writer<sbyte>.write = NetworkWriterExtensions.WriteSByte;
			Writer<sbyte?>.write = NetworkWriterExtensions.WriteSByteNullable;
			Writer<char>.write = NetworkWriterExtensions.WriteChar;
			Writer<char?>.write = NetworkWriterExtensions.WriteCharNullable;
			Writer<bool>.write = NetworkWriterExtensions.WriteBool;
			Writer<bool?>.write = NullableBoolReaderWriter.WriteNullableBool;
			Writer<short>.write = NetworkWriterExtensions.WriteShort;
			Writer<short?>.write = NetworkWriterExtensions.WriteShortNullable;
			Writer<ushort>.write = NetworkWriterExtensions.WriteUShort;
			Writer<ushort?>.write = NetworkWriterExtensions.WriteUShortNullable;
			Writer<int>.write = NetworkWriterExtensions.WriteInt;
			Writer<int?>.write = NetworkWriterExtensions.WriteIntNullable;
			Writer<uint>.write = NetworkWriterExtensions.WriteUInt;
			Writer<uint?>.write = NetworkWriterExtensions.WriteUIntNullable;
			Writer<long>.write = NetworkWriterExtensions.WriteLong;
			Writer<long?>.write = NetworkWriterExtensions.WriteLongNullable;
			Writer<ulong>.write = NetworkWriterExtensions.WriteULong;
			Writer<ulong?>.write = NetworkWriterExtensions.WriteULongNullable;
			Writer<float>.write = NetworkWriterExtensions.WriteFloat;
			Writer<float?>.write = NetworkWriterExtensions.WriteFloatNullable;
			Writer<double>.write = NetworkWriterExtensions.WriteDouble;
			Writer<double?>.write = NetworkWriterExtensions.WriteDoubleNullable;
			Writer<decimal>.write = NetworkWriterExtensions.WriteDecimal;
			Writer<decimal?>.write = NetworkWriterExtensions.WriteDecimalNullable;
			Writer<string>.write = NetworkWriterExtensions.WriteString;
			Writer<byte[]>.write = NetworkWriterExtensions.WriteBytesAndSize;
			Writer<ArraySegment<byte>>.write = NetworkWriterExtensions.WriteArraySegmentAndSize;
			Writer<Vector2>.write = NetworkWriterExtensions.WriteVector2;
			Writer<Vector2?>.write = NetworkWriterExtensions.WriteVector2Nullable;
			Writer<Vector3>.write = NetworkWriterExtensions.WriteVector3;
			Writer<Vector3?>.write = NetworkWriterExtensions.WriteVector3Nullable;
			Writer<Vector4>.write = NetworkWriterExtensions.WriteVector4;
			Writer<Vector4?>.write = NetworkWriterExtensions.WriteVector4Nullable;
			Writer<Vector2Int>.write = NetworkWriterExtensions.WriteVector2Int;
			Writer<Vector2Int?>.write = NetworkWriterExtensions.WriteVector2IntNullable;
			Writer<Vector3Int>.write = NetworkWriterExtensions.WriteVector3Int;
			Writer<Vector3Int?>.write = NetworkWriterExtensions.WriteVector3IntNullable;
			Writer<Color>.write = NetworkWriterExtensions.WriteColor;
			Writer<Color?>.write = NetworkWriterExtensions.WriteColorNullable;
			Writer<Color32>.write = NetworkWriterExtensions.WriteColor32;
			Writer<Color32?>.write = NetworkWriterExtensions.WriteColor32Nullable;
			Writer<Quaternion>.write = NetworkWriterExtensions.WriteQuaternion;
			Writer<Quaternion?>.write = NetworkWriterExtensions.WriteQuaternionNullable;
			Writer<Rect>.write = NetworkWriterExtensions.WriteRect;
			Writer<Rect?>.write = NetworkWriterExtensions.WriteRectNullable;
			Writer<Plane>.write = NetworkWriterExtensions.WritePlane;
			Writer<Plane?>.write = NetworkWriterExtensions.WritePlaneNullable;
			Writer<Ray>.write = NetworkWriterExtensions.WriteRay;
			Writer<Ray?>.write = NetworkWriterExtensions.WriteRayNullable;
			Writer<Matrix4x4>.write = NetworkWriterExtensions.WriteMatrix4x4;
			Writer<Matrix4x4?>.write = NetworkWriterExtensions.WriteMatrix4x4Nullable;
			Writer<Guid>.write = NetworkWriterExtensions.WriteGuid;
			Writer<Guid?>.write = NetworkWriterExtensions.WriteGuidNullable;
			Writer<NetworkIdentity>.write = NetworkWriterExtensions.WriteNetworkIdentity;
			Writer<NetworkBehaviour>.write = NetworkWriterExtensions.WriteNetworkBehaviour;
			Writer<Transform>.write = NetworkWriterExtensions.WriteTransform;
			Writer<GameObject>.write = NetworkWriterExtensions.WriteGameObject;
			Writer<Uri>.write = NetworkWriterExtensions.WriteUri;
			Writer<Texture2D>.write = NetworkWriterExtensions.WriteTexture2D;
			Writer<Sprite>.write = NetworkWriterExtensions.WriteSprite;
			Writer<DateTime>.write = NetworkWriterExtensions.WriteDateTime;
			Writer<DateTime?>.write = NetworkWriterExtensions.WriteDateTimeNullable;
			Writer<TimeSnapshotMessage>.write = _Write_Mirror_002ETimeSnapshotMessage;
			Writer<ReadyMessage>.write = _Write_Mirror_002EReadyMessage;
			Writer<NotReadyMessage>.write = _Write_Mirror_002ENotReadyMessage;
			Writer<AddPlayerMessage>.write = _Write_Mirror_002EAddPlayerMessage;
			Writer<SceneMessage>.write = _Write_Mirror_002ESceneMessage;
			Writer<SceneOperation>.write = _Write_Mirror_002ESceneOperation;
			Writer<CommandMessage>.write = _Write_Mirror_002ECommandMessage;
			Writer<RpcMessage>.write = _Write_Mirror_002ERpcMessage;
			Writer<SpawnMessage>.write = _Write_Mirror_002ESpawnMessage;
			Writer<ChangeOwnerMessage>.write = _Write_Mirror_002EChangeOwnerMessage;
			Writer<ObjectSpawnStartedMessage>.write = _Write_Mirror_002EObjectSpawnStartedMessage;
			Writer<ObjectSpawnFinishedMessage>.write = _Write_Mirror_002EObjectSpawnFinishedMessage;
			Writer<ObjectDestroyMessage>.write = _Write_Mirror_002EObjectDestroyMessage;
			Writer<ObjectHideMessage>.write = _Write_Mirror_002EObjectHideMessage;
			Writer<EntityStateMessage>.write = _Write_Mirror_002EEntityStateMessage;
			Writer<NetworkPingMessage>.write = _Write_Mirror_002ENetworkPingMessage;
			Writer<NetworkPongMessage>.write = _Write_Mirror_002ENetworkPongMessage;
			Writer<AlphaWarheadSyncInfo>.write = AlphaWarheadSyncInfoSerializer.WriteAlphaWarheadSyncInfo;
			Writer<RecyclablePlayerId>.write = RecyclablePlayerIdReaderWriter.WriteRecyclablePlayerId;
			Writer<ServerConfigSynchronizer.AmmoLimit>.write = AmmoLimitSerializer.WriteAmmoLimit;
			Writer<TeslaHitMsg>.write = TeslaHitMsgSerializers.Serialize;
			Writer<EncryptedChannelManager.EncryptedMessageOutside>.write = EncryptedChannelFunctions.SerializeEncryptedMessageOutside;
			Writer<Offset>.write = OffsetSerializer.WriteOffset;
			Writer<LowPrecisionQuaternion>.write = LowPrecisionQuaternionSerializer.WriteLowPrecisionQuaternion;
			Writer<bool[]>.write = Misc.WriteBoolArray;
			Writer<SSSEntriesPack>.write = SSSNetworkMessageFunctions.SerializeSSSEntriesPack;
			Writer<SSSClientResponse>.write = SSSNetworkMessageFunctions.SerializeSSSClientResponse;
			Writer<SSSUserStatusReport>.write = SSSNetworkMessageFunctions.SerializeSSSVersionSelfReport;
			Writer<SSSUpdateMessage>.write = SSSNetworkMessageFunctions.SerializeSSSUpdateMessage;
			Writer<AudioMessage>.write = AudioMessageReadersWriters.SerializeVoiceMessage;
			Writer<VoiceMessage>.write = VoiceMessageReadersWriters.SerializeVoiceMessage;
			Writer<SubtitleMessage>.write = SubtitleMessageExtensions.WriteSubtitleMessage;
			Writer<RoundRestartMessage>.write = RoundRestartMessageReaderWriter.WriteRoundRestartMessage;
			Writer<RelativePosition>.write = RelativePositionSerialization.WriteRelativePosition;
			Writer<DamageHandlerBase>.write = DamageHandlerReaderWriter.WriteDamageHandler;
			Writer<SyncedStatMessages.StatMessage>.write = SyncedStatMessages.Serialize;
			Writer<RoleTypeId>.write = PlayerRoleEnumsReadersWriters.WriteRoleType;
			Writer<RoleSyncInfo>.write = PlayerRolesNetUtils.WriteRoleSyncInfo;
			Writer<RoleSyncInfoPack>.write = PlayerRolesNetUtils.WriteRoleSyncInfoPack;
			Writer<SubroutineMessage>.write = SubroutineMessageReaderWriter.WriteSubroutineMessage;
			Writer<SpectatableVisibilityMessages.SpectatableVisibilityMessage>.write = SpectatableVisibilityMessages.Serialize;
			Writer<SpectatorSpawnReason>.write = SpectatorSpawnReasonReaderWriter.WriteSpawnReason;
			Writer<ScpSpawnPreferences.SpawnPreferences>.write = ScpSpawnPreferences.WriteSpawnPreferences;
			Writer<RagdollData>.write = RagdollDataReaderWriter.WriteRagdollData;
			Writer<SyncedGravityMessages.GravityMessage>.write = SyncedGravityMessages.Serialize;
			Writer<SyncedScaleMessages.ScaleMessage>.write = SyncedScaleMessages.Serialize;
			Writer<FpcJumpMessages.FpcForceJumpMessage>.write = FpcJumpMessages.Serialize;
			Writer<FpcFromClientMessage>.write = FpcMessagesReadersWriters.WriteFpcFromClientMessage;
			Writer<FpcPositionMessage>.write = FpcMessagesReadersWriters.WriteFpcPositionMessage;
			Writer<FpcPositionOverrideMessage>.write = FpcMessagesReadersWriters.WriteFpcRotationOverrideMessage;
			Writer<FpcFallDamageMessage>.write = FpcMessagesReadersWriters.WriteFpcFallDamageMessage;
			Writer<SubcontrollerRpcHandler.SubcontrollerRpcMessage>.write = SubcontrollerRpcHandler.WriteSubcontrollerRpcMessage;
			Writer<WearableSyncMessage>.write = WearableSyncMessageReaderWriterFunc.WriteWearableSyncMessage;
			Writer<AnimationCurve>.write = AnimationCurveReaderWriter.WriteAnimationCurve;
			Writer<IReadOnlyCollection<HintEffect>>.write = HintEffectArrayReaderWriter.WriteHintEffectArray;
			Writer<HintEffect>.write = HintEffectReaderWriter.WriteHintEffect;
			Writer<IReadOnlyCollection<HintParameter>>.write = HintParameterArrayReaderWriter.WriteHintParameterArray;
			Writer<HintParameter>.write = HintParameterReaderWriter.WriteHintParameter;
			Writer<Hint>.write = HintReaderWriter.WriteHint;
			Writer<ReferenceHub>.write = ReferenceHubReaderWriter.WriteReferenceHub;
			Writer<AlphaCurveHintEffect>.write = AlphaCurveHintEffectFunctions.Serialize;
			Writer<AlphaEffect>.write = AlphaEffectFunctions.Serialize;
			Writer<OutlineEffect>.write = OutlineEffectFunctions.Serialize;
			Writer<TextHint>.write = TextHintFunctions.Serialize;
			Writer<TranslationHint>.write = TranslationHintFunctions.Serialize;
			Writer<AmmoHintParameter>.write = AmmoHintParameterFunctions.Serialize;
			Writer<Scp330HintParameter>.write = Scp330HintParameterFunctions.Serialize;
			Writer<ItemCategoryHintParameter>.write = ItemCategoryHintParameterFunctions.Serialize;
			Writer<ItemHintParameter>.write = ItemHintParameterFunctions.Serialize;
			Writer<AnimationCurveHintParameter>.write = AnimationCurveHintParameterFunctions.Serialize;
			Writer<ByteHintParameter>.write = ByteHintParameterFunctions.Serialize;
			Writer<DoubleHintParameter>.write = DoubleHintParameterFunctions.Serialize;
			Writer<FloatHintParameter>.write = FloatHintParameterFunctions.Serialize;
			Writer<IntHintParameter>.write = IntHintParameterFunctions.Serialize;
			Writer<LongHintParameter>.write = LongHintParameterFunctions.Serialize;
			Writer<PackedLongHintParameter>.write = PackedLongHintParameterFunctions.Serialize;
			Writer<PackedULongHintParameter>.write = PackedULongHintParameterFunctions.Serialize;
			Writer<SByteHintParameter>.write = SByteHintParameterFunctions.Serialize;
			Writer<ShortHintParameter>.write = ShortHintParameterFunctions.Serialize;
			Writer<SSKeybindHintParameter>.write = ServerSettingKeybindHintParameterFunctions.Serialize;
			Writer<StringHintParameter>.write = StringHintParameterFunctions.Serialize;
			Writer<TimespanHintParameter>.write = TimespanHintParameterFunctions.Serialize;
			Writer<UIntHintParameter>.write = UIntHintParameterFunctions.Serialize;
			Writer<ULongHintParameter>.write = ULongHintParameterFunctions.Serialize;
			Writer<UShortHintParameter>.write = UShortHintParameterFunctions.Serialize;
			Writer<HintMessage>.write = HintMessageParameterFunctions.Serialize;
			Writer<ObjectiveCompletionMessage>.write = ObjectiveCompletionMessageUtility.WriteCompletionMessage;
			Writer<WaveUpdateMessage>.write = WaveUpdateMessageUtility.WriteUpdateMessage;
			Writer<SpawnableWaveBase>.write = WaveUtils.WriteWave;
			Writer<UnitNameMessage>.write = UnitNameMessageHandler.WriteUnitName;
			Writer<DrawableLineMessage>.write = DrawableLineMessageHandler.Serialize;
			Writer<DecalCleanupMessage>.write = DecalCleanupMessageExtensions.WriteDecalCleanupMessage;
			Writer<AuthenticationResponse>.write = AuthenticationResponseFunctions.SerializeAuthenticationResponse;
			Writer<CassieTtsPayload>.write = CassieTtsPayloadReadersWriters.WriteCassieTtsPayload;
			Writer<RoomIdentifier>.write = RoomReaderWriters.WriteRoomIdentifier;
			Writer<SearchInvalidation>.write = SearchInvalidationFunctions.Serialize;
			Writer<SearchRequest>.write = SearchRequestFunctions.Serialize;
			Writer<SearchSession>.write = SearchSessionFunctions.Serialize;
			Writer<DisarmedPlayersListMessage>.write = DisarmedPlayersListMessageSerializers.Serialize;
			Writer<DisarmMessage>.write = DisarmMessageSerializers.Serialize;
			Writer<PickupSyncInfo>.write = PickupSyncInfoSerializer.WritePickupSyncInfo;
			Writer<StatusMessage>.write = StatusMessageFunctions.Serialize;
			Writer<ItemCooldownMessage>.write = ItemCooldownMessageFunctions.Serialize;
			Writer<SyncScp330Message>.write = Scp330NetworkHandler.SerializeSyncMessage;
			Writer<SelectScp330Message>.write = Scp330NetworkHandler.SerializeSelectMessage;
			Writer<FlashlightNetworkHandler.FlashlightMessage>.write = FlashlightNetworkHandler.Serialize;
			Writer<RadioStatusMessage>.write = RadioMessages.WriteRadioStatusMessage;
			Writer<ClientRadioCommandMessage>.write = RadioMessages.WriteClientRadioCommandMessage;
			Writer<KeycardDetailSynchronizer.DetailsSyncMsg>.write = KeycardDetailSynchronizer.SerializeDetailsSyncMsg;
			Writer<ShotBacktrackData>.write = ShotBacktrackDataSerializer.WriteBacktrackData;
			Writer<AttachmentCodeSync.AttachmentCodeMessage>.write = AttachmentCodeSync.WriteAttachmentCodeMessage;
			Writer<AttachmentCodeSync.AttachmentCodePackMessage>.write = AttachmentCodeSync.WriteAttachmentCodePackMessage;
			Writer<AttachmentsChangeRequest>.write = AttachmentsMessageSerializers.WriteAttachmentsChangeRequest;
			Writer<AttachmentsSetupPreference>.write = AttachmentsMessageSerializers.WriteAttachmentsSetupPreference;
			Writer<ReserveAmmoSync.ReserveAmmoMessage>.write = ReserveAmmoSync.WriteReserveAmmoMessage;
			Writer<AutosyncMessage>.write = AutosyncMessageHandler.WriteAutosyncMessage;
			Writer<Enum>.write = AutosyncMessageUtils.WriteSubheader;
			Writer<ThrowableNetworkHandler.ThrowableItemRequestMessage>.write = ThrowableNetworkHandler.SerializeRequestMsg;
			Writer<ThrowableNetworkHandler.ThrowableItemAudioMessage>.write = ThrowableNetworkHandler.SerializeAudioMsg;
			Writer<ThrowableNetworkHandler.ThrowableItemCancellationMessage>.write = ThrowableNetworkHandler.SerializeCancellationMsg;
			Writer<DeadmanSwitch.DeadMansSequenceActiveMessage>.write = _Write_DeadmanSwitch_002FDeadMansSequenceActiveMessage;
			Writer<Hitmarker.HitmarkerMessage>.write = _Write_Hitmarker_002FHitmarkerMessage;
			Writer<HitmarkerType>.write = _Write_HitmarkerType;
			Writer<Escape.EscapeMessage>.write = _Write_Escape_002FEscapeMessage;
			Writer<ServerShutdown.ServerShutdownMessage>.write = _Write_ServerShutdown_002FServerShutdownMessage;
			Writer<VoiceChatMuteIndicator.SyncMuteMessage>.write = _Write_VoiceChat_002EVoiceChatMuteIndicator_002FSyncMuteMessage;
			Writer<VoiceChatPrivacySettings.VcPrivacyMessage>.write = _Write_VoiceChat_002EVoiceChatPrivacySettings_002FVcPrivacyMessage;
			Writer<PersonalRadioPlayback.TransmitterPositionMessage>.write = _Write_VoiceChat_002EPlaybacks_002EPersonalRadioPlayback_002FTransmitterPositionMessage;
			Writer<LockerWaypoint.LockerWaypointAssignMessage>.write = _Write_RelativePositioning_002ELockerWaypoint_002FLockerWaypointAssignMessage;
			Writer<VoiceChatReceivePrefs.GroupMuteFlagsMessage>.write = _Write_PlayerRoles_002EVoice_002EVoiceChatReceivePrefs_002FGroupMuteFlagsMessage;
			Writer<OverwatchSettingsController.OverwatchSettingsInfoMessage>.write = _Write_PlayerRoles_002ESpectating_002EOverwatchSettingsController_002FOverwatchSettingsInfoMessage;
			Writer<SpectatorNetworking.SpectatedNetIdSyncMessage>.write = _Write_PlayerRoles_002ESpectating_002ESpectatorNetworking_002FSpectatedNetIdSyncMessage;
			Writer<Scp106PocketItemManager.WarningMessage>.write = _Write_PlayerRoles_002EPlayableScps_002EScp106_002EScp106PocketItemManager_002FWarningMessage;
			Writer<ZombieConfirmationBox.ScpReviveBlockMessage>.write = _Write_PlayerRoles_002EPlayableScps_002EScp049_002EZombies_002EZombieConfirmationBox_002FScpReviveBlockMessage;
			Writer<DynamicHumeShieldController.ShieldBreakMessage>.write = _Write_PlayerRoles_002EPlayableScps_002EHumeShield_002EDynamicHumeShieldController_002FShieldBreakMessage;
			Writer<FpcRotationOverrideMessage>.write = _Write_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcRotationOverrideMessage;
			Writer<FpcNoclipToggleMessage>.write = _Write_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcNoclipToggleMessage;
			Writer<EmotionSync.EmotionSyncMessage>.write = _Write_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionSync_002FEmotionSyncMessage;
			Writer<EmotionPresetType>.write = _Write_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionPresetType;
			Writer<ExplosionUtils.GrenadeExplosionMessage>.write = _Write_Utils_002EExplosionUtils_002FGrenadeExplosionMessage;
			Writer<SeedSynchronizer.SeedMessage>.write = _Write_MapGeneration_002ESeedSynchronizer_002FSeedMessage;
			Writer<CustomPlayerEffects.AntiScp207.BreakMessage>.write = _Write_CustomPlayerEffects_002EAntiScp207_002FBreakMessage;
			Writer<Prismatic.BreakMessage>.write = _Write_CustomPlayerEffects_002EPrismatic_002FBreakMessage;
			Writer<GhostlyWalkThroughMessage>.write = _Write_CustomPlayerEffects_002EGhostlyWalkThroughMessage;
			Writer<InfluenceUpdateMessage>.write = _Write_Respawning_002EInfluenceUpdateMessage;
			Writer<Faction>.write = _Write_PlayerRoles_002EFaction;
			Writer<StripdownNetworking.StripdownResponse>.write = _Write_CommandSystem_002ECommands_002ERemoteAdmin_002EStripdown_002EStripdownNetworking_002FStripdownResponse;
			Writer<string[]>.write = _Write_System_002EString_005B_005D;
			Writer<AchievementManager.AchievementMessage>.write = _Write_Achievements_002EAchievementManager_002FAchievementMessage;
			Writer<HumeShieldSubEffect.HumeBlockMsg>.write = _Write_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHumeShieldSubEffect_002FHumeBlockMsg;
			Writer<Hypothermia.ForcedHypothermiaMessage>.write = _Write_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHypothermia_002FForcedHypothermiaMessage;
			Writer<Scp1576SpectatorWarningHandler.SpectatorWarningMessage>.write = _Write_InventorySystem_002EItems_002EUsables_002EScp1576_002EScp1576SpectatorWarningHandler_002FSpectatorWarningMessage;
			Writer<Scp1344StatusMessage>.write = _Write_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344StatusMessage;
			Writer<Scp1344Status>.write = _Write_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344Status;
			Writer<DamageIndicatorMessage>.write = _Write_InventorySystem_002EItems_002EFirearms_002EBasicMessages_002EDamageIndicatorMessage;
			Writer<DoorPermissionFlags>.write = _Write_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags;
			Writer<ServerConfigSynchronizer.PredefinedBanTemplate>.write = _Write_ServerConfigSynchronizer_002FPredefinedBanTemplate;
			Writer<Broadcast.BroadcastFlags>.write = _Write_Broadcast_002FBroadcastFlags;
			Writer<KeyCode>.write = _Write_UnityEngine_002EKeyCode;
			Writer<PlayerInfoArea>.write = _Write_PlayerInfoArea;
			Writer<RoundSummary.SumInfo_ClassList>.write = _Write_RoundSummary_002FSumInfo_ClassList;
			Writer<RoundSummary.LeadingTeam>.write = _Write_RoundSummary_002FLeadingTeam;
			Writer<ServerRoles.BadgePreferences>.write = _Write_ServerRoles_002FBadgePreferences;
			Writer<ServerRoles.BadgeVisibilityPreferences>.write = _Write_ServerRoles_002FBadgeVisibilityPreferences;
			Writer<QueryProcessor.CommandData[]>.write = _Write_RemoteAdmin_002EQueryProcessor_002FCommandData_005B_005D;
			Writer<QueryProcessor.CommandData>.write = _Write_RemoteAdmin_002EQueryProcessor_002FCommandData;
			Writer<DecontaminationController.DecontaminationStatus>.write = _Write_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus;
			Writer<InvisibleInteractableToy.ColliderShape>.write = _Write_AdminToys_002EInvisibleInteractableToy_002FColliderShape;
			Writer<LightShadows>.write = _Write_UnityEngine_002ELightShadows;
			Writer<LightType>.write = _Write_UnityEngine_002ELightType;
			Writer<LightShape>.write = _Write_UnityEngine_002ELightShape;
			Writer<PrimitiveType>.write = _Write_UnityEngine_002EPrimitiveType;
			Writer<PrimitiveFlags>.write = _Write_AdminToys_002EPrimitiveFlags;
			Writer<Scp914KnobSetting>.write = _Write_Scp914_002EScp914KnobSetting;
			Writer<ElevatorGroup>.write = _Write_Interactables_002EInterobjects_002EElevatorGroup;
			Writer<ItemIdentifier[]>.write = _Write_InventorySystem_002EItems_002EItemIdentifier_005B_005D;
			Writer<ItemIdentifier>.write = _Write_InventorySystem_002EItems_002EItemIdentifier;
			Writer<ItemType>.write = _Write_ItemType;
			Writer<ushort[]>.write = _Write_System_002EUInt16_005B_005D;
			Writer<CandyKindID>.write = _Write_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID;
			Writer<JailbirdWearState>.write = _Write_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState;
			Writer<Team>.write = _Write_PlayerRoles_002ETeam;
			Reader<byte>.read = NetworkReaderExtensions.ReadByte;
			Reader<byte?>.read = NetworkReaderExtensions.ReadByteNullable;
			Reader<sbyte>.read = NetworkReaderExtensions.ReadSByte;
			Reader<sbyte?>.read = NetworkReaderExtensions.ReadSByteNullable;
			Reader<char>.read = NetworkReaderExtensions.ReadChar;
			Reader<char?>.read = NetworkReaderExtensions.ReadCharNullable;
			Reader<bool>.read = NetworkReaderExtensions.ReadBool;
			Reader<bool?>.read = NullableBoolReaderWriter.ReadNullableBool;
			Reader<short>.read = NetworkReaderExtensions.ReadShort;
			Reader<short?>.read = NetworkReaderExtensions.ReadShortNullable;
			Reader<ushort>.read = NetworkReaderExtensions.ReadUShort;
			Reader<ushort?>.read = NetworkReaderExtensions.ReadUShortNullable;
			Reader<int>.read = NetworkReaderExtensions.ReadInt;
			Reader<int?>.read = NetworkReaderExtensions.ReadIntNullable;
			Reader<uint>.read = NetworkReaderExtensions.ReadUInt;
			Reader<uint?>.read = NetworkReaderExtensions.ReadUIntNullable;
			Reader<long>.read = NetworkReaderExtensions.ReadLong;
			Reader<long?>.read = NetworkReaderExtensions.ReadLongNullable;
			Reader<ulong>.read = NetworkReaderExtensions.ReadULong;
			Reader<ulong?>.read = NetworkReaderExtensions.ReadULongNullable;
			Reader<float>.read = NetworkReaderExtensions.ReadFloat;
			Reader<float?>.read = NetworkReaderExtensions.ReadFloatNullable;
			Reader<double>.read = NetworkReaderExtensions.ReadDouble;
			Reader<double?>.read = NetworkReaderExtensions.ReadDoubleNullable;
			Reader<decimal>.read = NetworkReaderExtensions.ReadDecimal;
			Reader<decimal?>.read = NetworkReaderExtensions.ReadDecimalNullable;
			Reader<string>.read = NetworkReaderExtensions.ReadString;
			Reader<byte[]>.read = NetworkReaderExtensions.ReadBytesAndSize;
			Reader<ArraySegment<byte>>.read = NetworkReaderExtensions.ReadArraySegmentAndSize;
			Reader<Vector2>.read = NetworkReaderExtensions.ReadVector2;
			Reader<Vector2?>.read = NetworkReaderExtensions.ReadVector2Nullable;
			Reader<Vector3>.read = NetworkReaderExtensions.ReadVector3;
			Reader<Vector3?>.read = NetworkReaderExtensions.ReadVector3Nullable;
			Reader<Vector4>.read = NetworkReaderExtensions.ReadVector4;
			Reader<Vector4?>.read = NetworkReaderExtensions.ReadVector4Nullable;
			Reader<Vector2Int>.read = NetworkReaderExtensions.ReadVector2Int;
			Reader<Vector2Int?>.read = NetworkReaderExtensions.ReadVector2IntNullable;
			Reader<Vector3Int>.read = NetworkReaderExtensions.ReadVector3Int;
			Reader<Vector3Int?>.read = NetworkReaderExtensions.ReadVector3IntNullable;
			Reader<Color>.read = NetworkReaderExtensions.ReadColor;
			Reader<Color?>.read = NetworkReaderExtensions.ReadColorNullable;
			Reader<Color32>.read = NetworkReaderExtensions.ReadColor32;
			Reader<Color32?>.read = NetworkReaderExtensions.ReadColor32Nullable;
			Reader<Quaternion>.read = NetworkReaderExtensions.ReadQuaternion;
			Reader<Quaternion?>.read = NetworkReaderExtensions.ReadQuaternionNullable;
			Reader<Rect>.read = NetworkReaderExtensions.ReadRect;
			Reader<Rect?>.read = NetworkReaderExtensions.ReadRectNullable;
			Reader<Plane>.read = NetworkReaderExtensions.ReadPlane;
			Reader<Plane?>.read = NetworkReaderExtensions.ReadPlaneNullable;
			Reader<Ray>.read = NetworkReaderExtensions.ReadRay;
			Reader<Ray?>.read = NetworkReaderExtensions.ReadRayNullable;
			Reader<Matrix4x4>.read = NetworkReaderExtensions.ReadMatrix4x4;
			Reader<Matrix4x4?>.read = NetworkReaderExtensions.ReadMatrix4x4Nullable;
			Reader<Guid>.read = NetworkReaderExtensions.ReadGuid;
			Reader<Guid?>.read = NetworkReaderExtensions.ReadGuidNullable;
			Reader<NetworkIdentity>.read = NetworkReaderExtensions.ReadNetworkIdentity;
			Reader<NetworkBehaviour>.read = NetworkReaderExtensions.ReadNetworkBehaviour;
			Reader<NetworkBehaviourSyncVar>.read = NetworkReaderExtensions.ReadNetworkBehaviourSyncVar;
			Reader<Transform>.read = NetworkReaderExtensions.ReadTransform;
			Reader<GameObject>.read = NetworkReaderExtensions.ReadGameObject;
			Reader<Uri>.read = NetworkReaderExtensions.ReadUri;
			Reader<Texture2D>.read = NetworkReaderExtensions.ReadTexture2D;
			Reader<Sprite>.read = NetworkReaderExtensions.ReadSprite;
			Reader<DateTime>.read = NetworkReaderExtensions.ReadDateTime;
			Reader<DateTime?>.read = NetworkReaderExtensions.ReadDateTimeNullable;
			Reader<TimeSnapshotMessage>.read = _Read_Mirror_002ETimeSnapshotMessage;
			Reader<ReadyMessage>.read = _Read_Mirror_002EReadyMessage;
			Reader<NotReadyMessage>.read = _Read_Mirror_002ENotReadyMessage;
			Reader<AddPlayerMessage>.read = _Read_Mirror_002EAddPlayerMessage;
			Reader<SceneMessage>.read = _Read_Mirror_002ESceneMessage;
			Reader<SceneOperation>.read = _Read_Mirror_002ESceneOperation;
			Reader<CommandMessage>.read = _Read_Mirror_002ECommandMessage;
			Reader<RpcMessage>.read = _Read_Mirror_002ERpcMessage;
			Reader<SpawnMessage>.read = _Read_Mirror_002ESpawnMessage;
			Reader<ChangeOwnerMessage>.read = _Read_Mirror_002EChangeOwnerMessage;
			Reader<ObjectSpawnStartedMessage>.read = _Read_Mirror_002EObjectSpawnStartedMessage;
			Reader<ObjectSpawnFinishedMessage>.read = _Read_Mirror_002EObjectSpawnFinishedMessage;
			Reader<ObjectDestroyMessage>.read = _Read_Mirror_002EObjectDestroyMessage;
			Reader<ObjectHideMessage>.read = _Read_Mirror_002EObjectHideMessage;
			Reader<EntityStateMessage>.read = _Read_Mirror_002EEntityStateMessage;
			Reader<NetworkPingMessage>.read = _Read_Mirror_002ENetworkPingMessage;
			Reader<NetworkPongMessage>.read = _Read_Mirror_002ENetworkPongMessage;
			Reader<AlphaWarheadSyncInfo>.read = AlphaWarheadSyncInfoSerializer.ReadAlphaWarheadSyncInfo;
			Reader<RecyclablePlayerId>.read = RecyclablePlayerIdReaderWriter.ReadRecyclablePlayerId;
			Reader<ServerConfigSynchronizer.AmmoLimit>.read = AmmoLimitSerializer.ReadAmmoLimit;
			Reader<TeslaHitMsg>.read = TeslaHitMsgSerializers.Deserialize;
			Reader<EncryptedChannelManager.EncryptedMessageOutside>.read = EncryptedChannelFunctions.DeserializeEncryptedMessageOutside;
			Reader<Offset>.read = OffsetSerializer.ReadOffset;
			Reader<LowPrecisionQuaternion>.read = LowPrecisionQuaternionSerializer.ReadLowPrecisionQuaternion;
			Reader<SSSEntriesPack>.read = SSSNetworkMessageFunctions.DeserializeSSSEntriesPack;
			Reader<SSSClientResponse>.read = SSSNetworkMessageFunctions.DeserializeSSSClientResponse;
			Reader<SSSUserStatusReport>.read = SSSNetworkMessageFunctions.DeserializeSSSVersionSelfReport;
			Reader<SSSUpdateMessage>.read = SSSNetworkMessageFunctions.DeserializeSSSUpdateMessage;
			Reader<AudioMessage>.read = AudioMessageReadersWriters.DeserializeVoiceMessage;
			Reader<VoiceMessage>.read = VoiceMessageReadersWriters.DeserializeVoiceMessage;
			Reader<SubtitleMessage>.read = SubtitleMessageExtensions.ReadSubtitleMessage;
			Reader<RoundRestartMessage>.read = RoundRestartMessageReaderWriter.ReadRoundRestartMessage;
			Reader<RelativePosition>.read = RelativePositionSerialization.ReadRelativePosition;
			Reader<DamageHandlerBase>.read = DamageHandlerReaderWriter.ReadDamageHandler;
			Reader<SyncedStatMessages.StatMessage>.read = SyncedStatMessages.Deserialize;
			Reader<RoleTypeId>.read = PlayerRoleEnumsReadersWriters.ReadRoleType;
			Reader<RoleSyncInfo>.read = PlayerRolesNetUtils.ReadRoleSyncInfo;
			Reader<RoleSyncInfoPack>.read = PlayerRolesNetUtils.ReadRoleSyncInfoPack;
			Reader<SubroutineMessage>.read = SubroutineMessageReaderWriter.ReadSubroutineMessage;
			Reader<SpectatableVisibilityMessages.SpectatableVisibilityMessage>.read = SpectatableVisibilityMessages.Deserialize;
			Reader<SpectatorSpawnReason>.read = SpectatorSpawnReasonReaderWriter.ReadSpawnReason;
			Reader<ScpSpawnPreferences.SpawnPreferences>.read = ScpSpawnPreferences.ReadSpawnPreferences;
			Reader<RagdollData>.read = RagdollDataReaderWriter.ReadRagdollData;
			Reader<SyncedGravityMessages.GravityMessage>.read = SyncedGravityMessages.Deserialize;
			Reader<SyncedScaleMessages.ScaleMessage>.read = SyncedScaleMessages.Deserialize;
			Reader<FpcJumpMessages.FpcForceJumpMessage>.read = FpcJumpMessages.Deserialize;
			Reader<FpcFromClientMessage>.read = FpcMessagesReadersWriters.ReadFpcFromClientMessage;
			Reader<FpcPositionMessage>.read = FpcMessagesReadersWriters.ReadFpcPositionMessage;
			Reader<FpcPositionOverrideMessage>.read = FpcMessagesReadersWriters.ReadFpcRotationOverrideMessage;
			Reader<FpcFallDamageMessage>.read = FpcMessagesReadersWriters.ReadFpcFallDamageMessage;
			Reader<SubcontrollerRpcHandler.SubcontrollerRpcMessage>.read = SubcontrollerRpcHandler.ReadSubcontrollerRpcMessage;
			Reader<WearableSyncMessage>.read = WearableSyncMessageReaderWriterFunc.ReadWearableSyncMessage;
			Reader<AnimationCurve>.read = AnimationCurveReaderWriter.ReadAnimationCurve;
			Reader<HintEffect[]>.read = HintEffectArrayReaderWriter.ReadHintEffectArray;
			Reader<HintEffect>.read = HintEffectReaderWriter.ReadHintEffect;
			Reader<HintParameter[]>.read = HintParameterArrayReaderWriter.ReadHintParameterArray;
			Reader<HintParameter>.read = HintParameterReaderWriter.ReadHintParameter;
			Reader<Hint>.read = HintReaderWriter.ReadHint;
			Reader<ReferenceHub>.read = ReferenceHubReaderWriter.ReadReferenceHub;
			Reader<AlphaCurveHintEffect>.read = AlphaCurveHintEffectFunctions.Deserialize;
			Reader<AlphaEffect>.read = AlphaEffectFunctions.Deserialize;
			Reader<OutlineEffect>.read = OutlineEffectFunctions.Deserialize;
			Reader<TextHint>.read = TextHintFunctions.Deserialize;
			Reader<TranslationHint>.read = TranslationHintFunctions.Deserialize;
			Reader<AmmoHintParameter>.read = AmmoHintParameterFunctions.Deserialize;
			Reader<Scp330HintParameter>.read = Scp330HintParameterFunctions.Deserialize;
			Reader<ItemCategoryHintParameter>.read = ItemCategoryHintParameterFunctions.Deserialize;
			Reader<ItemHintParameter>.read = ItemHintParameterFunctions.Deserialize;
			Reader<AnimationCurveHintParameter>.read = AnimationCurveHintParameterFunctions.Deserialize;
			Reader<ByteHintParameter>.read = ByteHintParameterFunctions.Deserialize;
			Reader<DoubleHintParameter>.read = DoubleHintParameterFunctions.Deserialize;
			Reader<FloatHintParameter>.read = FloatHintParameterFunctions.Deserialize;
			Reader<IntHintParameter>.read = IntHintParameterFunctions.Deserialize;
			Reader<LongHintParameter>.read = LongHintParameterFunctions.Deserialize;
			Reader<PackedLongHintParameter>.read = PackedLongHintParameterFunctions.Deserialize;
			Reader<PackedULongHintParameter>.read = PackedULongHintParameterFunctions.Deserialize;
			Reader<SByteHintParameter>.read = SByteHintParameterFunctions.Deserialize;
			Reader<ShortHintParameter>.read = ShortHintParameterFunctions.Deserialize;
			Reader<SSKeybindHintParameter>.read = ServerSettingKeybindHintParameterFunctions.Deserialize;
			Reader<StringHintParameter>.read = StringHintParameterFunctions.Deserialize;
			Reader<TimespanHintParameter>.read = TimespanHintParameterFunctions.Deserialize;
			Reader<UIntHintParameter>.read = UIntHintParameterFunctions.Deserialize;
			Reader<ULongHintParameter>.read = ULongHintParameterFunctions.Deserialize;
			Reader<UShortHintParameter>.read = UShortHintParameterFunctions.Deserialize;
			Reader<HintMessage>.read = HintMessageParameterFunctions.Deserialize;
			Reader<ObjectiveCompletionMessage>.read = ObjectiveCompletionMessageUtility.ReadCompletionMessage;
			Reader<WaveUpdateMessage>.read = WaveUpdateMessageUtility.ReadUpdateMessage;
			Reader<UnitNameMessage>.read = UnitNameMessageHandler.ReadUnitName;
			Reader<DrawableLineMessage>.read = DrawableLineMessageHandler.Deserialize;
			Reader<DecalCleanupMessage>.read = DecalCleanupMessageExtensions.ReadRadioStatusMessage;
			Reader<AuthenticationResponse>.read = AuthenticationResponseFunctions.DeserializeAuthenticationResponse;
			Reader<CassieTtsPayload>.read = CassieTtsPayloadReadersWriters.ReadCassieTtsPayload;
			Reader<RoomIdentifier>.read = RoomReaderWriters.ReadRoomIdentifier;
			Reader<SearchInvalidation>.read = SearchInvalidationFunctions.Deserialize;
			Reader<SearchRequest>.read = SearchRequestFunctions.Deserialize;
			Reader<SearchSession>.read = SearchSessionFunctions.Deserialize;
			Reader<DisarmedPlayersListMessage>.read = DisarmedPlayersListMessageSerializers.Deserialize;
			Reader<DisarmMessage>.read = DisarmMessageSerializers.Deserialize;
			Reader<PickupSyncInfo>.read = PickupSyncInfoSerializer.ReadPickupSyncInfo;
			Reader<StatusMessage>.read = StatusMessageFunctions.Deserialize;
			Reader<ItemCooldownMessage>.read = ItemCooldownMessageFunctions.Deserialize;
			Reader<SyncScp330Message>.read = Scp330NetworkHandler.DeserializeSyncMessage;
			Reader<SelectScp330Message>.read = Scp330NetworkHandler.DeserializeSelectMessage;
			Reader<FlashlightNetworkHandler.FlashlightMessage>.read = FlashlightNetworkHandler.Deserialize;
			Reader<RadioStatusMessage>.read = RadioMessages.ReadRadioStatusMessage;
			Reader<ClientRadioCommandMessage>.read = RadioMessages.ReadClientRadioCommandMessage;
			Reader<KeycardDetailSynchronizer.DetailsSyncMsg>.read = KeycardDetailSynchronizer.DeserializeDetailsSyncMsg;
			Reader<ShotBacktrackData>.read = ShotBacktrackDataSerializer.ReadBacktrackData;
			Reader<AttachmentCodeSync.AttachmentCodeMessage>.read = AttachmentCodeSync.ReadAttachmentCodeMessage;
			Reader<AttachmentCodeSync.AttachmentCodePackMessage>.read = AttachmentCodeSync.ReadAttachmentCodePackMessage;
			Reader<AttachmentsChangeRequest>.read = AttachmentsMessageSerializers.ReadAttachmentsChangeRequest;
			Reader<AttachmentsSetupPreference>.read = AttachmentsMessageSerializers.ReadAttachmentsSetupPreference;
			Reader<ReserveAmmoSync.ReserveAmmoMessage>.read = ReserveAmmoSync.ReadReserveAmmoMessage;
			Reader<AutosyncMessage>.read = AutosyncMessageHandler.ReadAutosyncMessage;
			Reader<ThrowableNetworkHandler.ThrowableItemRequestMessage>.read = ThrowableNetworkHandler.DeserializeRequestMsg;
			Reader<ThrowableNetworkHandler.ThrowableItemAudioMessage>.read = ThrowableNetworkHandler.DeserializeAudioMsg;
			Reader<ThrowableNetworkHandler.ThrowableItemCancellationMessage>.read = ThrowableNetworkHandler.DeserializeCancellationMsg;
			Reader<DeadmanSwitch.DeadMansSequenceActiveMessage>.read = _Read_DeadmanSwitch_002FDeadMansSequenceActiveMessage;
			Reader<Hitmarker.HitmarkerMessage>.read = _Read_Hitmarker_002FHitmarkerMessage;
			Reader<HitmarkerType>.read = _Read_HitmarkerType;
			Reader<Escape.EscapeMessage>.read = _Read_Escape_002FEscapeMessage;
			Reader<ServerShutdown.ServerShutdownMessage>.read = _Read_ServerShutdown_002FServerShutdownMessage;
			Reader<VoiceChatMuteIndicator.SyncMuteMessage>.read = _Read_VoiceChat_002EVoiceChatMuteIndicator_002FSyncMuteMessage;
			Reader<VoiceChatPrivacySettings.VcPrivacyMessage>.read = _Read_VoiceChat_002EVoiceChatPrivacySettings_002FVcPrivacyMessage;
			Reader<PersonalRadioPlayback.TransmitterPositionMessage>.read = _Read_VoiceChat_002EPlaybacks_002EPersonalRadioPlayback_002FTransmitterPositionMessage;
			Reader<LockerWaypoint.LockerWaypointAssignMessage>.read = _Read_RelativePositioning_002ELockerWaypoint_002FLockerWaypointAssignMessage;
			Reader<VoiceChatReceivePrefs.GroupMuteFlagsMessage>.read = _Read_PlayerRoles_002EVoice_002EVoiceChatReceivePrefs_002FGroupMuteFlagsMessage;
			Reader<OverwatchSettingsController.OverwatchSettingsInfoMessage>.read = _Read_PlayerRoles_002ESpectating_002EOverwatchSettingsController_002FOverwatchSettingsInfoMessage;
			Reader<SpectatorNetworking.SpectatedNetIdSyncMessage>.read = _Read_PlayerRoles_002ESpectating_002ESpectatorNetworking_002FSpectatedNetIdSyncMessage;
			Reader<Scp106PocketItemManager.WarningMessage>.read = _Read_PlayerRoles_002EPlayableScps_002EScp106_002EScp106PocketItemManager_002FWarningMessage;
			Reader<ZombieConfirmationBox.ScpReviveBlockMessage>.read = _Read_PlayerRoles_002EPlayableScps_002EScp049_002EZombies_002EZombieConfirmationBox_002FScpReviveBlockMessage;
			Reader<DynamicHumeShieldController.ShieldBreakMessage>.read = _Read_PlayerRoles_002EPlayableScps_002EHumeShield_002EDynamicHumeShieldController_002FShieldBreakMessage;
			Reader<FpcRotationOverrideMessage>.read = _Read_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcRotationOverrideMessage;
			Reader<FpcNoclipToggleMessage>.read = _Read_PlayerRoles_002EFirstPersonControl_002ENetworkMessages_002EFpcNoclipToggleMessage;
			Reader<EmotionSync.EmotionSyncMessage>.read = _Read_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionSync_002FEmotionSyncMessage;
			Reader<EmotionPresetType>.read = _Read_PlayerRoles_002EFirstPersonControl_002EThirdperson_002ESubcontrollers_002EEmotionPresetType;
			Reader<ExplosionUtils.GrenadeExplosionMessage>.read = _Read_Utils_002EExplosionUtils_002FGrenadeExplosionMessage;
			Reader<SeedSynchronizer.SeedMessage>.read = _Read_MapGeneration_002ESeedSynchronizer_002FSeedMessage;
			Reader<CustomPlayerEffects.AntiScp207.BreakMessage>.read = _Read_CustomPlayerEffects_002EAntiScp207_002FBreakMessage;
			Reader<Prismatic.BreakMessage>.read = _Read_CustomPlayerEffects_002EPrismatic_002FBreakMessage;
			Reader<GhostlyWalkThroughMessage>.read = _Read_CustomPlayerEffects_002EGhostlyWalkThroughMessage;
			Reader<InfluenceUpdateMessage>.read = _Read_Respawning_002EInfluenceUpdateMessage;
			Reader<Faction>.read = _Read_PlayerRoles_002EFaction;
			Reader<StripdownNetworking.StripdownResponse>.read = _Read_CommandSystem_002ECommands_002ERemoteAdmin_002EStripdown_002EStripdownNetworking_002FStripdownResponse;
			Reader<string[]>.read = _Read_System_002EString_005B_005D;
			Reader<AchievementManager.AchievementMessage>.read = _Read_Achievements_002EAchievementManager_002FAchievementMessage;
			Reader<HumeShieldSubEffect.HumeBlockMsg>.read = _Read_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHumeShieldSubEffect_002FHumeBlockMsg;
			Reader<Hypothermia.ForcedHypothermiaMessage>.read = _Read_InventorySystem_002EItems_002EUsables_002EScp244_002EHypothermia_002EHypothermia_002FForcedHypothermiaMessage;
			Reader<Scp1576SpectatorWarningHandler.SpectatorWarningMessage>.read = _Read_InventorySystem_002EItems_002EUsables_002EScp1576_002EScp1576SpectatorWarningHandler_002FSpectatorWarningMessage;
			Reader<Scp1344StatusMessage>.read = _Read_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344StatusMessage;
			Reader<Scp1344Status>.read = _Read_InventorySystem_002EItems_002EUsables_002EScp1344_002EScp1344Status;
			Reader<DamageIndicatorMessage>.read = _Read_InventorySystem_002EItems_002EFirearms_002EBasicMessages_002EDamageIndicatorMessage;
			Reader<DoorPermissionFlags>.read = _Read_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags;
			Reader<ServerConfigSynchronizer.PredefinedBanTemplate>.read = _Read_ServerConfigSynchronizer_002FPredefinedBanTemplate;
			Reader<Broadcast.BroadcastFlags>.read = _Read_Broadcast_002FBroadcastFlags;
			Reader<KeyCode>.read = _Read_UnityEngine_002EKeyCode;
			Reader<PlayerInfoArea>.read = _Read_PlayerInfoArea;
			Reader<RoundSummary.SumInfo_ClassList>.read = _Read_RoundSummary_002FSumInfo_ClassList;
			Reader<RoundSummary.LeadingTeam>.read = _Read_RoundSummary_002FLeadingTeam;
			Reader<ServerRoles.BadgePreferences>.read = _Read_ServerRoles_002FBadgePreferences;
			Reader<ServerRoles.BadgeVisibilityPreferences>.read = _Read_ServerRoles_002FBadgeVisibilityPreferences;
			Reader<QueryProcessor.CommandData[]>.read = _Read_RemoteAdmin_002EQueryProcessor_002FCommandData_005B_005D;
			Reader<QueryProcessor.CommandData>.read = _Read_RemoteAdmin_002EQueryProcessor_002FCommandData;
			Reader<DecontaminationController.DecontaminationStatus>.read = _Read_LightContainmentZoneDecontamination_002EDecontaminationController_002FDecontaminationStatus;
			Reader<InvisibleInteractableToy.ColliderShape>.read = _Read_AdminToys_002EInvisibleInteractableToy_002FColliderShape;
			Reader<LightShadows>.read = _Read_UnityEngine_002ELightShadows;
			Reader<LightType>.read = _Read_UnityEngine_002ELightType;
			Reader<LightShape>.read = _Read_UnityEngine_002ELightShape;
			Reader<PrimitiveType>.read = _Read_UnityEngine_002EPrimitiveType;
			Reader<PrimitiveFlags>.read = _Read_AdminToys_002EPrimitiveFlags;
			Reader<Scp914KnobSetting>.read = _Read_Scp914_002EScp914KnobSetting;
			Reader<ElevatorGroup>.read = _Read_Interactables_002EInterobjects_002EElevatorGroup;
			Reader<ItemIdentifier[]>.read = _Read_InventorySystem_002EItems_002EItemIdentifier_005B_005D;
			Reader<ItemIdentifier>.read = _Read_InventorySystem_002EItems_002EItemIdentifier;
			Reader<ItemType>.read = _Read_ItemType;
			Reader<ushort[]>.read = _Read_System_002EUInt16_005B_005D;
			Reader<CandyKindID>.read = _Read_InventorySystem_002EItems_002EUsables_002EScp330_002ECandyKindID;
			Reader<JailbirdWearState>.read = _Read_InventorySystem_002EItems_002EJailbird_002EJailbirdWearState;
			Reader<Team>.read = _Read_PlayerRoles_002ETeam;
		}
	}
}
