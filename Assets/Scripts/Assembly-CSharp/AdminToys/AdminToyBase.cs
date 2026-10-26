using System;
using System.Runtime.InteropServices;
using Footprinting;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

namespace AdminToys
{
	public abstract class AdminToyBase : NetworkBehaviour
	{
		[SyncVar]
		public Vector3 Position;

		[SyncVar]
		public Quaternion Rotation;

		[SyncVar]
		public Vector3 Scale;

		[SyncVar]
		public byte MovementSmoothing;

		[SyncVar]
		public bool IsStatic;

		private uint _clientParentId;

		private Transform _previousParent;

		private Transform _trCache;

		private const float SmoothingMultiplier = 0.3f;

		public abstract string CommandName { get; }

		public Footprint SpawnerFootprint { get; private set; }

		public Vector3 RotationEuler
		{
			get
			{
				return Rotation.eulerAngles;
			}
			set
			{
				NetworkRotation = Quaternion.Euler(value);
			}
		}

		public Transform CachedTransform
		{
			get
			{
				if ((object)_trCache == null)
				{
					_trCache = base.transform;
				}
				return _trCache;
			}
		}

		public Vector3 NetworkPosition
		{
			get
			{
				return Position;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Position, 1uL, null);
			}
		}

		public Quaternion NetworkRotation
		{
			get
			{
				return Rotation;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Rotation, 2uL, null);
			}
		}

		public Vector3 NetworkScale
		{
			get
			{
				return Scale;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref Scale, 4uL, null);
			}
		}

		public byte NetworkMovementSmoothing
		{
			get
			{
				return MovementSmoothing;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref MovementSmoothing, 8uL, null);
			}
		}

		public bool NetworkIsStatic
		{
			get
			{
				return IsStatic;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref IsStatic, 16uL, null);
			}
		}

		public static event Action<AdminToyBase> OnAdded;

		public static event Action<AdminToyBase> OnRemoved;

		protected virtual void Start()
		{
			OnAdded?.Invoke(this);
		}

		protected virtual void LateUpdate()
		{
			if (!IsStatic)
			{
				if (NetworkServer.active)
				{
					UpdatePositionServer();
				}
				else
				{
					UpdatePositionClient();
				}
			}
		}

		protected void OnTransformParentChanged()
		{
			if (base.netIdentity.isServer)
			{
				Transform parent = CachedTransform.parent;
				if (_previousParent != parent)
				{
					RpcChangeParent(ServerParentId(parent));
					_previousParent = parent;
				}
			}
		}

		protected virtual void OnDestroy()
		{
			OnRemoved?.Invoke(this);
		}

		public override void OnStartServer()
		{
			base.OnStartServer();
			UpdatePositionServer();
		}

		public override void OnStartClient()
		{
			base.OnStartClient();
			if (!NetworkServer.active)
			{
				UpdateParent();
				UpdatePositionClient(teleport: true);
			}
		}

		public override void OnSerialize(NetworkWriter writer, bool initialState)
		{
			base.OnSerialize(writer, initialState);
			if (initialState)
			{
				writer.WriteUInt(ServerParentId(CachedTransform.parent));
			}
		}

		public override void OnDeserialize(NetworkReader reader, bool initialState)
		{
			base.OnDeserialize(reader, initialState);
			if (initialState)
			{
				_clientParentId = reader.ReadUInt();
			}
		}

		public virtual void OnSpawned(ReferenceHub admin, ArraySegment<string> arguments)
		{
			SpawnerFootprint = new Footprint(admin);
			NetworkServer.Spawn(base.gameObject);
			ServerLogs.AddLog(ServerLogs.Modules.Administrative, $"{admin.LoggedNameFromRefHub()} spawned an admin toy: {CommandName} with NetID {base.netId}.", ServerLogs.ServerLogType.RemoteAdminActivity_GameChanging);
		}

		[ClientRpc]
		public void RpcChangeParent(uint parentId)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteUInt(parentId);
			SendRPCInternal("System.Void AdminToys.AdminToyBase::RpcChangeParent(System.UInt32)", -342419096, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private uint ServerParentId(Transform parent)
		{
			if (!(parent != null) || !parent.TryGetComponent<NetworkIdentity>(out var component))
			{
				return 0u;
			}
			return component.netId;
		}

		private void UpdateParent()
		{
			if (_clientParentId != 0 && NetworkClient.spawned.TryGetValue(_clientParentId, out var value))
			{
				CachedTransform.SetParent(value.transform, worldPositionStays: false);
			}
			else
			{
				CachedTransform.SetParent(null, worldPositionStays: false);
			}
		}

		private void UpdatePositionServer()
		{
			Transform cachedTransform = CachedTransform;
			cachedTransform.GetLocalPositionAndRotation(out var localPosition, out var localRotation);
			NetworkPosition = localPosition;
			NetworkRotation = localRotation;
			NetworkScale = cachedTransform.localScale;
		}

		protected virtual void UpdatePositionClient(bool teleport = false)
		{
			Transform cachedTransform = CachedTransform;
			Vector3 localPosition;
			Quaternion localRotation;
			Vector3 localScale;
			if (teleport || MovementSmoothing == 0)
			{
				localPosition = Position;
				localRotation = Rotation;
				localScale = Scale;
			}
			else
			{
				float t = Time.deltaTime * (float)(int)MovementSmoothing * 0.3f;
				cachedTransform.GetLocalPositionAndRotation(out var localPosition2, out var localRotation2);
				localPosition = Vector3.Lerp(localPosition2, Position, t);
				localRotation = Quaternion.Lerp(localRotation2, Rotation, t);
				localScale = Vector3.Lerp(cachedTransform.localScale, Scale, t);
			}
			cachedTransform.SetLocalPositionAndRotation(localPosition, localRotation);
			cachedTransform.localScale = localScale;
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcChangeParent__UInt32(uint parentId)
		{
			if (!NetworkServer.active)
			{
				_clientParentId = parentId;
				UpdateParent();
			}
		}

		protected static void InvokeUserCode_RpcChangeParent__UInt32(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcChangeParent called on server.");
			}
			else
			{
				((AdminToyBase)obj).UserCode_RpcChangeParent__UInt32(reader.ReadUInt());
			}
		}

		static AdminToyBase()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(AdminToyBase), "System.Void AdminToys.AdminToyBase::RpcChangeParent(System.UInt32)", InvokeUserCode_RpcChangeParent__UInt32);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteVector3(Position);
				writer.WriteQuaternion(Rotation);
				writer.WriteVector3(Scale);
				NetworkWriterExtensions.WriteByte(writer, MovementSmoothing);
				writer.WriteBool(IsStatic);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteVector3(Position);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteQuaternion(Rotation);
			}
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				writer.WriteVector3(Scale);
			}
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, MovementSmoothing);
			}
			if ((base.syncVarDirtyBits & 0x10L) != 0L)
			{
				writer.WriteBool(IsStatic);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref Position, null, reader.ReadVector3());
				GeneratedSyncVarDeserialize(ref Rotation, null, reader.ReadQuaternion());
				GeneratedSyncVarDeserialize(ref Scale, null, reader.ReadVector3());
				GeneratedSyncVarDeserialize(ref MovementSmoothing, null, NetworkReaderExtensions.ReadByte(reader));
				GeneratedSyncVarDeserialize(ref IsStatic, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Position, null, reader.ReadVector3());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Rotation, null, reader.ReadQuaternion());
			}
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref Scale, null, reader.ReadVector3());
			}
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref MovementSmoothing, null, NetworkReaderExtensions.ReadByte(reader));
			}
			if ((num & 0x10L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref IsStatic, null, reader.ReadBool());
			}
		}
	}
}
