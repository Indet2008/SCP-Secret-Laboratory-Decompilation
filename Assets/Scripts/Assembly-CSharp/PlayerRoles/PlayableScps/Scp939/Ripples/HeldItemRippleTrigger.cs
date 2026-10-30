using System.Collections.Generic;
using InventorySystem.Items.MicroHID.Modules;
using InventorySystem.Items.Usables;
using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	// Restored from the client build (IL2CPP): humans using a usable item or a running Micro-HID produce ripples for SCP-939.
	public class HeldItemRippleTrigger : RippleTriggerBase
	{
		[global::UnityEngine.SerializeField]
		private float _cooldown;

		private readonly AbilityCooldown _cd = new AbilityCooldown();

		private readonly Dictionary<ushort, bool> _usableItemStates = new Dictionary<ushort, bool>();

		public override void SpawnObject()
		{
			base.SpawnObject();
			_usableItemStates.Clear();
			UsableItemsController.OnClientStatusReceived += ProcessUsableMessage;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_cd.Clear();
			UsableItemsController.OnClientStatusReceived -= ProcessUsableMessage;
		}

		private void ProcessUsableMessage(StatusMessage msg)
		{
			_usableItemStates[msg.ItemSerial] = msg.Status == StatusMessage.StatusType.Start;
		}

		private void Update()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				SelfReportHeldItem(hub.inventory.CurInstance);
			}
			if (!IsLocalOrSpectated || !_cd.IsReady)
			{
				return;
			}
			_cd.Trigger(_cooldown);
			PlayerRolesUtils.ForEachRole<HumanRole>(ProcessPlayer);
		}

		private void ProcessPlayer(ReferenceHub hub, HumanRole role)
		{
			GetSoundData(hub, out var isProducingSound);
			if (isProducingSound && CheckVisibility(hub))
			{
				Player.Play(role);
				OnPlayedRipple(hub);
			}
		}

		private void GetSoundData(ReferenceHub hub, out bool isProducingSound)
		{
			isProducingSound = false;
			InventorySystem.Items.ItemIdentifier curItem = hub.inventory.CurItem;
			if (curItem.TypeId == ItemType.None)
			{
				return;
			}
			if (curItem.TypeId == ItemType.MicroHID)
			{
				isProducingSound = ProcessMicro(curItem.SerialNumber);
				return;
			}
			if (_usableItemStates.TryGetValue(curItem.SerialNumber, out var state))
			{
				isProducingSound = state;
			}
		}

		private static void SelfReportHeldItem(InventorySystem.Items.ItemBase item)
		{
			if (item is InventorySystem.Items.ISoundEmittingItem soundEmittingItem && soundEmittingItem.TryGetSoundEmissionRange(out var range))
			{
				SelfReport(range);
			}
		}

		private static bool ProcessMicro(ushort serial)
		{
			return CycleSyncModule.GetCycleController(serial).Phase != MicroHidPhase.Standby;
		}
	}
}
