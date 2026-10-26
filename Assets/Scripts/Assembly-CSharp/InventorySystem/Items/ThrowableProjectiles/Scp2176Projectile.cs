using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using AudioPooling;
using Interactables.Interobjects.DoorUtils;
using InventorySystem.Items.Pickups;
using LabApi.Events.Arguments.ServerEvents;
using LabApi.Events.Handlers;
using MapGeneration;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class Scp2176Projectile : EffectGrenade
	{
		public float LockdownDuration = 13f;

		private const float LockdownDisableValue = 0.1f;

		private const float PanicDuration = 5f;

		private const float ShatterVelocity = 8.5f;

		private const float ActivateVelocity = 6.5f;

		private const float DropSoundRange = 20f;

		private bool _hasTriggered;

		[SerializeField]
		private AudioClip _dropSound;

		[SyncVar]
		private bool _playedDropSound;

		public bool Network_playedDropSound
		{
			get
			{
				return _playedDropSound;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _playedDropSound, 4uL, null);
			}
		}

		public static event Action<Scp2176Projectile, RoomIdentifier> OnServerShattered;

		protected override void ProcessCollision(Collision collision)
		{
			float sqrMagnitude = collision.relativeVelocity.sqrMagnitude;
			if (!NetworkServer.active || !(sqrMagnitude >= 42.25f))
			{
				return;
			}
			base.ProcessCollision(collision);
			if (!_hasTriggered)
			{
				ServerActivate();
				if (sqrMagnitude >= 72.25f)
				{
					ServerFuseEnd();
				}
				else if (!_playedDropSound)
				{
					Network_playedDropSound = true;
					RpcMakeSound();
				}
			}
		}

		public override bool ServerFuseEnd()
		{
			if (!base.ServerFuseEnd())
			{
				return false;
			}
			_hasTriggered = true;
			ServerShatter();
			ServerEvents.OnProjectileExploded(new ProjectileExplodedEventArgs(this, PreviousOwner.Hub, base.transform.position));
			return true;
		}

		[ClientRpc]
		public void RpcMakeSound()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile::RpcMakeSound()", 1009999061, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public override void ServerActivate()
		{
			base.ServerActivate();
			PickupSyncInfo info = Info;
			info.Locked = true;
			base.NetworkInfo = info;
		}

		public void ServerImmediatelyShatter()
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Tried to call ServerImmediatelyShatter from the client!");
			}
			ServerActivate();
			ServerFuseEnd();
		}

		private void ServerShatter()
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Tried to call ServerShatter from the client!");
			}
			if (!base.transform.position.TryGetRoom(out var room))
			{
				return;
			}
			OnServerShattered?.Invoke(this, room);
			if (room.Name == RoomName.HczTesla && TryFindTeslaAtRoom(room, out var gate))
			{
				ServerOverloadTesla(gate, room.LightControllers);
			}
			else
			{
				foreach (RoomLightController lightController in room.LightControllers)
				{
					lightController.ServerFlickerLights(lightController.LightsEnabled ? LockdownDuration : 0.1f);
				}
			}
			if (DoorVariant.DoorsByRoom.TryGetValue(room, out var value))
			{
				ServerLockdown(value);
			}
		}

		private static bool TryFindTeslaAtRoom(RoomIdentifier rid, out TeslaGate gate)
		{
			return TeslaGate.AllGates.TryGetFirst((TeslaGate x) => rid == x.Room, out gate);
		}

		private void ServerOverloadTesla(TeslaGate tg, IEnumerable<RoomLightController> lightControllers)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Tried to call ServerOverloadTesla from the client!");
			}
			foreach (RoomLightController lightController in lightControllers)
			{
				lightController.ServerFlickerLights(lightController.LightsEnabled ? (LockdownDuration - 1f) : 0.1f);
			}
			tg.NetworkInactiveTime = ((tg.InactiveTime > 0f) ? 0.1f : (LockdownDuration - 1f));
			tg.RpcInstantBurst();
			tg.ServerSideIdle(shouldIdle: false);
		}

		private void ServerLockdown(IEnumerable<DoorVariant> doors)
		{
			bool inProgress = AlphaWarheadController.InProgress;
			foreach (DoorVariant door in doors)
			{
				if (door is INonInteractableDoor { IgnoreLockdowns: not false })
				{
					continue;
				}
				DoorLockReason activeLocks = (DoorLockReason)door.ActiveLocks;
				if (!door.TargetState && (activeLocks.HasFlagFast(DoorLockReason.Lockdown079) || activeLocks.HasFlagFast(DoorLockReason.Lockdown2176) || activeLocks.HasFlagFast(DoorLockReason.Regular079)))
				{
					door.UnlockLater(0f, DoorLockReason.Lockdown2176);
					if (!door.RequiredPermissions.Bypass2176)
					{
						door.NetworkTargetState = true;
					}
					continue;
				}
				DoorLockMode mode = DoorLockUtils.GetMode((DoorLockReason)door.ActiveLocks);
				if (mode.HasFlagFast(DoorLockMode.CanClose) || mode.HasFlagFast(DoorLockMode.ScpOverride))
				{
					door.ServerChangeLock(DoorLockReason.Lockdown2176, newState: true);
					door.UnlockLater(LockdownDuration, DoorLockReason.Lockdown2176);
					if (!inProgress)
					{
						door.NetworkTargetState = false;
					}
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcMakeSound()
		{
			AudioSourcePoolManager.PlayOnTransform(_dropSound, base.gameObject.transform, 20f, 0.5f);
		}

		protected static void InvokeUserCode_RpcMakeSound(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcMakeSound called on server.");
			}
			else
			{
				((Scp2176Projectile)obj).UserCode_RpcMakeSound();
			}
		}

		static Scp2176Projectile()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(Scp2176Projectile), "System.Void InventorySystem.Items.ThrowableProjectiles.Scp2176Projectile::RpcMakeSound()", InvokeUserCode_RpcMakeSound);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteBool(_playedDropSound);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 4L) != 0L)
			{
				writer.WriteBool(_playedDropSound);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _playedDropSound, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 4L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _playedDropSound, null, reader.ReadBool());
			}
		}
	}
}
