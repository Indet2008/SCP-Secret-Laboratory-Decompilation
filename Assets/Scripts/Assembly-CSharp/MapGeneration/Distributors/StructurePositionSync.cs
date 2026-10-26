using System.Runtime.InteropServices;
using Mirror;
using UnityEngine;

namespace MapGeneration.Distributors
{
	[DefaultExecutionOrder(-1)]
	public class StructurePositionSync : NetworkBehaviour
	{
		public const float ConversionRate = 5.625f;

		[SyncVar]
		private sbyte _rotationY;

		[SyncVar]
		private Vector3 _position;

		public sbyte Network_rotationY
		{
			get
			{
				return _rotationY;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _rotationY, 1uL, null);
			}
		}

		public Vector3 Network_position
		{
			get
			{
				return _position;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _position, 2uL, null);
			}
		}

		private void Start()
		{
			Transform transform = base.transform;
			if (NetworkServer.active)
			{
				transform.GetPositionAndRotation(out _position, out var rotation);
				Network_rotationY = (sbyte)Mathf.RoundToInt(rotation.eulerAngles.y / 5.625f);
			}
			else
			{
				Quaternion rotation2 = Quaternion.Euler((float)_rotationY * 5.625f * Vector3.up);
				transform.SetPositionAndRotation(_position, rotation2);
			}
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
				writer.WriteSByte(_rotationY);
				writer.WriteVector3(_position);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteSByte(_rotationY);
			}
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteVector3(_position);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _rotationY, null, reader.ReadSByte());
				GeneratedSyncVarDeserialize(ref _position, null, reader.ReadVector3());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _rotationY, null, reader.ReadSByte());
			}
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _position, null, reader.ReadVector3());
			}
		}
	}
}
