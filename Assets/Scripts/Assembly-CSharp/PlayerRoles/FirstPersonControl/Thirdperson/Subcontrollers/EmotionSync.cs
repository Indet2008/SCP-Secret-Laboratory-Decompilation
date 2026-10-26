using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem.Items;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public static class EmotionSync
	{
		public struct EmotionSyncMessage : NetworkMessage
		{
			public uint HubNetId;

			public EmotionPresetType Data;
		}

		private static readonly Dictionary<ReferenceHub, EmotionPresetType> Database = new Dictionary<ReferenceHub, EmotionPresetType>();

		public static EmotionPresetType GetEmotionPreset(ReferenceHub hub)
		{
			return Database.GetValueOrDefault(hub, EmotionPresetType.Neutral);
		}

		public static void ServerSetEmotionPreset(this ReferenceHub hub, EmotionPresetType preset)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Unable to set emotions on client!");
			}
			Database[hub] = preset;
			NetworkServer.SendToAll(new EmotionSyncMessage
			{
				HubNetId = hub.netId,
				Data = preset
			}, 0, sendToReadyOnly: true);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ReferenceHub.OnPlayerAdded += OnHubAdded;
			ReferenceHub.OnPlayerRemoved += OnHubRemoved;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
			CustomNetworkManager.OnClientReady += OnClientReady;
		}

		private static void OnClientReady()
		{
			Database.Clear();
			NetworkClient.ReplaceHandler<EmotionSyncMessage>(ProcessMessage);
			NetworkServer.ReplaceHandler<EmotionSyncMessage>(TempServerProcessMessage);
		}

		private static void ProcessMessage(EmotionSyncMessage msg)
		{
			if (!ReferenceHub.TryGetHubNetID(msg.HubNetId, out var hub))
			{
				return;
			}
			Database[hub] = msg.Data;
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole) || !(fpcRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel))
			{
				return;
			}
			StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
			for (int i = 0; i < allEffects.Length; i++)
			{
				if (allEffects[i] is IEmotionDisable { EmotionsDisabled: not false })
				{
					return;
				}
			}
			if (animatedCharacterModel.TryGetSubcontroller<EmotionSubcontroller>(out var subcontroller))
			{
				subcontroller.SetPreset(msg.Data);
			}
		}

		private static void OnHubRemoved(ReferenceHub hub)
		{
			Database.Remove(hub);
		}

		private static void OnHubAdded(ReferenceHub hub)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			foreach (KeyValuePair<ReferenceHub, EmotionPresetType> item in Database)
			{
				if (item.Value != EmotionPresetType.Neutral)
				{
					hub.connectionToClient.Send(new EmotionSyncMessage
					{
						HubNetId = item.Key.netId,
						Data = item.Value
					});
				}
			}
		}

		private static void OnServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
		{
			userHub.ServerSetEmotionPreset(EmotionPresetType.Neutral);
		}

		private static void TempServerProcessMessage(NetworkConnection conn, EmotionSyncMessage msg)
		{
			if (ReferenceHub.TryGetHubNetID(msg.HubNetId, out var hub) && !(hub.netIdentity != conn.identity))
			{
				hub.ServerSetEmotionPreset(msg.Data);
			}
		}
	}
}
