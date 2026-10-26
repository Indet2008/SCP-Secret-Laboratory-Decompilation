using InventorySystem;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Pickups;
using UnityEngine;

namespace Scp914.Processors
{
	public class DisruptorItemProcessor : Scp914ItemProcessor
	{
		public override Scp914Result UpgradePickup(Scp914KnobSetting setting, ItemPickupBase sourcePickup)
		{
			Vector3 vector = sourcePickup.transform.position + Scp914Controller.MoveVector;
			switch (setting)
			{
			case Scp914KnobSetting.Rough:
				sourcePickup.DestroySelf();
				return NewPickup(sourcePickup, vector, ItemType.Flashlight);
			case Scp914KnobSetting.Coarse:
				sourcePickup.DestroySelf();
				return NewPickup(sourcePickup, vector, ItemType.GunE11SR);
			case Scp914KnobSetting.OneToOne:
				sourcePickup.DestroySelf();
				return NewPickup(sourcePickup, vector, ItemType.Jailbird);
			default:
			{
				AttachmentPreview.Get(ItemType.ParticleDisruptor, 0u, reValidate: true).TryGetModule<MagazineModule>(out var module);
				module.ServerSetInstanceAmmo(sourcePickup.Info.Serial, module.AmmoMax);
				sourcePickup.Position = vector;
				return new Scp914Result(sourcePickup, null, sourcePickup);
			}
			}
		}

		private Scp914Result NewPickup(ItemPickupBase sourcePickup, Vector3 pos, ItemType item)
		{
			ItemPickupBase resultingPickup = InventoryExtensions.ServerCreatePickup(item.GetTemplate(), null, pos);
			return new Scp914Result(sourcePickup, null, resultingPickup);
		}
	}
}
