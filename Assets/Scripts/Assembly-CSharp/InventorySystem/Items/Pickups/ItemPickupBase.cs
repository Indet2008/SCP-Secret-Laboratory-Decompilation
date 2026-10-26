using System;
using System.Runtime.InteropServices;
using CustomPlayerEffects;
using Footprinting;
using InventorySystem.Searching;
using Mirror;
using Mirror.RemoteCalls;
using RoundRestarting;
using UnityEngine;

namespace InventorySystem.Items.Pickups
{
	[RequireComponent(typeof(Rigidbody))]
	public abstract class ItemPickupBase : NetworkBehaviour, IIdentifierProvider, ISearchable
	{
		private const float MinimalPickupTime = 0.245f;

		private const float WeightToTime = 0.175f;

		[SyncVar(hook = "InfoReceivedHook")]
		public PickupSyncInfo Info = PickupSyncInfo.None;

		public SyncList<byte> PhysicsModuleSyncData = new SyncList<byte>();

		public Footprint PreviousOwner;

		private Transform _transform;

		private bool _transformCacheSet;

		private bool _wasServer;

		protected virtual PickupPhysicsModule DefaultPhysicsModule => new PickupStandardPhysics(this);

		public PickupPhysicsModule PhysicsModule { get; protected set; }

		public ItemIdentifier ItemId => new ItemIdentifier(Info.ItemId, Info.Serial);

		public bool CanSearch
		{
			get
			{
				if (!Info.Locked)
				{
					return !Info.InUse;
				}
				return false;
			}
		}

		public Vector3 Position
		{
			get
			{
				return CachedTransform.position;
			}
			set
			{
				CachedTransform.position = value;
			}
		}

		public Quaternion Rotation
		{
			get
			{
				return CachedTransform.rotation;
			}
			set
			{
				CachedTransform.rotation = value;
			}
		}

		private Transform CachedTransform
		{
			get
			{
				if (!_transformCacheSet)
				{
					_transformCacheSet = true;
					_transform = base.transform;
				}
				return _transform;
			}
		}

		public PickupSyncInfo NetworkInfo
		{
			get
			{
				return Info;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Info, 1uL, InfoReceivedHook);
			}
		}

		NetworkIdentity ISearchable.netIdentity => base.netIdentity;

		public static event Action<ItemPickupBase> OnPickupAdded;

		public static event Action<ItemPickupBase> OnPickupDestroyed;

		public static event Action<ItemPickupBase> OnBeforePickupDestroyed;

		public event Action OnPickupStartClient;

		public event Action OnInfoChanged;

		public event Action<PickupSyncInfo, PickupSyncInfo> OnInfoChangedPrevNew;

		private void InfoReceivedHook(PickupSyncInfo oldInfo, PickupSyncInfo newInfo)
		{
			OnInfoChanged?.Invoke();
			OnInfoChangedPrevNew?.Invoke(oldInfo, newInfo);
		}

		public virtual float SearchTimeForPlayer(ReferenceHub hub)
		{
			float num = 0.245f + 0.175f * Info.WeightKg;
			StatusEffectBase[] allEffects = hub.playerEffectsController.AllEffects;
			foreach (StatusEffectBase statusEffectBase in allEffects)
			{
				if (statusEffectBase.IsEnabled && statusEffectBase is ISearchTimeModifier searchTimeModifier)
				{
					num = searchTimeModifier.ProcessSearchTime(num);
				}
			}
			if (hub.inventory.CurInstance is ISearchTimeModifier searchTimeModifier2 && searchTimeModifier2 != null)
			{
				num = searchTimeModifier2.ProcessSearchTime(num);
			}
			return num;
		}

		public ISearchCompletor GetSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			return GetPickupSearchCompletor(coordinator, sqrDistance);
		}

		public virtual PickupSearchCompletor GetPickupSearchCompletor(SearchCoordinator coordinator, float sqrDistance)
		{
			if (!InventoryItemLoader.TryGetItem<ItemBase>(Info.ItemId, out var result))
			{
				return null;
			}
			return new ItemSearchCompletor(coordinator.Hub, this, result, sqrDistance);
		}

		public bool ServerValidateRequest(NetworkConnection source, SearchSessionPipe session)
		{
			if (Info.Locked)
			{
				session.Invalidate();
				source?.identity.GetComponent<GameConsoleTransmission>().SendToClient("Pickup request rejected - target is locked.", "red");
				return false;
			}
			if (Info.InUse)
			{
				session.Invalidate();
				source?.identity.GetComponent<GameConsoleTransmission>().SendToClient("Pickup request rejected - target is in use.", "red");
				return false;
			}
			PickupSyncInfo info = Info;
			info.InUse = true;
			NetworkInfo = info;
			return true;
		}

		public void ServerHandleAbort(ReferenceHub hub)
		{
			PickupSyncInfo info = Info;
			info.InUse = false;
			NetworkInfo = info;
		}

		[Server]
		public void DestroySelf()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void InventorySystem.Items.Pickups.ItemPickupBase::DestroySelf()' called when server was not active");
			}
			else
			{
				NetworkServer.Destroy(base.gameObject);
			}
		}

		[ClientRpc]
		internal virtual void SendPhysicsModuleRpc(ArraySegment<byte> arrSeg)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteArraySegmentAndSize(arrSeg);
			SendRPCInternal("System.Void InventorySystem.Items.Pickups.ItemPickupBase::SendPhysicsModuleRpc(System.ArraySegment`1<System.Byte>)", 254399230, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		protected virtual void Awake()
		{
			PhysicsModule = DefaultPhysicsModule;
		}

		protected virtual void Start()
		{
			OnPickupAdded?.Invoke(this);
			if (NetworkServer.active)
			{
				_wasServer = true;
				RoundRestart.OnRestartTriggered += DestroySelf;
			}
		}

		protected virtual void OnDestroy()
		{
			PhysicsModule?.DestroyModule();
			OnPickupDestroyed?.Invoke(this);
			if (_wasServer)
			{
				RoundRestart.OnRestartTriggered -= DestroySelf;
			}
		}

		public override void OnStartClient()
		{
			base.OnStartClient();
			OnPickupStartClient?.Invoke();
		}

		public override void OnStopClient()
		{
			base.OnStopClient();
			OnBeforePickupDestroyed?.Invoke(this);
		}

		protected ItemPickupBase()
		{
			InitSyncObject(PhysicsModuleSyncData);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected virtual void UserCode_SendPhysicsModuleRpc__ArraySegment_00601(ArraySegment<byte> arrSeg)
		{
			using NetworkReaderPooled rpcData = NetworkReaderPool.Get(arrSeg);
			PhysicsModule?.ClientProcessRpc(rpcData);
		}

		protected static void InvokeUserCode_SendPhysicsModuleRpc__ArraySegment_00601(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC SendPhysicsModuleRpc called on server.");
			}
			else
			{
				((ItemPickupBase)obj).UserCode_SendPhysicsModuleRpc__ArraySegment_00601(reader.ReadArraySegmentAndSize());
			}
		}

		static ItemPickupBase()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(ItemPickupBase), "System.Void InventorySystem.Items.Pickups.ItemPickupBase::SendPhysicsModuleRpc(System.ArraySegment`1<System.Byte>)", InvokeUserCode_SendPhysicsModuleRpc__ArraySegment_00601);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WritePickupSyncInfo(Info);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WritePickupSyncInfo(Info);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref Info, InfoReceivedHook, reader.ReadPickupSyncInfo());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Info, InfoReceivedHook, reader.ReadPickupSyncInfo());
			}
		}
	}
}
