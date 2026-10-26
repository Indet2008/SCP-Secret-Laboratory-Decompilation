using System.Collections.Generic;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Firearms.Attachments
{
	public static class AttachmentsServerHandler
	{
		public static readonly Dictionary<ReferenceHub, Dictionary<ItemType, uint>> PlayerPreferences = new Dictionary<ReferenceHub, Dictionary<ItemType, uint>>();

		public static uint ServerGetReceivedPlayerPreference(Firearm firearmInstance)
		{
			ReferenceHub owner = firearmInstance.Owner;
			if (!PlayerPreferences.TryGetValue(owner, out var value))
			{
				return 0u;
			}
			value.TryGetValue(firearmInstance.ItemTypeId, out var value2);
			return value2;
		}

		public static uint ServerGetReceivedPlayerPreference(ReferenceHub hub, ItemType type)
		{
			if (PlayerPreferences.TryGetValue(hub, out var value) && value.TryGetValue(type, out var value2))
			{
				return value2;
			}
			return 0u;
		}

		public static bool AnyWorkstationsNearby(ReferenceHub ply)
		{
			return WorkstationController.AllWorkstations.Any((WorkstationController workstation) =>
			{
				if (workstation == null)
				{
					return false;
				}
				if (workstation.Status != 3)
				{
					return false;
				}
				return workstation.IsInRange(ply) ? true : false;
			});
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnServerStarted += OnServerStarted;
		}

		private static void OnServerStarted()
		{
			PlayerPreferences.Clear();
			NetworkServer.ReplaceHandler<AttachmentsSetupPreference>(ServerReceivePreference);
			NetworkServer.ReplaceHandler<AttachmentsChangeRequest>(ServerReceiveChangeRequest);
		}

		private static void ServerReceiveChangeRequest(NetworkConnection conn, AttachmentsChangeRequest msg)
		{
			if (NetworkServer.active && ReferenceHub.TryGetHub(conn, out var hub) && hub.inventory.CurInstance is Firearm firearm && !(firearm == null) && AnyWorkstationsNearby(hub))
			{
				uint currentAttachmentsCode = firearm.GetCurrentAttachmentsCode();
				uint attachmentsCode = msg.AttachmentsCode;
				PlayerChangingAttachmentsEventArgs e = new PlayerChangingAttachmentsEventArgs(hub, firearm, currentAttachmentsCode, attachmentsCode);
				PlayerEvents.OnChangingAttachments(e);
				if (e.IsAllowed)
				{
					attachmentsCode = e.NewAttachments;
					firearm.ApplyAttachmentsCode(attachmentsCode, reValidate: true);
					firearm.ServerResendAttachmentCode();
					ServerApplyPreference(hub, firearm.ItemTypeId, attachmentsCode);
					PlayerEvents.OnChangedAttachments(new PlayerChangedAttachmentsEventArgs(hub, firearm, currentAttachmentsCode, attachmentsCode));
				}
			}
		}

		private static void ServerReceivePreference(NetworkConnection conn, AttachmentsSetupPreference msg)
		{
			if (NetworkServer.active && ReferenceHub.TryGetHub(conn, out var hub))
			{
				uint oldAttachments = ServerGetReceivedPlayerPreference(hub, msg.Weapon);
				uint attachmentsCode = msg.AttachmentsCode;
				PlayerSendingAttachmentsPrefsEventArgs e = new PlayerSendingAttachmentsPrefsEventArgs(hub, msg.Weapon, oldAttachments, attachmentsCode);
				PlayerEvents.OnSendingAttachmentsPrefs(e);
				if (e.IsAllowed)
				{
					attachmentsCode = e.NewAttachments;
					ServerApplyPreference(hub, msg.Weapon, attachmentsCode);
					PlayerEvents.OnSentAttachmentsPrefs(new PlayerSentAttachmentsPrefsEventArgs(hub, msg.Weapon, oldAttachments, attachmentsCode));
				}
			}
		}

		private static void ServerApplyPreference(ReferenceHub hub, ItemType weapon, uint attCode)
		{
			PlayerPreferences.GetOrAdd(hub, () => new Dictionary<ItemType, uint>())[weapon] = attCode;
		}
	}
}
