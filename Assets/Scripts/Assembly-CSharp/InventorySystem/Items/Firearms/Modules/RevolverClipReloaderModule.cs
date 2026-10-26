using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Modules.Misc;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class RevolverClipReloaderModule : AnimatorReloaderModuleBase
	{
		private static readonly Dictionary<ushort, int> SyncWithheld = new Dictionary<ushort, int>();

		private int _serverWithheld;

		private int _clientWithheld;

		private bool _withheldDirty;

		public int WithheldAmmo
		{
			get
			{
				if (!base.IsServer)
				{
					return _clientWithheld;
				}
				return _serverWithheld;
			}
		}

		private IPrimaryAmmoContainerModule AmmoContainer
		{
			get
			{
				if (!base.Firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module))
				{
					throw new InvalidOperationException("The " + base.Firearm.name + " does not have a IPrimaryAmmoContainerModule required by the RevolverClipReloaderModule.");
				}
				return module;
			}
		}

		private int ServerWithheld
		{
			get
			{
				return _serverWithheld;
			}
			set
			{
				if (value < 0)
				{
					value = 0;
				}
				if (_serverWithheld != value)
				{
					_serverWithheld = value;
					_withheldDirty = true;
					OnWithheld?.Invoke();
				}
			}
		}

		public event Action<int> OnAmmoInserted;

		public event Action OnWithheld;

		[ExposedFirearmEvent]
		public void ServerWithholdAmmo()
		{
			if (base.IsServer)
			{
				ServerResetWithheldAmmo();
				Inventory ownerInventory = base.Firearm.OwnerInventory;
				ItemType ammoType = AmmoContainer.AmmoType;
				ServerWithheld = Mathf.Min(ownerInventory.GetCurAmmo(ammoType), AmmoContainer.AmmoMax);
				ownerInventory.ServerAddAmmo(ammoType, -ServerWithheld);
			}
		}

		[ExposedFirearmEvent]
		public void InsertAmmoFromClip()
		{
			int num = Mathf.Min(WithheldAmmo, AmmoContainer.AmmoMax);
			if (base.IsServer)
			{
				AmmoContainer.ServerModifyAmmo(num);
			}
			OnAmmoInserted?.Invoke(num);
			if (base.IsServer)
			{
				ServerWithheld -= num;
				ServerResetWithheldAmmo();
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsServer && _withheldDirty)
			{
				_withheldDirty = false;
				ServerSendWithheldAmmo();
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			ServerResetWithheldAmmo();
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SyncWithheld.Clear();
		}

		protected override void OnInit()
		{
			base.OnInit();
			ClientFetchWithheld();
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			ClientFetchWithheld();
		}

		protected override MessageInterceptionResult InterceptMessage(NetworkReader reader, ushort serial, ReloaderMessageHeader header, AutosyncMessageType scenario)
		{
			if (header != ReloaderMessageHeader.Custom || (scenario != AutosyncMessageType.RpcTemplate && scenario != AutosyncMessageType.RpcInstance))
			{
				return base.InterceptMessage(reader, serial, header, scenario);
			}
			int num = reader.ReadByte();
			SyncWithheld[serial] = num;
			if (scenario == AutosyncMessageType.RpcInstance && _clientWithheld != num)
			{
				_clientWithheld = num;
				OnWithheld?.Invoke();
			}
			return MessageInterceptionResult.Stop;
		}

		public override bool ServerTryReload()
		{
			if (!IReloadUnloadValidatorModule.ValidateReload(base.Firearm))
			{
				return false;
			}
			ServerSendWithheldAmmo();
			base.IsReloading = true;
			SendRpcHeaderWithRandomByte(ReloaderMessageHeader.Reload);
			return true;
		}

		protected override void StartReloading()
		{
			DecockAndPlayAnim(FirearmAnimatorHashes.Reload);
		}

		protected override void StartUnloading()
		{
			DecockAndPlayAnim(FirearmAnimatorHashes.Unload);
		}

		private void ClientFetchWithheld()
		{
			_clientWithheld = SyncWithheld.GetValueOrDefault(base.ItemSerial);
		}

		private void ServerSendWithheldAmmo()
		{
			SendRpc((NetworkWriter x) =>
			{
				x.WriteSubheader(ReloaderMessageHeader.Custom);
				x.WriteByte((byte)ServerWithheld);
			});
		}

		private void ServerResetWithheldAmmo()
		{
			if (base.IsServer && ServerWithheld > 0)
			{
				base.Firearm.OwnerInventory.ServerAddAmmo(AmmoContainer.AmmoType, ServerWithheld);
				ServerWithheld = 0;
			}
		}

		private void DecockAndPlayAnim(int hash)
		{
			if (base.Firearm.TryGetModule<DoubleActionModule>(out var module) && module.Cocked)
			{
				module.TriggerDecocking(hash);
			}
			else
			{
				base.Firearm.AnimSetTrigger(hash);
			}
		}
	}
}
