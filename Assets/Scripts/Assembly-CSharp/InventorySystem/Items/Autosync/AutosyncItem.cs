using System;
using System.Collections.Generic;
using InventorySystem.GUI;
using InventorySystem.Items.Pickups;
using Mirror;
using NetworkManagerUtils.Dummies;
using UnityEngine;

namespace InventorySystem.Items.Autosync
{
	public abstract class AutosyncItem : ItemBase, IAcquisitionConfirmationTrigger, IAutosyncReceiver, IDummyActionProvider
	{
		private DummyKeyEmulator _dummyEmulator;

		public static readonly HashSet<AutosyncItem> Instances = new HashSet<AutosyncItem>();

		private DummyKeyEmulator DummyEmulator
		{
			get
			{
				if (_dummyEmulator == null)
				{
					_dummyEmulator = new DummyKeyEmulator(base.OwnerInventory);
				}
				return _dummyEmulator;
			}
		}

		private bool IsEmulatedDummy
		{
			get
			{
				if (NetworkServer.active)
				{
					return IsDummy;
				}
				return false;
			}
		}

		public bool AcquisitionAlreadyReceived { get; set; }

		public virtual bool HasViewmodel => ViewModel != null;

		public bool IsSpectator
		{
			get
			{
				if (HasViewmodel)
				{
					return ViewModel.IsSpectator;
				}
				return false;
			}
		}

		public bool IsControllable
		{
			get
			{
				if (!IsLocalPlayer)
				{
					return IsEmulatedDummy;
				}
				return true;
			}
		}

		public virtual void ServerConfirmAcqusition()
		{
		}

		public virtual void ServerProcessCmd(NetworkReader reader)
		{
		}

		public virtual void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
		}

		public virtual void ClientProcessRpcInstance(NetworkReader reader)
		{
		}

		protected void ClientSendCmd(Action<NetworkWriter> extraData = null)
		{
			NetworkWriter writer;
			using (new AutosyncCmd(base.ItemId, out writer))
			{
				extraData?.Invoke(writer);
			}
		}

		protected void ServerSendPublicRpc(Action<NetworkWriter> extraData = null)
		{
			NetworkWriter writer;
			using (new AutosyncRpc(base.ItemId, out writer))
			{
				extraData?.Invoke(writer);
			}
		}

		protected void ServerSendPrivateRpc(Action<NetworkWriter> extraData = null)
		{
			NetworkWriter writer;
			using (new AutosyncRpc(base.ItemId, base.Owner, out writer))
			{
				extraData?.Invoke(writer);
			}
		}

		protected void ServerSendTargetRpc(ReferenceHub receiver, Action<NetworkWriter> extraData = null)
		{
			NetworkWriter writer;
			using (new AutosyncRpc(base.ItemId, receiver, out writer))
			{
				extraData?.Invoke(writer);
			}
		}

		protected void ServerSendConditionalRpc(Func<ReferenceHub, bool> receiveCondition, Action<NetworkWriter> extraData = null)
		{
			NetworkWriter writer;
			using (new AutosyncRpc(base.ItemId, receiveCondition, out writer))
			{
				extraData?.Invoke(writer);
			}
		}

		public bool GetActionDown(ActionName action)
		{
			if (!IsEmulatedDummy)
			{
				return GetRegularUserInput(Input.GetKeyDown, action);
			}
			return DummyEmulator.GetAction(action, firstFrameOnly: true);
		}

		public bool GetAction(ActionName action)
		{
			if (!IsEmulatedDummy)
			{
				return GetRegularUserInput(Input.GetKey, action);
			}
			return DummyEmulator.GetAction(action, firstFrameOnly: false);
		}

		private bool GetRegularUserInput(Func<KeyCode, bool> func, ActionName action)
		{
			if (IsLocalPlayer && InventoryGuiController.ItemsSafeForInteraction)
			{
				return func(NewInput.GetKey(action));
			}
			return false;
		}

		protected virtual void Awake()
		{
			Instances.Add(this);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			Instances.Remove(this);
		}

		protected virtual void LateUpdate()
		{
			if (IsEmulatedDummy)
			{
				DummyEmulator.LateUpdate();
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			Instances.Remove(this);
		}

		public virtual void PopulateDummyActions(Action<DummyAction> actionAdder)
		{
			DummyEmulator.PopulateDummyActions(actionAdder);
		}
	}
}
