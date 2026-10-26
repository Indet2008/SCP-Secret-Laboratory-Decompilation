using System;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Pickups;
using InventorySystem.Searching;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms
{
	public class FirearmPickup : CollisionDetectionPickup, IPickupDistributorTrigger
	{
		private FirearmWorldmodel _worldmodelInstance;

		private Firearm _cachedTemplate;

		private bool _templateSet;

		private bool _instanceSpawned;

		public ItemIdentifier CurId => new ItemIdentifier(Info.ItemId, Info.Serial);

		public Firearm Template
		{
			get
			{
				if (!_templateSet)
				{
					if (!Info.ItemId.TryGetTemplate<Firearm>(out _cachedTemplate))
					{
						throw new InvalidOperationException($"Unable to create a pickup for {Info.ItemId} - this ID is not defined as a firearm.");
					}
					_templateSet = true;
				}
				return _cachedTemplate;
			}
		}

		public FirearmWorldmodel Worldmodel
		{
			get
			{
				if (!_instanceSpawned)
				{
					SpawnInstance();
				}
				return _worldmodelInstance;
			}
		}

		public void OnDistributed()
		{
			if (NetworkServer.active)
			{
				if (!AttachmentCodeSync.TryGet(Info.Serial, out var _))
				{
					AttachmentCodeSync.ServerSetCode(Info.Serial, AttachmentsUtils.GetRandomAttachmentsCode(Info.ItemId));
				}
				SubcomponentBase[] allSubcomponents = Template.AllSubcomponents;
				for (int i = 0; i < allSubcomponents.Length; i++)
				{
					allSubcomponents[i].ServerProcessMapgenDistribution(this);
				}
			}
		}

		public override PickupSearchCompletor GetPickupSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			if (!InventoryItemLoader.TryGetItem<ItemBase>(Info.ItemId, out var result))
			{
				return null;
			}
			return new FirearmSearchCompletor(coordinator.Hub, this, result, sqrDistance);
		}

		protected override void Start()
		{
			base.Start();
			AttachmentCodeSync.OnReceived += OnAttachmentsReceived;
			SpawnInstance();
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			AttachmentCodeSync.OnReceived -= OnAttachmentsReceived;
		}

		private void SpawnInstance()
		{
			if (!_instanceSpawned)
			{
				_worldmodelInstance = UnityEngine.Object.Instantiate(Template.WorldModel, base.transform);
				_worldmodelInstance.transform.ResetLocalPose();
				_worldmodelInstance.Setup(CurId, FirearmWorldmodelType.Pickup);
				_instanceSpawned = true;
			}
		}

		private void OnAttachmentsReceived(ushort serial, uint attId)
		{
			if (serial == Info.Serial && _instanceSpawned)
			{
				_worldmodelInstance.Setup(CurId, FirearmWorldmodelType.Pickup, attId);
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
