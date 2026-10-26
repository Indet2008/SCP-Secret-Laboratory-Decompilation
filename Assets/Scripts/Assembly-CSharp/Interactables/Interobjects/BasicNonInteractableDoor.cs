using System.Runtime.InteropServices;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class BasicNonInteractableDoor : BasicDoor, INonInteractableDoor, IScp106PassableDoor
	{
		[SerializeField]
		private bool _ignoreLockdowns;

		[SerializeField]
		private bool _ignoreRemoteAdmin;

		[SerializeField]
		[SyncVar]
		private bool _blockScp106;

		public bool IgnoreLockdowns => _ignoreLockdowns;

		public bool IgnoreRemoteAdmin => _ignoreRemoteAdmin;

		public bool IsScp106Passable
		{
			get
			{
				return !_blockScp106;
			}
			set
			{
				Network_blockScp106 = !value;
			}
		}

		public bool Network_blockScp106
		{
			get
			{
				return _blockScp106;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _blockScp106, 8uL, null);
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
				writer.WriteBool(_blockScp106);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteBool(_blockScp106);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _blockScp106, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _blockScp106, null, reader.ReadBool());
			}
		}
	}
}
