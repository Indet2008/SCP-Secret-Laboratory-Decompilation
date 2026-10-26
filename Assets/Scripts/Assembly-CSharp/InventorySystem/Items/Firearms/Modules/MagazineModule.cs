using System;
using System.Collections.Generic;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Pickups;
using Mirror;
using Scp914;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class MagazineModule : ModuleBase, IReloadUnloadValidatorModule, IMagazineControllerModule, IPrimaryAmmoContainerModule, IAmmoContainerModule, IDisplayableAmmoProviderModule, IAmmoDropPreventer
	{
		private static readonly Dictionary<ushort, int> SyncData = new Dictionary<ushort, int>();

		public bool IsFixedMagazine;

		[SerializeField]
		private int _defaultCapacity;

		[SerializeField]
		private ItemType _ammoType;

		[SerializeField]
		private AnimatorConditionalOverride _magazineRemovedOverrideLayers;

		public ItemType AmmoType => _ammoType;

		public virtual IReloadUnloadValidatorModule.Authorization ReloadAuthorization
		{
			get
			{
				if (AmmoStored >= AmmoMax || base.Firearm.OwnerInventory.GetCurAmmo(AmmoType) <= 0)
				{
					return IReloadUnloadValidatorModule.Authorization.Idle;
				}
				return IReloadUnloadValidatorModule.Authorization.Allowed;
			}
		}

		public virtual IReloadUnloadValidatorModule.Authorization UnloadAuthorization
		{
			get
			{
				if (AmmoStored <= 0)
				{
					return IReloadUnloadValidatorModule.Authorization.Idle;
				}
				return IReloadUnloadValidatorModule.Authorization.Allowed;
			}
		}

		public int AmmoMax => _defaultCapacity + (int)base.Firearm.AttachmentsValue(AttachmentParam.MagazineCapacityModifier);

		public int AmmoStored
		{
			get
			{
				return GetAmmoStoredForSerial(base.ItemSerial);
			}
			private set
			{
				if (MagazineInserted)
				{
					SyncData[base.ItemSerial] = value + 1;
				}
			}
		}

		public bool MagazineInserted
		{
			get
			{
				return GetMagazineInserted(base.ItemSerial);
			}
			private set
			{
				SyncData[base.ItemSerial] = (value ? (AmmoStored + 1) : 0);
			}
		}

		public DisplayAmmoValues PredictedDisplayAmmo => default;

		private Inventory UserInv => base.Firearm.OwnerInventory;

		public static event Action<ushort> OnDataReceived;

		public static bool GetMagazineInserted(ushort serial)
		{
			if (SyncData.TryGetValue(serial, out var value))
			{
				return value > 0;
			}
			return false;
		}

		public void ServerSetInstanceAmmo(ushort serial, int amount)
		{
			SyncData[serial] = amount + 1;
			ServerResyncData();
		}

		[ExposedFirearmEvent]
		public void ServerRemoveMagazine()
		{
			if (base.IsServer)
			{
				UserInv.ServerAddAmmo(AmmoType, AmmoStored);
				MagazineInserted = false;
				ServerResyncData();
			}
		}

		[ExposedFirearmEvent]
		public void ServerInsertMagazine()
		{
			if (base.IsServer)
			{
				ServerInsertEmptyMagazine();
				ServerLoadAmmoFromInventory();
			}
		}

		[ExposedFirearmEvent]
		public void ServerInsertEmptyMagazine()
		{
			if (base.IsServer)
			{
				MagazineInserted = true;
				ServerResyncData();
			}
		}

		[ExposedFirearmEvent]
		public void ServerLoadAmmoFromInventory(int insertionLimit)
		{
			if (base.IsServer)
			{
				int b = AmmoMax - AmmoStored;
				int num = Mathf.Min(Mathf.Min(UserInv.GetCurAmmo(AmmoType), b), insertionLimit);
				UserInv.ServerAddAmmo(AmmoType, -num);
				AmmoStored += num;
				ServerResyncData();
			}
		}

		[ExposedFirearmEvent]
		public void ServerLoadAmmoFromInventory()
		{
			ServerLoadAmmoFromInventory(int.MaxValue);
		}

		public void ServerResyncData()
		{
			if (SyncData.TryGetValue(base.ItemSerial, out var syncData))
			{
				SendRpc((NetworkWriter writer) =>
				{
					writer.WriteUShort(base.ItemSerial);
					writer.WriteInt(syncData);
				});
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			while (reader.Remaining > 0)
			{
				ushort num = reader.ReadUShort();
				int value = reader.ReadInt();
				SyncData[num] = value;
				OnDataReceived?.Invoke(num);
			}
		}

		public void ServerModifyAmmo(int amt)
		{
			AmmoStored += amt;
			ServerResyncData();
		}

		public int GetAmmoStoredForSerial(ushort serial)
		{
			if (!SyncData.TryGetValue(serial, out var value))
			{
				return 0;
			}
			return Mathf.Max(0, value - 1);
		}

		public DisplayAmmoValues GetDisplayAmmoForSerial(ushort serial)
		{
			return new DisplayAmmoValues(GetAmmoStoredForSerial(serial));
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstModule)
		{
			base.ServerOnPlayerConnected(hub, firstModule);
			if (!firstModule)
			{
				return;
			}
			SendRpc(hub, (NetworkWriter writer) =>
			{
				foreach (KeyValuePair<ushort, int> syncDatum in SyncData)
				{
					writer.WriteUShort(syncDatum.Key);
					writer.WriteInt(syncDatum.Value);
				}
			});
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			_magazineRemovedOverrideLayers.Update(base.Firearm, !MagazineInserted);
			base.Firearm.AnimSetInt(FirearmAnimatorHashes.MagazineAmmo, AmmoStored, checkIfExists: true);
			base.Firearm.AnimSetBool(FirearmAnimatorHashes.IsMagInserted, MagazineInserted, checkIfExists: true);
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			if (base.IsServer)
			{
				if (IsFixedMagazine)
				{
					MagazineInserted = true;
				}
				switch (base.Firearm.ServerAddReason)
				{
				case ItemAddReason.AdminCommand:
				case ItemAddReason.Scp2536:
					MagazineInserted = true;
					AmmoStored = AmmoMax;
					break;
				case ItemAddReason.StartingItem:
					ServerInsertMagazine();
					return;
				}
				ServerResyncData();
			}
		}

		internal override void OnAttachmentsApplied()
		{
			base.OnAttachmentsApplied();
			if (base.IsServer)
			{
				int num = AmmoStored - AmmoMax;
				if (num > 0)
				{
					AmmoStored -= num;
					UserInv.ServerAddAmmo(AmmoType, num);
					ServerResyncData();
				}
			}
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (base.IsServer)
			{
				ServerResyncData();
			}
		}

		internal override void ServerProcessMapgenDistribution(ItemPickupBase pickupBase)
		{
			base.ServerProcessMapgenDistribution(pickupBase);
			if (pickupBase is FirearmPickup firearmPickup && AttachmentPreview.TryGet(firearmPickup.CurId, reValidate: false, out var result) && result.TryGetModule<MagazineModule>(out var module))
			{
				SyncData[firearmPickup.CurId.SerialNumber] = module.AmmoMax + 1;
			}
		}

		internal override void ServerProcessScp914Creation(ushort serial, Scp914KnobSetting knobSetting, Scp914Result scp914Result, ItemType itemType)
		{
			base.ServerProcessScp914Creation(serial, knobSetting, scp914Result, itemType);
			if (itemType == ItemType.ParticleDisruptor)
			{
				SyncData[serial] = AmmoMax + 1;
				ServerResyncData();
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SyncData.Clear();
		}

		public bool ValidateAmmoDrop(ItemType id)
		{
			if (id == AmmoType && base.Firearm.TryGetModule<IReloaderModule>(out var module))
			{
				return !module.IsReloadingOrUnloading;
			}
			return true;
		}
	}
}
