using System.Collections.Generic;
using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.GUI.Descriptions;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.MicroHID;
using InventorySystem.Items.Pickups;
using MapGeneration.Distributors;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms
{
	public class ParticleDisruptor : Firearm
	{
		public static readonly HashSet<ushort> BrokenSerials = new HashSet<ushort>();

		private static readonly string[] DescriptionNonAlloc = new string[1];

		private DisruptorActionModule _actionModule;

		private MagazineModule _magazineModule;

		private IEquipperModule _equipperModule;

		private readonly ItemHintAlertHelper _hint = new ItemHintAlertHelper(InventoryGuiTranslation.DisruptorToggleModeHint, ActionName.WeaponAlt, 0.3f, 0f);

		[SerializeField]
		private CustomDescriptionGui _descriptionPrefab;

		public override CustomDescriptionGui CustomGuiPrefab => _descriptionPrefab;

		public override bool AllowHolster
		{
			get
			{
				if (base.AllowHolster)
				{
					if (_actionModule.IsFiring)
					{
						return DeleteOnDrop;
					}
					return true;
				}
				return false;
			}
		}

		public override bool AllowDropping => true;

		public override ItemDescriptionType DescriptionType => ItemDescriptionType.Custom;

		public override AlertContent Alert => _hint.Alert;

		public override string[] CustomDescriptionContent
		{
			get
			{
				DescriptionNonAlloc[0] = MicroHIDItem.FormatCharge(InventoryGuiTranslation.RemainingAmmo, _magazineModule.AmmoStored.ToString());
				return DescriptionNonAlloc;
			}
		}

		private bool DeleteOnDrop
		{
			get
			{
				if (!_actionModule.IsFiring)
				{
					return _magazineModule.AmmoStored == 0;
				}
				return false;
			}
		}

		public override void InitializeSubcomponents()
		{
			base.InitializeSubcomponents();
			this.TryGetModules<DisruptorActionModule, MagazineModule, IEquipperModule>(out _actionModule, out _magazineModule, out _equipperModule);
		}

		public override void OnAdded(ItemPickupBase pickup)
		{
			base.OnAdded(pickup);
			if (NetworkServer.active && !(pickup == null) && pickup.transform.TryGetComponentInParent<Locker>(out var _))
			{
				base.OwnerInventory.ServerSelectItem(base.ItemSerial);
			}
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (_equipperModule.IsEquipped && !base.PrimaryActionBlocked)
			{
				_hint.Update(base.Owner);
			}
		}

		public override ItemPickupBase ServerDropItem(bool spawn)
		{
			if (DeleteOnDrop)
			{
				ServerDestroyItem();
				return null;
			}
			return base.ServerDropItem(spawn);
		}

		public void ServerDestroyItem()
		{
			if (base.IsServer)
			{
				ServerSendBrokenRpc(base.ItemSerial);
				base.OwnerInventory.ServerRemoveItem(base.ItemSerial, null);
			}
		}

		public void ServerSendBrokenRpc(ushort serial)
		{
			ServerSendPublicRpc((NetworkWriter x) =>
			{
				x.WriteByte(byte.MaxValue);
				x.WriteUShort(serial);
			});
		}

		protected override void OnClientReady()
		{
			base.OnClientReady();
			BrokenSerials.Clear();
		}

		protected override void ClientProcessMainRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessMainRpcTemplate(reader, serial);
			BrokenSerials.Add(reader.ReadUShort());
		}
	}
}
