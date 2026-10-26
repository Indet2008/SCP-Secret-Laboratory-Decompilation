using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace Scp914.Processors
{
	public class StandardItemProcessor : Scp914ItemProcessor
	{
		[SerializeField]
		private ItemType[] _roughOutputs;

		[SerializeField]
		private ItemType[] _coarseOutputs;

		[SerializeField]
		private ItemType[] _oneToOneOutputs;

		[SerializeField]
		private ItemType[] _fineOutputs;

		[SerializeField]
		private ItemType[] _veryFineOutputs;

		[SerializeField]
		private bool _fireUpgradeTrigger;

		public override Scp914Result UpgradePickup(Scp914KnobSetting setting, ItemPickupBase sourcePickup)
		{
			ClearCombiner();
			Vector3 newPosition = sourcePickup.Position + Scp914Controller.MoveVector;
			ItemType newType = RandomOutput(setting, sourcePickup.Info.ItemId);
			ProcessPickup(sourcePickup, newType, newPosition, setting);
			return GenerateResultFromCombiner(sourcePickup);
		}

		protected virtual void HandleNone(ItemPickupBase ipb, Vector3 newPosition)
		{
			ipb.DestroySelf();
		}

		protected virtual void HandleOldPickup(ItemPickupBase ipb, Vector3 newPosition)
		{
			ipb.DestroySelf();
		}

		private void ProcessPickup(ItemPickupBase sourcePickup, ItemType newType, Vector3 newPosition, Scp914KnobSetting setting)
		{
			ItemBase value;
			if (newType == ItemType.None)
			{
				HandleNone(sourcePickup, newPosition);
			}
			else if (newType == sourcePickup.Info.ItemId || !InventoryItemLoader.AvailableItems.TryGetValue(newType, out value))
			{
				sourcePickup.transform.position = newPosition;
				if (_fireUpgradeTrigger && sourcePickup is IUpgradeTrigger upgradeTrigger)
				{
					upgradeTrigger.ServerOnUpgraded(setting);
				}
				AddResultToCombiner(sourcePickup);
			}
			else
			{
				PickupSyncInfo value2 = new PickupSyncInfo
				{
					ItemId = newType,
					Serial = ItemSerialGenerator.GenerateNext(),
					WeightKg = value.Weight
				};
				ItemPickupBase resultingPickup = InventoryExtensions.ServerCreatePickup(value, value2, newPosition);
				AddResultToCombiner(resultingPickup);
				HandleOldPickup(sourcePickup, newPosition);
			}
		}

		private ItemType RandomOutput(Scp914KnobSetting setting, ItemType id)
		{
			ItemType[] array;
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
				return id;
			}
			return array[Random.Range(0, array.Length)];
		}
	}
}
