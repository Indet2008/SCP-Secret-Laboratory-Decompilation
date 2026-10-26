using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

namespace MapGeneration.RoomConnectors
{
	public class WallableSmallNodeRoomConnector : SpawnableRoomConnector
	{
		private static readonly CachedLayerMask DetectionMask = new CachedLayerMask("Default");

		private const float RayLength = 0.4f;

		private const byte BitmaskForward = 1;

		private const byte BitmaskBack = 2;

		[Header("The blue arrow")]
		[SerializeField]
		private Vector3 _forwardWallRaycastOrigin;

		[Header("The yellow arrow")]
		[SerializeField]
		private Vector3 _backWallRaycastOrigin;

		[Space]
		[SerializeField]
		private GameObject _forwardWall;

		[SerializeField]
		private GameObject _backWall;

		[SyncVar(hook = "UpdateMask")]
		private byte _syncBitmask;

		private Vector3 ForwardOrigin => base.transform.TransformPoint(_forwardWallRaycastOrigin);

		private Vector3 BackOrigin => base.transform.TransformPoint(_backWallRaycastOrigin);

		public byte Network_syncBitmask
		{
			get
			{
				return _syncBitmask;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncBitmask, 1uL, UpdateMask);
			}
		}

		protected override void Start()
		{
			base.Start();
			if (NetworkServer.active)
			{
				ServerDetectWalls();
			}
			UpdateMask(0, _syncBitmask);
		}

		[Server]
		private void ServerDetectWalls()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void MapGeneration.RoomConnectors.WallableSmallNodeRoomConnector::ServerDetectWalls()' called when server was not active");
				return;
			}
			Vector3 forward = base.transform.forward;
			Vector3 dir = -forward;
			bool num = CheckWall(ForwardOrigin, forward);
			bool flag = CheckWall(BackOrigin, dir);
			byte b = 0;
			if (!num)
			{
				b |= 1;
			}
			if (!flag)
			{
				b |= 2;
			}
			Network_syncBitmask = b;
		}

		private void UpdateMask(byte _, byte targetBitmask)
		{
			_forwardWall.SetActive((targetBitmask & 1) != 0);
			_backWall.SetActive((targetBitmask & 2) != 0);
		}

		private bool CheckWall(Vector3 origin, Vector3 dir)
		{
			return Physics.Raycast(origin, dir, 0.4f, DetectionMask);
		}

		private void OnDrawGizmosSelected()
		{
			double num = Time.realtimeSinceStartupAsDouble - (double)(int)Time.realtimeSinceStartupAsDouble;
			float num2 = 0.4f * (1f + (float)num) / 2f;
			Gizmos.color = Color.blue;
			Gizmos.DrawRay(ForwardOrigin, base.transform.forward * num2);
			Gizmos.color = Color.yellow;
			Gizmos.DrawRay(BackOrigin, -base.transform.forward * num2);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncBitmask);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncBitmask);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _syncBitmask, UpdateMask, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncBitmask, UpdateMask, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}
