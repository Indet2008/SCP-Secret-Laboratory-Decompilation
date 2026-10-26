using System;
using CursorManagement;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Ragdolls;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049
{
	public abstract class RagdollAbilityBase<T> : KeySubroutine<T>, ICursorOverride where T : FpcStandardScp
	{
		private static readonly CachedLayerMask RaycastBlockMask = new CachedLayerMask("Default", "InteractableNoPlayerCollision", "Glass", "Ragdoll", "Door");

		private readonly AbilityCooldown _process = new AbilityCooldown();

		private Transform _ragdollTransform;

		private DynamicRagdoll _syncRagdoll;

		private byte _errorCode;

		private double _completionTime;

		public virtual CursorOverrideMode CursorOverride => CursorOverrideMode.NoOverride;

		public virtual bool LockMovement => IsInProgress;

		protected override ActionName TargetKey => ActionName.Interact;

		public bool IsInProgress
		{
			get
			{
				return _completionTime != 0.0;
			}
			private set
			{
				_completionTime = (value ? (NetworkTime.time + (double)Duration) : 0.0);
				ServerSendRpc(toAll: true);
			}
		}

		public float ProgressStatus => _process.Readiness;

		protected abstract float RangeSqr { get; }

		protected abstract float Duration { get; }

		protected BasicRagdoll CurRagdoll { get; private set; }

		public event Action<byte> OnErrorReceived;

		public event Action OnStop;

		public event Action OnStart;

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteNetworkBehaviour(_syncRagdoll);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			Vector3 position = base.CastRole.FpcModule.Position;
			_syncRagdoll = reader.ReadNetworkBehaviour<DynamicRagdoll>();
			if (_syncRagdoll == null)
			{
				if (IsInProgress)
				{
					_errorCode = ServerValidateCancel();
					if (_errorCode != 0)
					{
						ServerSendRpc(toAll: true);
					}
					else
					{
						IsInProgress = false;
					}
				}
			}
			else
			{
				if (IsInProgress || !IsCorpseNearby(position, _syncRagdoll, out var ragdollPosition))
				{
					return;
				}
				Transform ragdollTransform = _ragdollTransform;
				BasicRagdoll curRagdoll = CurRagdoll;
				_ragdollTransform = ragdollPosition;
				CurRagdoll = _syncRagdoll;
				_errorCode = ServerValidateBegin(_syncRagdoll);
				bool flag = _errorCode != 0;
				if (flag || !ServerValidateAny())
				{
					_ragdollTransform = ragdollTransform;
					CurRagdoll = curRagdoll;
					if (flag)
					{
						ServerSendRpc(toAll: true);
					}
				}
				else
				{
					IsInProgress = true;
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteNetworkBehaviour(CurRagdoll);
			writer.WriteDouble(_completionTime);
			writer.WriteByte(_errorCode);
			_errorCode = 0;
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			bool flag = IsInProgress && !NetworkServer.active;
			double completionTime = _completionTime;
			CurRagdoll = reader.ReadNetworkBehaviour<BasicRagdoll>();
			_completionTime = reader.ReadDouble();
			byte b = reader.ReadByte();
			if (_completionTime != completionTime)
			{
				if (completionTime == 0.0)
				{
					OnStart?.Invoke();
				}
				if (completionTime != 0.0)
				{
					OnStop?.Invoke();
				}
			}
			if (base.Owner.isLocalPlayer && b != 0)
			{
				OnErrorReceived?.Invoke(b);
				ClientProcessErrorCode(b);
			}
			OnProgressSet();
			if (!IsInProgress)
			{
				_process.Clear();
			}
			else if (!flag)
			{
				_process.Trigger((float)(_completionTime - NetworkTime.time));
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			if (base.Owner.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				fpcRole.FpcModule.Motor.RegisterMovementLock(this);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (base.Owner.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				fpcRole.FpcModule.Motor.UnregisterMovementLock(this);
			}
			_completionTime = 0.0;
			_process.Clear();
		}

		protected abstract void ServerComplete();

		protected abstract byte ServerValidateBegin(BasicRagdoll ragdoll);

		protected virtual void OnProgressSet()
		{
		}

		protected virtual byte ServerValidateCancel()
		{
			return 0;
		}

		protected virtual bool ServerValidateAny()
		{
			return IsCloseEnough(base.CastRole.FpcModule.Position, _ragdollTransform.position);
		}

		protected virtual void ClientProcessErrorCode(byte code)
		{
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active && IsInProgress)
			{
				if (!ServerValidateAny())
				{
					IsInProgress = false;
				}
				else if (!(NetworkTime.time < _completionTime))
				{
					ServerComplete();
					IsInProgress = false;
				}
			}
		}

		protected void ClientTryStart()
		{
			if (CanFindCorpse(base.Owner.PlayerCameraReference, out var ragdoll) && ClientValidateBegin(ragdoll) && ragdoll is DynamicRagdoll dynamicRagdoll && IsCorpseNearby(base.CastRole.FpcModule.Position, dynamicRagdoll, out var _))
			{
				_syncRagdoll = dynamicRagdoll;
				ClientSendCmd();
			}
		}

		protected void ClientTryCancel()
		{
			_syncRagdoll = null;
			ClientSendCmd();
		}

		protected virtual bool ClientValidateBegin(BasicRagdoll raycastedRagdoll)
		{
			return true;
		}

		private bool IsCorpseNearby(Vector3 position, DynamicRagdoll ragdoll, out Transform ragdollPosition)
		{
			Transform[] linkedRigidbodiesTransforms = ragdoll.LinkedRigidbodiesTransforms;
			foreach (Transform transform in linkedRigidbodiesTransforms)
			{
				if (IsCloseEnough(position, transform.position))
				{
					ragdollPosition = transform.transform;
					return true;
				}
			}
			ragdollPosition = ragdoll.transform;
			return false;
		}

		private bool CanFindCorpse(Transform tr, out BasicRagdoll ragdoll)
		{
			ragdoll = null;
			if (!Physics.Raycast(tr.position, tr.forward, out var hitInfo, RangeSqr, RaycastBlockMask))
			{
				return false;
			}
			return hitInfo.transform.TryGetComponentInParent<BasicRagdoll>(out ragdoll);
		}

		private bool IsCloseEnough(Vector3 position, Vector3 ragdollPosition)
		{
			return (ragdollPosition - position).sqrMagnitude < RangeSqr;
		}
	}
}
