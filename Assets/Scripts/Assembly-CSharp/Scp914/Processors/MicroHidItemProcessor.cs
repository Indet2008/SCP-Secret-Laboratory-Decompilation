using InventorySystem;
using InventorySystem.Items.MicroHID;
using InventorySystem.Items.MicroHID.Modules;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace Scp914.Processors
{
	public class MicroHidItemProcessor : StandardItemProcessor
	{
		public override Scp914Result UpgradePickup(Scp914KnobSetting setting, ItemPickupBase sourcePickup)
		{
			if (!(sourcePickup is MicroHIDPickup microHIDPickup))
			{
				return base.UpgradePickup(setting, sourcePickup);
			}
			ushort serialNumber = microHIDPickup.ItemId.SerialNumber;
			bool broken = BrokenSyncModule.GetBroken(serialNumber);
			MicroHIDItem template = microHIDPickup.ItemId.TypeId.GetTemplate<MicroHIDItem>();
			Vector3 position = microHIDPickup.Position + Scp914Controller.MoveVector;
			switch (setting)
			{
			case Scp914KnobSetting.Coarse:
				if (broken)
				{
					template.EnergyManager.ServerSetEnergy(serialNumber, Random.value);
				}
				else
				{
					template.BrokenSync.ServerSetBroken(serialNumber, broken: true);
				}
				break;
			case Scp914KnobSetting.Fine:
				template.EnergyManager.ServerSetEnergy(serialNumber, 1f);
				break;
			case Scp914KnobSetting.VeryFine:
				if (broken)
				{
					template.BrokenSync.ServerSetBroken(serialNumber, broken: false);
				}
				goto case Scp914KnobSetting.Fine;
			default:
				return base.UpgradePickup(setting, sourcePickup);
			}
			microHIDPickup.Position = position;
			return new Scp914Result(microHIDPickup, null, sourcePickup);
		}
	}
}
