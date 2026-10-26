using System.Runtime.InteropServices;
using Interactables.Interobjects.DoorUtils;
using LabApi.Events.Arguments.Scp096Events;
using LabApi.Events.Handlers;
using MEC;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class PryableDoor : BasicDoor, IScp106PassableDoor
	{
		private static readonly int PryAnimHash;

		public Transform[] PryPositions;

		[SerializeField]
		private AudioClip _prySound;

		[SerializeField]
		private DoorLockReason _blockPryingMask;

		[SerializeField]
		private float _pryAnimDuration;

		[SerializeField]
		[SyncVar]
		private bool _restrict106WhileLocked;

		private float _remainingPryCooldown;

		private bool _isBeingPried;

		protected override float AnimationInterruptThreshold => 0.98f;

		public bool IsBeingPried => _isBeingPried;

		public bool IsScp106Passable
		{
			get
			{
				if (_restrict106WhileLocked && ActiveLocks != 0)
				{
					return TargetState;
				}
				return true;
			}
			set
			{
				Network_restrict106WhileLocked = !value;
			}
		}

		public bool Network_restrict106WhileLocked
		{
			get
			{
				return _restrict106WhileLocked;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _restrict106WhileLocked, 8uL, null);
			}
		}

		[Server]
		public bool TryPryGate(ReferenceHub player)
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Boolean Interactables.Interobjects.PryableDoor::TryPryGate(ReferenceHub)' called when server was not active");
				return default;
			}
			if (_blockPryingMask != DoorLockReason.None && ((DoorLockReason)ActiveLocks).HasFlagFast(_blockPryingMask))
			{
				return false;
			}
			if (AllowInteracting(null, 0))
			{
				Scp096PryingGateEventArgs e = new Scp096PryingGateEventArgs(player, this);
				Scp096Events.OnPryingGate(e);
				if (!e.IsAllowed)
				{
					return false;
				}
				if (DoorName != null)
				{
					ServerLogs.AddLog(ServerLogs.Modules.Door, ((player == null) ? "null" : player.LoggedNameFromRefHub()) + " pried " + DoorName + ".", ServerLogs.ServerLogType.GameEvent);
				}
				RpcPryGate();
				_remainingPryCooldown = _pryAnimDuration;
				_isBeingPried = true;
				Scp096Events.OnPriedGate(new Scp096PriedGateEventArgs(player, this));
				return true;
			}
			return false;
		}

		[ClientRpc]
		public void RpcPryGate()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Interactables.Interobjects.PryableDoor::RpcPryGate()", -166089162, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public override bool AllowInteracting(ReferenceHub ply, byte colliderId)
		{
			if (_remainingPryCooldown <= 0f)
			{
				return base.AllowInteracting(ply, colliderId);
			}
			return false;
		}

		protected override void Update()
		{
			base.Update();
			if (_remainingPryCooldown > 0f)
			{
				_remainingPryCooldown -= Time.deltaTime;
				if (_remainingPryCooldown <= 0f)
				{
					MainAnimator.ResetTrigger(PryAnimHash);
					_isBeingPried = false;
				}
			}
		}

		static PryableDoor()
		{
			PryAnimHash = Animator.StringToHash("PryGate");
			RemoteProcedureCalls.RegisterRpc(typeof(PryableDoor), "System.Void Interactables.Interobjects.PryableDoor::RpcPryGate()", InvokeUserCode_RpcPryGate);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPryGate()
		{
			_isBeingPried = true;
			MainAnimator.SetTrigger(PryAnimHash);
			MainSource.PlayOneShot(_prySound);
			Timing.CallDelayed(_pryAnimDuration, () =>
			{
				_isBeingPried = false;
			}, base.gameObject);
		}

		protected static void InvokeUserCode_RpcPryGate(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPryGate called on server.");
			}
			else
			{
				((PryableDoor)obj).UserCode_RpcPryGate();
			}
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteBool(_restrict106WhileLocked);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 8L) != 0L)
			{
				writer.WriteBool(_restrict106WhileLocked);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _restrict106WhileLocked, null, reader.ReadBool());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 8L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _restrict106WhileLocked, null, reader.ReadBool());
			}
		}
	}
}
