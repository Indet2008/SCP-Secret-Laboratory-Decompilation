using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Pickups;
using MapGeneration.Holidays;
using MapGeneration.Scenarios;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class PredefinedItemSpawnpoint : ItemSpawnpointBase, IScenarioProcessor
	{
		public ItemType TargetItem;

		public Transform[] PossibleSpawnpoints;

		public DistributorScenario Scenario;

		private bool _isSelected;

		private bool _scenarioDefined;

		public void Select()
		{
			_isSelected = true;
		}

		public override bool TryGeneratePickup(out ItemPickupBase pickup)
		{
			if (!_isSelected && _scenarioDefined)
			{
				pickup = null;
				return false;
			}
			Transform parentRoom = PossibleSpawnpoints.RandomItem();
			ItemType itemType = TargetItem;
			if (itemType == ItemType.Flashlight && HolidayUtils.IsHolidayActive(HolidayType.Halloween))
			{
				itemType = ItemType.Lantern;
			}
			pickup = ItemDistributor.ServerCreatePickup(itemType, parentRoom);
			if (_scenarioDefined && Scenario.BlacklistedAttachments.Length != 0 && pickup is FirearmPickup firearmPickup)
			{
				RemoveBlacklistedAttachments(firearmPickup);
			}
			return pickup != null;
		}

		protected override void Awake()
		{
			base.Awake();
			_scenarioDefined = Scenario != null;
			if (_scenarioDefined)
			{
				Scenario.Register(this);
			}
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_scenarioDefined)
			{
				Scenario.Unregister(this);
			}
		}

		private void RemoveBlacklistedAttachments(FirearmPickup firearmPickup)
		{
			uint num = AttachmentsUtils.GetRandomAttachmentsCode(firearmPickup.Info.ItemId);
			AttachmentName[] blacklistedAttachments = Scenario.BlacklistedAttachments;
			foreach (AttachmentName attachmentName in blacklistedAttachments)
			{
				uint num2 = ~AttachmentsUtils.GetAttachmentId(firearmPickup.Info.ItemId, attachmentName);
				num &= num2;
			}
			AttachmentCodeSync.ServerSetCode(firearmPickup.Info.Serial, firearmPickup.Template.ValidateAttachmentsCode(num));
		}
	}
}
