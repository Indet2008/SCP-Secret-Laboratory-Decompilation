using Interactables.Interobjects.DoorUtils;
using Interactables.Verification;
using Mirror;
using Mirror.RemoteCalls;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class AirlockController : NetworkBehaviour, IServerInteractable, IInteractable
	{
		private static readonly int AnimationTriggerHash;

		public bool AirlockDisabled;

		[SerializeField]
		private DoorVariant _doorA;

		[SerializeField]
		private DoorVariant _doorB;

		[SerializeField]
		private float _lockdownDuration;

		[SerializeField]
		private float _lockdownCooldown;

		[SerializeField]
		private Animator _targetAnimator;

		private float _lockdownCombinedTimer;

		private byte _frameCooldownTimer;

		private bool _targetStateA;

		private bool _doorsLocked;

		private bool _warheadInProgress;

		private bool _readyToUse;

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		private void Start()
		{
			if (NetworkServer.active)
			{
				DoorEvents.OnDoorAction += OnDoorAction;
				DoorEventOpenerExtension.OnDoorsTriggerred += EventTriggerred;
			}
		}

		private void EventTriggerred(DoorEventOpenerExtension.OpenerEventType eventType)
		{
			switch (eventType)
			{
			case DoorEventOpenerExtension.OpenerEventType.WarheadStart:
			case DoorEventOpenerExtension.OpenerEventType.WarheadCancel:
				_warheadInProgress = eventType == DoorEventOpenerExtension.OpenerEventType.WarheadStart;
				_doorA.ServerChangeLock(DoorLockReason.Warhead, _warheadInProgress);
				_doorB.ServerChangeLock(DoorLockReason.Warhead, _warheadInProgress);
				if (_warheadInProgress)
				{
					DoorVariant doorA2 = _doorA;
					bool networkTargetState = (_doorB.NetworkTargetState = true);
					doorA2.NetworkTargetState = networkTargetState;
					_frameCooldownTimer = 5;
				}
				else
				{
					ToggleAirlock();
				}
				break;
			case DoorEventOpenerExtension.OpenerEventType.DeconFinish:
			{
				_doorsLocked = true;
				_doorA.ServerChangeLock(DoorLockReason.DecontLockdown, newState: true);
				_doorB.ServerChangeLock(DoorLockReason.DecontLockdown, newState: true);
				DoorVariant doorA = _doorA;
				bool networkTargetState = (_doorB.NetworkTargetState = false);
				doorA.NetworkTargetState = networkTargetState;
				_lockdownCombinedTimer = 65535f;
				break;
			}
			}
		}

		private void OnDestroy()
		{
			if (NetworkServer.active)
			{
				DoorEvents.OnDoorAction -= OnDoorAction;
				DoorEventOpenerExtension.OnDoorsTriggerred -= EventTriggerred;
			}
		}

		private void OnDoorAction(DoorVariant door, DoorAction action, ReferenceHub ply)
		{
			if (door.ActiveLocks <= 0 && (!(door != _doorA) || !(door != _doorB)) && !AirlockDisabled && !_warheadInProgress && _readyToUse)
			{
				if (action == DoorAction.Destroyed)
				{
					AirlockDisabled = true;
				}
				else if ((_doorA.AllowInteracting(ply, 0) || _doorB.AllowInteracting(ply, 0)) && _frameCooldownTimer <= 0 && (action == DoorAction.Opened || action == DoorAction.Closed))
				{
					ToggleAirlock();
				}
			}
		}

		private void ToggleAirlock()
		{
			_targetStateA = !_targetStateA;
			_doorB.NetworkTargetState = _targetStateA;
			_doorA.NetworkTargetState = !_targetStateA;
			_frameCooldownTimer = 5;
		}

		private void Update()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			if (_frameCooldownTimer > 0)
			{
				_frameCooldownTimer--;
			}
			if (_readyToUse)
			{
				if (_lockdownCombinedTimer > 0f - Mathf.Abs(_lockdownCooldown))
				{
					_lockdownCombinedTimer -= Time.deltaTime;
					if (_doorsLocked && _lockdownCombinedTimer <= 0f)
					{
						_doorsLocked = false;
						_doorA.ServerChangeLock(DoorLockReason.SpecialDoorFeature, newState: false);
						_doorB.ServerChangeLock(DoorLockReason.SpecialDoorFeature, newState: false);
						_doorA.NetworkTargetState = _targetStateA;
						_doorB.NetworkTargetState = !_targetStateA;
					}
				}
			}
			else if (_frameCooldownTimer == 0)
			{
				if (Mathf.RoundToInt(_doorA.GetExactState()) == Mathf.RoundToInt(_doorB.GetExactState()))
				{
					_doorB.NetworkTargetState = _targetStateA;
					_doorA.NetworkTargetState = !_targetStateA;
					_frameCooldownTimer = 200;
				}
				else
				{
					_readyToUse = true;
					_frameCooldownTimer = 10;
				}
			}
		}

		[ClientRpc]
		private void RpcAlarm()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Interactables.Interobjects.AirlockController::RpcAlarm()", -536901961, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!AirlockDisabled && !(_lockdownCombinedTimer > 0f - Mathf.Abs(_lockdownCooldown)))
			{
				_lockdownCombinedTimer = Mathf.Abs(_lockdownDuration);
				_doorsLocked = true;
				_doorA.ServerChangeLock(DoorLockReason.SpecialDoorFeature, newState: true);
				_doorB.ServerChangeLock(DoorLockReason.SpecialDoorFeature, newState: true);
				DoorVariant doorA = _doorA;
				bool networkTargetState = (_doorB.NetworkTargetState = false);
				doorA.NetworkTargetState = networkTargetState;
				RpcAlarm();
			}
		}

		static AirlockController()
		{
			AnimationTriggerHash = Animator.StringToHash("Lockdown");
			RemoteProcedureCalls.RegisterRpc(typeof(AirlockController), "System.Void Interactables.Interobjects.AirlockController::RpcAlarm()", InvokeUserCode_RpcAlarm);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcAlarm()
		{
			_targetAnimator.SetTrigger(AnimationTriggerHash);
		}

		protected static void InvokeUserCode_RpcAlarm(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcAlarm called on server.");
			}
			else
			{
				((AirlockController)obj).UserCode_RpcAlarm();
			}
		}
	}
}
