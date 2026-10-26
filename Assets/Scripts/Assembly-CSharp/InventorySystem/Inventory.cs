using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using InventorySystem.GUI;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using Mirror.RemoteCalls;
using NetworkManagerUtils.Dummies;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using RoundRestarting;
using UnityEngine;

namespace InventorySystem
{
	public class Inventory : NetworkBehaviour, IStaminaModifier, IMovementSpeedModifier, IRootDummyActionProvider, ISprintSpeedModifier
	{
		public const int MaxSlots = 8;

		public InventoryInfo UserInventory = new InventoryInfo();

		[SyncVar(hook = "OnItemUpdated")]
		public ItemIdentifier CurItem = ItemIdentifier.None;

		public bool SendItemsNextFrame;

		public bool SendAmmoNextFrame;

		private ItemIdentifier _prevCurItem;

		internal ReferenceHub _hub;

		private ItemBase _curInstance;

		private float _staminaModifier;

		private float _movementLimiter;

		private float _movementMultiplier;

		private float _sprintMultiplier;

		private bool _sprintingDisabled;

		private readonly Stopwatch _lastEquipSw = Stopwatch.StartNew();

		[SyncVar]
		private float _syncStaminaModifier;

		[SyncVar]
		private float _syncMovementLimiter;

		[SyncVar]
		private float _syncMovementMultiplier;

		[SyncVar]
		private float _syncSprintMultiplier;

		[HideInInspector]
		public ItemBase CurInstance
		{
			get
			{
				return _curInstance;
			}
			set
			{
				if (value == _curInstance)
				{
					return;
				}
				ItemBase curInstance = _curInstance;
				_curInstance = value;
				bool flag = _curInstance == null;
				if (curInstance != null)
				{
					curInstance.OnHolstered();
					curInstance.IsEquipped = false;
					if (base.isLocalPlayer)
					{
						curInstance.ViewModel.gameObject.SetActive(value: false);
						if (flag)
						{
							SharedHandsController.UpdateInstance(null);
						}
					}
				}
				if (_curInstance != null)
				{
					if (base.isLocalPlayer)
					{
						_curInstance.ViewModel.gameObject.SetActive(value: true);
						SharedHandsController.UpdateInstance(_curInstance.ViewModel);
						_curInstance.ViewModel.OnEquipped();
					}
					_curInstance.OnEquipped();
					_curInstance.IsEquipped = true;
				}
			}
		}

		public float LastItemSwitch => (float)_lastEquipSw.Elapsed.TotalSeconds;

		private Transform ItemWorkspace => SharedHandsController.Singleton.transform;

		public bool StaminaModifierActive => true;

		public bool MovementModifierActive => true;

		public float StaminaUsageMultiplier
		{
			get
			{
				if (!IsObserver)
				{
					return _staminaModifier;
				}
				return _syncStaminaModifier;
			}
		}

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled
		{
			get
			{
				if (!IsObserver)
				{
					return _sprintingDisabled;
				}
				return false;
			}
		}

		public float MovementSpeedMultiplier
		{
			get
			{
				if (!IsObserver)
				{
					return _movementMultiplier;
				}
				return _syncMovementMultiplier;
			}
		}

		public float MovementSpeedLimit
		{
			get
			{
				if (!IsObserver)
				{
					return _movementLimiter;
				}
				return _syncMovementLimiter;
			}
		}

		public bool SprintModifierActive => true;

		public float SprintSpeedMultiplier
		{
			get
			{
				if (!IsObserver)
				{
					return _sprintMultiplier;
				}
				return _syncSprintMultiplier;
			}
		}

		private bool IsObserver
		{
			get
			{
				if (!NetworkServer.active)
				{
					return !base.isLocalPlayer;
				}
				return false;
			}
		}

		private bool HasViewmodel
		{
			get
			{
				if (base.isLocalPlayer && CurInstance != null)
				{
					return CurInstance.ViewModel != null;
				}
				return false;
			}
		}

		public bool DummyActionsDirty { get; set; }

		public ItemIdentifier NetworkCurItem
		{
			get
			{
				return CurItem;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref CurItem, 1uL, OnItemUpdated);
			}
		}

		public float Network_syncStaminaModifier
		{
			get
			{
				return _syncStaminaModifier;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncStaminaModifier, 2uL, null);
			}
		}

		public float Network_syncMovementLimiter
		{
			get
			{
				return _syncMovementLimiter;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncMovementLimiter, 4uL, null);
			}
		}

		public float Network_syncMovementMultiplier
		{
			get
			{
				return _syncMovementMultiplier;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncMovementMultiplier, 8uL, null);
			}
		}

		public float Network_syncSprintMultiplier
		{
			get
			{
				return _syncSprintMultiplier;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncSprintMultiplier, 16uL, null);
			}
		}

		public static event Action<ReferenceHub> OnItemsModified;

		public static event Action<ReferenceHub> OnAmmoModified;

		public static event Action OnServerStarted;

		public static event Action OnLocalClientStarted;

		public static event Action<ReferenceHub, ItemIdentifier, ItemIdentifier> OnCurrentItemChanged;

		private void OnItemUpdated(ItemIdentifier prev, ItemIdentifier cur)
		{
			if (prev != cur)
			{
				_lastEquipSw.Restart();
			}
		}

		private void Awake()
		{
			_hub = ReferenceHub.GetHub(base.gameObject);
		}

		public override void OnStopClient()
		{
			base.OnStopClient();
			if (!NetworkServer.active || RoundRestart.IsRoundRestarting)
			{
				return;
			}
			HashSet<ushort> hashSet = HashSetPool<ushort>.Shared.Rent();
			foreach (KeyValuePair<ushort, ItemBase> item in UserInventory.Items)
			{
				hashSet.Add(item.Key);
			}
			foreach (ushort item2 in hashSet)
			{
				this.ServerRemoveItem(item2, null);
			}
			HashSetPool<ushort>.Shared.Return(hashSet);
		}

		private void Start()
		{
			if ((base.isLocalPlayer || NetworkServer.active) && base.isLocalPlayer)
			{
				if (NetworkServer.active)
				{
					OnServerStarted();
					CustomNetworkManager.InvokeOnClientReady();
				}
				OnLocalClientStarted?.Invoke();
			}
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				if (SendItemsNextFrame)
				{
					DummyActionsDirty = true;
					SendItemsNextFrame = false;
					OnItemsModified?.Invoke(_hub);
					ServerSendItems();
				}
				if (SendAmmoNextFrame)
				{
					DummyActionsDirty = true;
					SendAmmoNextFrame = false;
					OnAmmoModified?.Invoke(_hub);
					ServerSendAmmo();
				}
			}
			UpdateCurItem();
			if (!IsObserver)
			{
				UpdateObserverItems();
				RefreshModifiers();
				if (HasViewmodel && Input.GetKeyDown(NewInput.GetKey(ActionName.ThrowItem)) && CurInstance.AllowDropping && InventoryGuiController.ItemsSafeForInteraction)
				{
					CmdDropItem(CurItem.SerialNumber, tryThrow: true);
				}
			}
		}

		private void UpdateCurItem()
		{
			if (_prevCurItem == CurItem)
			{
				return;
			}
			DummyActionsDirty = true;
			if (base.isLocalPlayer)
			{
				if (CurItem.TypeId != ItemType.None)
				{
					if (!UserInventory.Items.TryGetValue(CurItem.SerialNumber, out var value))
					{
						return;
					}
					CurInstance = value;
				}
				else
				{
					CurInstance = null;
				}
			}
			OnCurrentItemChanged?.Invoke(_hub, _prevCurItem, CurItem);
			_prevCurItem = new ItemIdentifier(CurItem.TypeId, CurItem.SerialNumber);
		}

		private void UpdateObserverItems()
		{
			List<ushort> list = ListPool<ushort>.Shared.Rent();
			foreach (KeyValuePair<ushort, ItemBase> item in UserInventory.Items)
			{
				list.Add(item.Key);
			}
			foreach (ushort item2 in list)
			{
				if (UserInventory.Items.TryGetValue(item2, out var value) && value.enabled)
				{
					if (value.IsEquipped)
					{
						value.EquipUpdate();
					}
					value.AlwaysUpdate();
				}
			}
			ListPool<ushort>.Shared.Return(list);
		}

		private void RefreshModifiers()
		{
			_staminaModifier = 1f;
			_movementLimiter = float.MaxValue;
			_movementMultiplier = 1f;
			_sprintMultiplier = 1f;
			_sprintingDisabled = false;
			foreach (KeyValuePair<ushort, ItemBase> item in UserInventory.Items)
			{
				object mobilityController = item.Value.GetMobilityController();
				if (mobilityController is IStaminaModifier { StaminaModifierActive: not false } staminaModifier)
				{
					_staminaModifier *= staminaModifier.StaminaUsageMultiplier;
					_sprintingDisabled |= staminaModifier.SprintingDisabled;
				}
				if (mobilityController is IMovementSpeedModifier { MovementModifierActive: not false } movementSpeedModifier)
				{
					_movementLimiter = Mathf.Min(_movementLimiter, movementSpeedModifier.MovementSpeedLimit);
					_movementMultiplier *= movementSpeedModifier.MovementSpeedMultiplier;
				}
				if (mobilityController is ISprintSpeedModifier { SprintModifierActive: not false } sprintSpeedModifier)
				{
					_sprintMultiplier *= sprintSpeedModifier.SprintSpeedMultiplier;
				}
			}
			if (NetworkServer.active)
			{
				Network_syncStaminaModifier = _staminaModifier;
				Network_syncMovementMultiplier = _movementMultiplier;
				Network_syncMovementLimiter = _movementLimiter;
				Network_syncSprintMultiplier = _sprintMultiplier;
			}
		}

		[Server]
		public void ServerSelectItem(ushort itemSerial)
		{
			if (!NetworkServer.active)
			{
				UnityEngine.Debug.LogWarning("[Server] function 'System.Void InventorySystem.Inventory::ServerSelectItem(System.UInt16)' called when server was not active");
			}
			else
			{
				if (itemSerial == CurItem.SerialNumber)
				{
					return;
				}
				ItemBase value = null;
				ItemBase value2 = null;
				bool flag = CurItem.SerialNumber == 0 || (UserInventory.Items.TryGetValue(CurItem.SerialNumber, out value) && CurInstance != null);
				if (itemSerial == 0 || UserInventory.Items.TryGetValue(itemSerial, out value2))
				{
					if ((((CurItem.SerialNumber != 0) & flag) && !value.AllowHolster) || (itemSerial != 0 && !value2.AllowEquip))
					{
						return;
					}
					PlayerChangingItemEventArgs e = new PlayerChangingItemEventArgs(_hub, value, value2);
					PlayerEvents.OnChangingItem(e);
					if (!e.IsAllowed)
					{
						return;
					}
					if (itemSerial == 0)
					{
						NetworkCurItem = ItemIdentifier.None;
						if (!base.isLocalPlayer)
						{
							CurInstance = null;
						}
					}
					else
					{
						NetworkCurItem = new ItemIdentifier(value2.ItemTypeId, itemSerial);
						if (!base.isLocalPlayer)
						{
							CurInstance = value2;
						}
					}
					PlayerEvents.OnChangedItem(new PlayerChangedItemEventArgs(_hub, value, value2));
				}
				else if (!flag)
				{
					NetworkCurItem = ItemIdentifier.None;
					if (!base.isLocalPlayer)
					{
						CurInstance = null;
					}
				}
			}
		}

		public void ClientSelectItem(ushort itemSerial)
		{
			if (CurInstance != null && CurInstance.ItemSerial != itemSerial)
			{
				CurInstance.OnHolsterRequestSent();
			}
			CmdSelectItem(itemSerial);
		}

		public void ClientDropItem(ushort itemSerial, bool tryThrow)
		{
			if (CurInstance != null && CurInstance.ItemSerial == itemSerial)
			{
				CurInstance.OnHolsterRequestSent();
			}
			CmdDropItem(itemSerial, tryThrow);
		}

		[Server]
		private void ServerSendItems()
		{
			if (!NetworkServer.active)
			{
				UnityEngine.Debug.LogWarning("[Server] function 'System.Void InventorySystem.Inventory::ServerSendItems()' called when server was not active");
			}
			else
			{
				if (base.isLocalPlayer)
				{
					return;
				}
				HashSet<ItemIdentifier> hashSet = HashSetPool<ItemIdentifier>.Shared.Rent();
				foreach (KeyValuePair<ushort, ItemBase> item in UserInventory.Items)
				{
					hashSet.Add(new ItemIdentifier(item.Value.ItemTypeId, item.Key));
				}
				TargetRefreshItems(hashSet.ToArray());
				HashSetPool<ItemIdentifier>.Shared.Return(hashSet);
			}
		}

		[Server]
		private void ServerSendAmmo()
		{
			if (!NetworkServer.active)
			{
				UnityEngine.Debug.LogWarning("[Server] function 'System.Void InventorySystem.Inventory::ServerSendAmmo()' called when server was not active");
			}
			else
			{
				if (base.isLocalPlayer)
				{
					return;
				}
				List<byte> list = ListPool<byte>.Shared.Rent();
				List<ushort> list2 = ListPool<ushort>.Shared.Rent();
				foreach (KeyValuePair<ItemType, ushort> item in UserInventory.ReserveAmmo)
				{
					list.Add((byte)item.Key);
					list2.Add(item.Value);
				}
				TargetRefreshAmmo(list.ToArray(), list2.ToArray());
				ListPool<byte>.Shared.Return(list);
				ListPool<ushort>.Shared.Return(list2);
			}
		}

		[TargetRpc]
		private void TargetRefreshItems(ItemIdentifier[] ids)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			GeneratedNetworkCode._Write_InventorySystem_002EItems_002EItemIdentifier_005B_005D(writer, ids);
			SendTargetRPCInternal(null, "System.Void InventorySystem.Inventory::TargetRefreshItems(InventorySystem.Items.ItemIdentifier[])", 924996253, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[TargetRpc]
		private void TargetRefreshAmmo(byte[] keys, ushort[] values)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteBytesAndSize(keys);
			GeneratedNetworkCode._Write_System_002EUInt16_005B_005D(writer, values);
			SendTargetRPCInternal(null, "System.Void InventorySystem.Inventory::TargetRefreshAmmo(System.Byte[],System.UInt16[])", 1974569553, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[Command]
		private void CmdSelectItem(ushort itemSerial)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteUShort(itemSerial);
			SendCommandInternal("System.Void InventorySystem.Inventory::CmdSelectItem(System.UInt16)", 599991551, writer, 0);
			NetworkWriterPool.Return(writer);
		}

		[Command(channel = 4)]
		private void CmdConfirmAcquisition(ushort[] itemSerials)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			GeneratedNetworkCode._Write_System_002EUInt16_005B_005D(writer, itemSerials);
			SendCommandInternal("System.Void InventorySystem.Inventory::CmdConfirmAcquisition(System.UInt16[])", 1903294111, writer, 4);
			NetworkWriterPool.Return(writer);
		}

		[Command(channel = 4)]
		private void CmdDropItem(ushort itemSerial, bool tryThrow)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteUShort(itemSerial);
			writer.WriteBool(tryThrow);
			SendCommandInternal("System.Void InventorySystem.Inventory::CmdDropItem(System.UInt16,System.Boolean)", -146885871, writer, 4);
			NetworkWriterPool.Return(writer);
		}

		[Command(channel = 4)]
		public void CmdDropAmmo(byte ammoType, ushort amount)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			NetworkWriterExtensions.WriteByte(writer, ammoType);
			writer.WriteUShort(amount);
			SendCommandInternal("System.Void InventorySystem.Inventory::CmdDropAmmo(System.Byte,System.UInt16)", 1230737334, writer, 4);
			NetworkWriterPool.Return(writer);
		}

		public ItemBase CreateItemInstance(ItemIdentifier identifier, bool updateViewmodel)
		{
			if (!InventoryItemLoader.AvailableItems.TryGetValue(identifier.TypeId, out var value))
			{
				return null;
			}
			ItemBase itemBase = UnityEngine.Object.Instantiate(value, ItemWorkspace);
			itemBase.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
			itemBase.Owner = _hub;
			itemBase.ItemSerial = identifier.SerialNumber;
			if (updateViewmodel && itemBase.ViewModel != null)
			{
				ItemViewmodelBase itemViewmodelBase = UnityEngine.Object.Instantiate(itemBase.ViewModel, itemBase.transform);
				itemViewmodelBase.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
				itemViewmodelBase.InitLocal(itemBase);
				itemViewmodelBase.gameObject.SetActive(value: false);
				itemBase.ViewModel = itemViewmodelBase;
			}
			return itemBase;
		}

		public bool DestroyItemInstance(ushort targetInstance, ItemPickupBase pickup, out ItemBase foundItem)
		{
			if (!UserInventory.Items.TryGetValue(targetInstance, out foundItem))
			{
				return false;
			}
			foundItem.OnRemoved(pickup);
			if (CurInstance == foundItem)
			{
				CurInstance = null;
			}
			UnityEngine.Object.Destroy(foundItem.gameObject);
			return true;
		}

		public void PopulateDummyActions(Action<DummyAction> actionAdder, Action<string> categoryAdder)
		{
			DummyActionsDirty = false;
			foreach (KeyValuePair<ushort, ItemBase> item in UserInventory.Items)
			{
				ItemBase value = item.Value;
				IDummyActionProvider[] componentsInChildren = value.GetComponentsInChildren<IDummyActionProvider>();
				categoryAdder($"{value.ItemTypeId} (#{value.ItemSerial})");
				PopulateDummyAction(value, componentsInChildren, actionAdder);
				categoryAdder($"{value.ItemTypeId} (ANY)");
				PopulateDummyAction(value, componentsInChildren, actionAdder);
			}
		}

		private void PopulateDummyAction(ItemBase ib, IDummyActionProvider[] providers, Action<DummyAction> actionAdder)
		{
			if (ib.AllowEquip && !ib.IsEquipped)
			{
				actionAdder(new DummyAction("Equip", () =>
				{
					ServerSelectItem(ib.ItemSerial);
				}));
			}
			if (ib.AllowHolster && ib.IsEquipped)
			{
				actionAdder(new DummyAction("Holster", () =>
				{
					ServerSelectItem(0);
				}));
			}
			if (ib.AllowDropping)
			{
				actionAdder(new DummyAction("Drop", () =>
				{
					ib.ServerDropItem(spawn: true);
				}));
			}
			for (int num = 0; num < providers.Length; num++)
			{
				providers[num].PopulateDummyActions(actionAdder);
			}
		}

		static Inventory()
		{
			OnItemsModified = (ReferenceHub userHub) =>
			{
			};
			OnAmmoModified = (ReferenceHub userHub) =>
			{
			};
			OnCurrentItemChanged = (ReferenceHub userHub, ItemIdentifier prevItem, ItemIdentifier newItem) =>
			{
			};
			RemoteProcedureCalls.RegisterCommand(typeof(Inventory), "System.Void InventorySystem.Inventory::CmdSelectItem(System.UInt16)", InvokeUserCode_CmdSelectItem__UInt16, requiresAuthority: true);
			RemoteProcedureCalls.RegisterCommand(typeof(Inventory), "System.Void InventorySystem.Inventory::CmdConfirmAcquisition(System.UInt16[])", InvokeUserCode_CmdConfirmAcquisition__UInt16_005B_005D, requiresAuthority: true);
			RemoteProcedureCalls.RegisterCommand(typeof(Inventory), "System.Void InventorySystem.Inventory::CmdDropItem(System.UInt16,System.Boolean)", InvokeUserCode_CmdDropItem__UInt16__Boolean, requiresAuthority: true);
			RemoteProcedureCalls.RegisterCommand(typeof(Inventory), "System.Void InventorySystem.Inventory::CmdDropAmmo(System.Byte,System.UInt16)", InvokeUserCode_CmdDropAmmo__Byte__UInt16, requiresAuthority: true);
			RemoteProcedureCalls.RegisterRpc(typeof(Inventory), "System.Void InventorySystem.Inventory::TargetRefreshItems(InventorySystem.Items.ItemIdentifier[])", InvokeUserCode_TargetRefreshItems__ItemIdentifier_005B_005D);
			RemoteProcedureCalls.RegisterRpc(typeof(Inventory), "System.Void InventorySystem.Inventory::TargetRefreshAmmo(System.Byte[],System.UInt16[])", InvokeUserCode_TargetRefreshAmmo__Byte_005B_005D__UInt16_005B_005D);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_TargetRefreshItems__ItemIdentifier_005B_005D(ItemIdentifier[] ids)
		{
			Queue<ItemIdentifier> queue = new Queue<ItemIdentifier>();
			List<ushort> list = UserInventory.Items.Keys.ToList();
			int num = 0;
			for (int i = 0; i < ids.Length; i++)
			{
				ItemIdentifier item = ids[i];
				if (!UserInventory.Items.ContainsKey(item.SerialNumber))
				{
					queue.Enqueue(item);
				}
				list.Remove(item.SerialNumber);
			}
			while (list.Count > 0)
			{
				DestroyItemInstance(list[0], null, out var _);
				UserInventory.Items.Remove(list[0]);
				list.RemoveAt(0);
				num++;
			}
			List<ushort> list2 = ListPool<ushort>.Shared.Rent();
			while (queue.Count > 0)
			{
				ItemIdentifier itemIdentifier = queue.Dequeue();
				ItemBase itemBase = CreateItemInstance(itemIdentifier, updateViewmodel: true);
				UserInventory.Items[itemIdentifier.SerialNumber] = itemBase;
				itemBase.OnAdded(null);
				if (itemBase is IAcquisitionConfirmationTrigger)
				{
					list2.Add(itemIdentifier.SerialNumber);
				}
				if (itemIdentifier == CurItem)
				{
					CurInstance = itemBase;
				}
				num++;
			}
			if (list2.Count > 0)
			{
				CmdConfirmAcquisition(list2.ToArray());
			}
			ListPool<ushort>.Shared.Return(list2);
			if (num > 0 && base.isLocalPlayer)
			{
				OnItemsModified?.Invoke(_hub);
			}
		}

		protected static void InvokeUserCode_TargetRefreshItems__ItemIdentifier_005B_005D(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				UnityEngine.Debug.LogError("TargetRPC TargetRefreshItems called on server.");
			}
			else
			{
				((Inventory)obj).UserCode_TargetRefreshItems__ItemIdentifier_005B_005D(GeneratedNetworkCode._Read_InventorySystem_002EItems_002EItemIdentifier_005B_005D(reader));
			}
		}

		protected void UserCode_TargetRefreshAmmo__Byte_005B_005D__UInt16_005B_005D(byte[] keys, ushort[] values)
		{
			if (keys.Length == values.Length)
			{
				UserInventory.ReserveAmmo.Clear();
				for (int i = 0; i < keys.Length; i++)
				{
					UserInventory.ReserveAmmo[(ItemType)keys[i]] = values[i];
				}
				OnAmmoModified?.Invoke(_hub);
			}
		}

		protected static void InvokeUserCode_TargetRefreshAmmo__Byte_005B_005D__UInt16_005B_005D(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				UnityEngine.Debug.LogError("TargetRPC TargetRefreshAmmo called on server.");
			}
			else
			{
				((Inventory)obj).UserCode_TargetRefreshAmmo__Byte_005B_005D__UInt16_005B_005D(reader.ReadBytesAndSize(), GeneratedNetworkCode._Read_System_002EUInt16_005B_005D(reader));
			}
		}

		protected void UserCode_CmdSelectItem__UInt16(ushort itemSerial)
		{
			if (!_hub.interCoordinator.AnyBlocker(BlockedInteraction.OpenInventory))
			{
				ServerSelectItem(itemSerial);
			}
		}

		protected static void InvokeUserCode_CmdSelectItem__UInt16(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkServer.active)
			{
				UnityEngine.Debug.LogError("Command CmdSelectItem called on client.");
			}
			else
			{
				((Inventory)obj).UserCode_CmdSelectItem__UInt16(reader.ReadUShort());
			}
		}

		protected void UserCode_CmdConfirmAcquisition__UInt16_005B_005D(ushort[] itemSerials)
		{
			foreach (ushort key in itemSerials)
			{
				if (UserInventory.Items.TryGetValue(key, out var value) && value is IAcquisitionConfirmationTrigger { AcquisitionAlreadyReceived: false } acquisitionConfirmationTrigger)
				{
					acquisitionConfirmationTrigger.ServerConfirmAcqusition();
					acquisitionConfirmationTrigger.AcquisitionAlreadyReceived = true;
				}
			}
		}

		protected static void InvokeUserCode_CmdConfirmAcquisition__UInt16_005B_005D(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkServer.active)
			{
				UnityEngine.Debug.LogError("Command CmdConfirmAcquisition called on client.");
			}
			else
			{
				((Inventory)obj).UserCode_CmdConfirmAcquisition__UInt16_005B_005D(GeneratedNetworkCode._Read_System_002EUInt16_005B_005D(reader));
			}
		}

		protected void UserCode_CmdDropItem__UInt16__Boolean(ushort itemSerial, bool tryThrow)
		{
			if (!UserInventory.Items.TryGetValue(itemSerial, out var value) || !value.AllowDropping)
			{
				return;
			}
			PlayerDroppingItemEventArgs e = new PlayerDroppingItemEventArgs(_hub, value, tryThrow);
			PlayerEvents.OnDroppingItem(e);
			if (!e.IsAllowed)
			{
				return;
			}
			tryThrow = e.Throw;
			ItemPickupBase itemPickupBase = this.ServerDropItem(itemSerial);
			PlayerDroppedItemEventArgs e2 = new PlayerDroppedItemEventArgs(_hub, itemPickupBase, tryThrow);
			PlayerEvents.OnDroppedItem(e2);
			tryThrow = e2.Throw;
			SendItemsNextFrame = true;
			if (!tryThrow || itemPickupBase == null || !itemPickupBase.TryGetComponent<Rigidbody>(out var component))
			{
				return;
			}
			PlayerThrowingItemEventArgs e3 = new PlayerThrowingItemEventArgs(_hub, itemPickupBase, component);
			PlayerEvents.OnThrowingItem(e3);
			if (!e3.IsAllowed)
			{
				this.ServerAddItem(itemPickupBase.ItemId.TypeId, ItemAddReason.PickedUp, itemPickupBase.Info.Serial, itemPickupBase);
				itemPickupBase.DestroySelf();
				return;
			}
			Vector3 velocity = _hub.GetVelocity();
			Vector3 linearVelocity = velocity / 3f + _hub.PlayerCameraReference.forward * 6f * (Mathf.Clamp01(Mathf.InverseLerp(7f, 0.1f, component.mass)) + 0.3f);
			linearVelocity.x = Mathf.Max(Mathf.Abs(velocity.x), Mathf.Abs(linearVelocity.x)) * (float)((!(linearVelocity.x < 0f)) ? 1 : (-1));
			linearVelocity.y = Mathf.Max(Mathf.Abs(velocity.y), Mathf.Abs(linearVelocity.y)) * (float)((!(linearVelocity.y < 0f)) ? 1 : (-1));
			linearVelocity.z = Mathf.Max(Mathf.Abs(velocity.z), Mathf.Abs(linearVelocity.z)) * (float)((!(linearVelocity.z < 0f)) ? 1 : (-1));
			component.position = _hub.PlayerCameraReference.position;
			component.linearVelocity = linearVelocity;
			component.angularVelocity = Vector3.Lerp(value.ThrowSettings.RandomTorqueA, value.ThrowSettings.RandomTorqueB, UnityEngine.Random.value);
			float magnitude = component.angularVelocity.magnitude;
			if (magnitude > component.maxAngularVelocity)
			{
				component.maxAngularVelocity = magnitude;
			}
			PlayerEvents.OnThrewItem(new PlayerThrewItemEventArgs(_hub, itemPickupBase, component));
		}

		protected static void InvokeUserCode_CmdDropItem__UInt16__Boolean(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkServer.active)
			{
				UnityEngine.Debug.LogError("Command CmdDropItem called on client.");
			}
			else
			{
				((Inventory)obj).UserCode_CmdDropItem__UInt16__Boolean(reader.ReadUShort(), reader.ReadBool());
			}
		}

		protected void UserCode_CmdDropAmmo__Byte__UInt16(byte ammoType, ushort amount)
		{
			this.ServerDropAmmo((ItemType)ammoType, amount, checkMinimals: true);
		}

		protected static void InvokeUserCode_CmdDropAmmo__Byte__UInt16(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkServer.active)
			{
				UnityEngine.Debug.LogError("Command CmdDropAmmo called on client.");
			}
			else
			{
				((Inventory)obj).UserCode_CmdDropAmmo__Byte__UInt16(NetworkReaderExtensions.ReadByte(reader), reader.ReadUShort());
			}
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				GeneratedNetworkCode._Write_InventorySystem_002EItems_002EItemIdentifier(writer, CurItem);
				writer.WriteFloat(_syncStaminaModifier);
				writer.WriteFloat(_syncMovementLimiter);
				writer.WriteFloat(_syncMovementMultiplier);
				writer.WriteFloat(_syncSprintMultiplier);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				GeneratedNetworkCode._Write_InventorySystem_002EItems_002EItemIdentifier(writer, CurItem);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteFloat(_syncStaminaModifier);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				writer.WriteFloat(_syncMovementLimiter);
			}
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteFloat(_syncMovementMultiplier);
			}
			if ((base.syncVarDirtyBits & 0x10L) != 0L)
			{
				writer.WriteFloat(_syncSprintMultiplier);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref CurItem, OnItemUpdated, GeneratedNetworkCode._Read_InventorySystem_002EItems_002EItemIdentifier(reader));
				GeneratedSyncVarDeserialize(ref _syncStaminaModifier, null, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref _syncMovementLimiter, null, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref _syncMovementMultiplier, null, reader.ReadFloat());
				GeneratedSyncVarDeserialize(ref _syncSprintMultiplier, null, reader.ReadFloat());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref CurItem, OnItemUpdated, GeneratedNetworkCode._Read_InventorySystem_002EItems_002EItemIdentifier(reader));
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncStaminaModifier, null, reader.ReadFloat());
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncMovementLimiter, null, reader.ReadFloat());
			}
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncMovementMultiplier, null, reader.ReadFloat());
			}
			if ((num & 0x10L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncSprintMultiplier, null, reader.ReadFloat());
			}
		}
	}
}
