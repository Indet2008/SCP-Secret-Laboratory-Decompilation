using System;
using System.Runtime.InteropServices;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp1576
{
	public class Scp1576Pickup : CollisionDetectionPickup
	{
		private byte _prevSyncHorn;

		[SyncVar]
		private byte _syncHorn;

		[SerializeField]
		private Transform _horn;

		[SerializeField]
		private Vector3 _posZero;

		[SerializeField]
		private Vector3 _posOne;

		public float HornPos
		{
			get
			{
				return (float)(int)_syncHorn / 255f;
			}
			set
			{
				Network_syncHorn = (byte)Mathf.Clamp(Mathf.RoundToInt(value * 255f), 0, 255);
			}
		}

		public byte Network_syncHorn
		{
			get
			{
				return _syncHorn;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncHorn, 2uL, null);
			}
		}

		public static event Action<ushort, float> OnHornPositionUpdated;

		private void Update()
		{
			if (_prevSyncHorn != _syncHorn)
			{
				float hornPos = HornPos;
				_horn.localPosition = Vector3.Lerp(_posZero, _posOne, hornPos);
				OnHornPositionUpdated?.Invoke(Info.Serial, hornPos);
				_prevSyncHorn = _syncHorn;
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
				NetworkWriterExtensions.WriteByte(writer, _syncHorn);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				NetworkWriterExtensions.WriteByte(writer, _syncHorn);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _syncHorn, null, NetworkReaderExtensions.ReadByte(reader));
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncHorn, null, NetworkReaderExtensions.ReadByte(reader));
			}
		}
	}
}
