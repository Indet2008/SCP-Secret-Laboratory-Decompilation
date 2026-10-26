using System;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace Scp914.Processors
{
	public class FirearmItemProcessor : Scp914ItemProcessor
	{
		[Serializable]
		private struct FirearmOutput
		{
			[Range(0f, 1f)]
			public float Chance;

			public ItemType[] TargetItems;
		}

		[SerializeField]
		private FirearmOutput[] _roughOutputs;

		[SerializeField]
		private FirearmOutput[] _coarseOutputs;

		[SerializeField]
		private FirearmOutput[] _oneToOneOutputs;

		[SerializeField]
		private FirearmOutput[] _fineOutputs;

		[SerializeField]
		private FirearmOutput[] _veryFineOutputs;

		private static readonly ItemType[] DestroyResult = new ItemType[1] { ItemType.None };

		public override Scp914Result UpgradePickup(Scp914KnobSetting setting, ItemPickupBase ipb)
		{
			ClearCombiner();
			ItemType[] items = GetItems(setting, ipb.Info.ItemId);
			foreach (ItemType newType in items)
			{
				UpgradePickup(newType, ipb);
			}
			return GenerateResultFromCombiner(ipb);
		}

		private void UpgradePickup(ItemType newType, ItemPickupBase source)
		{
			if (!(source is FirearmPickup))
			{
				throw new InvalidOperationException("Attempting to use FirearmItemProcessor on a non-firearm item.");
			}
			ItemIdentifier oldId = new ItemIdentifier(source.Info.ItemId, source.Info.Serial);
			Vector3 newPos = source.transform.position + Scp914Controller.MoveVector;
			if (!newType.TryGetTemplate<ItemBase>(out var item))
			{
				if (newType == ItemType.None)
				{
					source.DestroySelf();
					return;
				}
				source.transform.position = newPos;
				AddResultToCombiner(source);
				return;
			}
			if (newType == oldId.TypeId)
			{
				AttachmentCodeSync.ServerSetCode(oldId.SerialNumber, AttachmentsUtils.GetRandomAttachmentsCode(newType));
				source.transform.position = newPos;
				AddResultToCombiner(source);
				return;
			}
			HandleOldFirearm(oldId, newType, SpawnAmmoPickup);
			PickupSyncInfo value = new PickupSyncInfo
			{
				ItemId = newType,
				Serial = ItemSerialGenerator.GenerateNext(),
				WeightKg = item.Weight
			};
			ItemPickupBase resultingPickup = InventoryExtensions.ServerCreatePickup(item, value, newPos, source.transform.rotation);
			source.DestroySelf();
			AddResultToCombiner(resultingPickup);
			void SpawnAmmoPickup(ItemType ammoTypeToSpawn, int ammoAmountToSpawn)
			{
				ItemPickupBase resultingPickup2 = AmmoItemProcessor.CreateAmmoPickup(ammoTypeToSpawn, ammoAmountToSpawn, newPos);
				AddResultToCombiner(resultingPickup2);
			}
		}

		private void HandleOldFirearm(ItemIdentifier oldId, ItemType newType, Action<ItemType, int> spawnAmmoMethod)
		{
			if (AttachmentPreview.Get(oldId).TryGetModule<IPrimaryAmmoContainerModule>(out var module))
			{
				int totalStoredAmmo = ModulesUtils.GetTotalStoredAmmo(oldId);
				if (AttachmentPreview.TryGet(newType, 0u, reValidate: true, out var result) && result.TryGetModule<IPrimaryAmmoContainerModule>(out var module2))
				{
					AmmoItemProcessor.ExchangeAmmo(module.AmmoType, module2.AmmoType, totalStoredAmmo, out var exchangedAmmo, out var change);
					spawnAmmoMethod(module.AmmoType, change);
					spawnAmmoMethod(module2.AmmoType, exchangedAmmo);
				}
				else
				{
					spawnAmmoMethod(module.AmmoType, totalStoredAmmo);
				}
			}
		}

		private ItemType[] GetItems(Scp914KnobSetting setting, ItemType input)
		{
			FirearmOutput[] array;
			switch (setting)
			{
			case Scp914KnobSetting.Rough:
				array = _roughOutputs;
				break;
			case Scp914KnobSetting.Coarse:
				array = _coarseOutputs;
				break;
			case Scp914KnobSetting.OneToOne:
				array = _oneToOneOutputs;
				break;
			case Scp914KnobSetting.Fine:
				array = _fineOutputs;
				break;
			case Scp914KnobSetting.VeryFine:
				array = _veryFineOutputs;
				break;
			default:
				return DestroyResult;
			}
			if (array.Length == 0)
			{
				return new ItemType[1] { input };
			}
			float value = UnityEngine.Random.value;
			float num = 0f;
			FirearmOutput[] array2 = array;
			for (int i = 0; i < array2.Length; i++)
			{
				FirearmOutput firearmOutput = array2[i];
				num += firearmOutput.Chance;
				if (num >= value)
				{
					return firearmOutput.TargetItems;
				}
			}
			return DestroyResult;
		}
	}
}
