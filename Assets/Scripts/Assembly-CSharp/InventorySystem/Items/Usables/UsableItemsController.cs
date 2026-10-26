using System;
using System.Collections.Generic;
using AudioPooling;
using CustomPlayerEffects;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.Usables
{
	public static class UsableItemsController
	{
		public static readonly Dictionary<ReferenceHub, PlayerHandler> Handlers = new Dictionary<ReferenceHub, PlayerHandler>();

		public static readonly Dictionary<ushort, float> GlobalItemCooldowns = new Dictionary<ushort, float>();

		public static readonly Dictionary<ushort, float> StartTimes = new Dictionary<ushort, float>();

		private static readonly Dictionary<ushort, AudioPoolSession> CurrentlyPlayingSources = new Dictionary<ushort, AudioPoolSession>();

		public static event Action<ReferenceHub, UsableItem> ServerOnUsingCompleted;

		public static event Action<StatusMessage> OnClientStatusReceived;

		[RuntimeInitializeOnLoadMethod]
		private static void InitOnLoad()
		{
			CustomNetworkManager.OnClientReady += OnClientReady;
			PlayerRoleManager.OnRoleChanged += ResetPlayerOnRoleChange;
			StaticUnityMethods.OnUpdate += Update;
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				Handlers.Remove(hub);
			};
			Inventory.OnLocalClientStarted += StartTimes.Clear;
			CustomNetworkManager.OnClientReady += CurrentlyPlayingSources.Clear;
		}

		public static void OnClientReady()
		{
			NetworkServer.ReplaceHandler<StatusMessage>(ServerReceivedStatus);
			NetworkClient.ReplaceHandler<StatusMessage>(ClientReceivedStatus);
			NetworkClient.ReplaceHandler<ItemCooldownMessage>(ClientReceivedCooldown);
			GlobalItemCooldowns.Clear();
			Handlers.Clear();
		}

		public static PlayerHandler GetHandler(ReferenceHub ply)
		{
			if (!Handlers.TryGetValue(ply, out var value))
			{
				value = new PlayerHandler();
				Handlers.Add(ply, value);
			}
			return value;
		}

		public static float GetCooldown(ushort itemSerial, ItemBase item, PlayerHandler ply)
		{
			float num = 0f;
			if (GlobalItemCooldowns.TryGetValue(itemSerial, out var value))
			{
				num = value;
			}
			if (ply.PersonalCooldowns.TryGetValue(item.ItemTypeId, out var value2) && value2 > num)
			{
				num = value2;
			}
			return num - Time.timeSinceLevelLoad;
		}

		public static void PlaySoundOnPlayer(ReferenceHub ply, AudioClip clip)
		{
			ItemIdentifier curItem = ply.inventory.CurItem;
			PooledAudioSource pooledAudioSource = AudioSourcePoolManager.PlayOnTransform(clip, ply.transform, 15f);
			pooledAudioSource.Source.pitch = curItem.TypeId.GetSpeedMultiplier(ply);
			CurrentlyPlayingSources[curItem.SerialNumber] = new AudioPoolSession(pooledAudioSource);
		}

		public static void ServerEmulateMessage(ushort serial, StatusMessage.StatusType status)
		{
			if (InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
			{
				ServerReceivedStatus(hub.connectionToClient, new StatusMessage(status, serial));
			}
		}

		private static void Update()
		{
			if (!StaticUnityMethods.IsPlaying || !NetworkServer.active)
			{
				return;
			}
			foreach (KeyValuePair<ReferenceHub, PlayerHandler> handler in Handlers)
			{
				handler.Value.DoUpdate(handler.Key);
				CurrentlyUsedItem currentUsable = handler.Value.CurrentUsable;
				if (currentUsable.ItemSerial == 0)
				{
					continue;
				}
				float speedMultiplier = currentUsable.Item.ItemTypeId.GetSpeedMultiplier(handler.Key);
				if (currentUsable.ItemSerial != handler.Key.inventory.CurItem.SerialNumber)
				{
					if (currentUsable.Item != null)
					{
						currentUsable.Item.OnUsingCancelled();
					}
					handler.Value.CurrentUsable = CurrentlyUsedItem.None;
					handler.Key.inventory.connectionToClient.Send(new StatusMessage(StatusMessage.StatusType.Cancel, currentUsable.ItemSerial));
				}
				else
				{
					if (!(Time.timeSinceLevelLoad >= currentUsable.StartTime + currentUsable.Item.UseTime / speedMultiplier))
					{
						continue;
					}
					PlayerItemUsageEffectsApplyingEventArgs e = new PlayerItemUsageEffectsApplyingEventArgs(handler.Key, currentUsable.Item);
					PlayerEvents.OnItemUsageEffectsApplying(e);
					if (!e.IsAllowed)
					{
						if (!e.ContinueProcess)
						{
							handler.Value.CurrentUsable = CurrentlyUsedItem.None;
						}
					}
					else
					{
						currentUsable.Item.ServerOnUsingCompleted();
						ServerOnUsingCompleted?.Invoke(handler.Key, currentUsable.Item);
						handler.Value.CurrentUsable = CurrentlyUsedItem.None;
						PlayerEvents.OnUsedItem(new PlayerUsedItemEventArgs(handler.Key, currentUsable.Item));
					}
				}
			}
		}

		private static void ServerReceivedStatus(NetworkConnection conn, StatusMessage msg)
		{
			if (!ReferenceHub.TryGetHub(conn, out var hub) || !(hub.inventory.CurInstance is UsableItem usableItem) || usableItem.ItemSerial != msg.ItemSerial)
			{
				return;
			}
			PlayerHandler handler = GetHandler(hub);
			switch (msg.Status)
			{
			case StatusMessage.StatusType.Start:
			{
				if (!usableItem.ServerValidateStartRequest(handler) || handler.CurrentUsable.ItemSerial != 0 || !usableItem.CanStartUsing)
				{
					break;
				}
				float cooldown = GetCooldown(msg.ItemSerial, usableItem, handler);
				if (cooldown > 0f)
				{
					conn.Send(new ItemCooldownMessage(msg.ItemSerial, cooldown));
				}
				else if (usableItem.ItemTypeId.GetSpeedMultiplier(hub) > 0f)
				{
					PlayerUsingItemEventArgs e2 = new PlayerUsingItemEventArgs(hub, usableItem);
					PlayerEvents.OnUsingItem(e2);
					if (e2.IsAllowed)
					{
						handler.CurrentUsable = new CurrentlyUsedItem(usableItem, msg.ItemSerial, Time.timeSinceLevelLoad);
						handler.CurrentUsable.Item.OnUsingStarted();
						new StatusMessage(StatusMessage.StatusType.Start, msg.ItemSerial).SendToAuthenticated();
					}
				}
				break;
			}
			case StatusMessage.StatusType.Cancel:
			{
				if (!usableItem.ServerValidateCancelRequest(handler) || handler.CurrentUsable.ItemSerial == 0)
				{
					break;
				}
				float speedMultiplier = handler.CurrentUsable.Item.ItemTypeId.GetSpeedMultiplier(hub);
				if (handler.CurrentUsable.StartTime + handler.CurrentUsable.Item.MaxCancellableTime / speedMultiplier > Time.timeSinceLevelLoad)
				{
					PlayerCancellingUsingItemEventArgs e = new PlayerCancellingUsingItemEventArgs(hub, usableItem);
					PlayerEvents.OnCancellingUsingItem(e);
					if (e.IsAllowed)
					{
						handler.CurrentUsable.Item.OnUsingCancelled();
						handler.CurrentUsable = CurrentlyUsedItem.None;
						new StatusMessage(StatusMessage.StatusType.Cancel, msg.ItemSerial).SendToAuthenticated();
						PlayerEvents.OnCancelledUsingItem(new PlayerCancelledUsingItemEventArgs(hub, usableItem));
					}
				}
				break;
			}
			}
		}

		private static void ClientReceivedStatus(StatusMessage msg)
		{
			ushort itemSerial = msg.ItemSerial;
			bool flag = msg.Status == StatusMessage.StatusType.Start;
			if (!flag && CurrentlyPlayingSources.TryGetValue(itemSerial, out var value) && value.SameSession)
			{
				value.HandledInstance.Source.Stop();
				StartTimes.Remove(itemSerial);
				CurrentlyPlayingSources.Remove(itemSerial);
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				AudioClip usingSfxClip;
				if (allHub.isLocalPlayer)
				{
					if (!allHub.inventory.UserInventory.Items.TryGetValue(itemSerial, out var value2) || !(value2 is UsableItem usableItem))
					{
						continue;
					}
					if (flag)
					{
						usableItem.OnUsingStarted();
					}
					else
					{
						usableItem.OnUsingCancelled();
					}
					if (!(usableItem.UsingSfxClip != null))
					{
						break;
					}
					usingSfxClip = usableItem.UsingSfxClip;
				}
				else
				{
					if (allHub.inventory.CurItem.SerialNumber != itemSerial)
					{
						continue;
					}
					if (!InventoryItemLoader.AvailableItems.TryGetValue(allHub.inventory.CurItem.TypeId, out var value3) || !(value3 is UsableItem usableItem2) || !(usableItem2.UsingSfxClip != null))
					{
						break;
					}
					usingSfxClip = usableItem2.UsingSfxClip;
				}
				if (flag)
				{
					PlaySoundOnPlayer(allHub, usingSfxClip);
					StartTimes[itemSerial] = Time.timeSinceLevelLoad;
				}
				break;
			}
			OnClientStatusReceived?.Invoke(msg);
		}

		private static void ClientReceivedCooldown(ItemCooldownMessage msg)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.inventory.UserInventory.Items.TryGetValue(msg.ItemSerial, out var value) && value is UsableItem usableItem)
			{
				usableItem.RemainingCooldown = msg.RemainingTime;
			}
		}

		private static void ResetPlayerOnRoleChange(ReferenceHub ply, PlayerRoleBase r1, PlayerRoleBase r2)
		{
			GetHandler(ply).ResetAll();
		}
	}
}
