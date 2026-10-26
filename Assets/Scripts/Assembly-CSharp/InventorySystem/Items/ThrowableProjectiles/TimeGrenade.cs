using System.Runtime.InteropServices;
using Footprinting;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public abstract class TimeGrenade : ThrownProjectile
	{
		[SerializeField]
		private float _fuseTime;

		[SyncVar]
		private double _syncTargetTime;

		private bool _alreadyDetonated;

		public double TargetTime
		{
			get
			{
				return _syncTargetTime;
			}
			set
			{
				Network_syncTargetTime = value;
			}
		}

		public double Network_syncTargetTime
		{
			get
			{
				return _syncTargetTime;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _syncTargetTime, 2uL, null);
			}
		}

		public virtual bool ServerFuseEnd()
		{
			ProjectileExplodingEventArgs e = new ProjectileExplodingEventArgs(this, PreviousOwner.Hub, base.transform.position);
			ServerEvents.OnProjectileExploding(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			if (PreviousOwner.Hub != e.Player?.ReferenceHub)
			{
				PreviousOwner = new Footprint(e.Player?.ReferenceHub);
			}
			base.transform.position = e.Position;
			return true;
		}

		public override void ServerActivate()
		{
			Network_syncTargetTime = NetworkTime.time + (double)_fuseTime;
		}

		protected virtual void Update()
		{
			if (NetworkServer.active && !_alreadyDetonated && TargetTime != 0.0 && !(NetworkTime.time < TargetTime))
			{
				ServerFuseEnd();
				_alreadyDetonated = true;
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
				writer.WriteDouble(_syncTargetTime);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteDouble(_syncTargetTime);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _syncTargetTime, null, reader.ReadDouble());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _syncTargetTime, null, reader.ReadDouble());
			}
		}
	}
}
