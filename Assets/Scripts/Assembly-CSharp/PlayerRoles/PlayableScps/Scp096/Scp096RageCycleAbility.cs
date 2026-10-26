using GameObjectPools;
using Mirror;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096RageCycleAbility : KeySubroutine<Scp096Role>, IPoolResettable
	{
		public const ActionName RageKey = ActionName.Reload;

		public const float EnragingTime = 6.1f;

		public const float CalmingTime = 5f;

		private const float DefaultActivationDuration = 10f;

		private const float RateCompensation = 0.2f;

		private const float KeyHoldTime = 0.4f;

		private readonly AbilityCooldown _activationTime = new AbilityCooldown();

		private Scp096RageManager _rageManager;

		private Scp096TargetsTracker _targetsTracker;

		private float _holdingRageCycleKey;

		private bool _wantsToToggle;

		private float _timeToChangeState;

		public float HudEnterRageSustain => Mathf.InverseLerp(0.4f, 9.8f, _activationTime.Remaining);

		public float HudEnterRageKeyProgress => Mathf.Clamp01(_holdingRageCycleKey / 0.4f);

		public bool CanStartCycle
		{
			get
			{
				if (!_activationTime.IsReady)
				{
					return base.CastRole.IsRageState(Scp096RageState.Docile);
				}
				return false;
			}
		}

		public bool CanEndCycle => base.CastRole.IsRageState(Scp096RageState.Enraged);

		protected override ActionName TargetKey => ActionName.Reload;

		public bool ServerTryEnableInput(float duration = 10f)
		{
			_activationTime.Trigger(duration);
			ServerSendRpc(toAll: true);
			return true;
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (CanStartCycle)
			{
				_rageManager.ServerEnrage();
			}
			else if (CanEndCycle)
			{
				_rageManager.ServerEndEnrage();
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			_activationTime.WriteCooldown(writer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_activationTime.ReadCooldown(reader);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_activationTime.Clear();
			_holdingRageCycleKey = 0f;
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			_wantsToToggle = true;
		}

		protected override void Awake()
		{
			base.Awake();
			base.CastRole.SubroutineModule.TryGetSubroutine<Scp096TargetsTracker>(out _targetsTracker);
			base.CastRole.SubroutineModule.TryGetSubroutine<Scp096RageManager>(out _rageManager);
			Scp096TargetsTracker.OnTargetAdded += AddTarget;
			_targetsTracker.OnTargetAttacked += (ReferenceHub targetedHub) =>
			{
				AddTarget(base.Owner, targetedHub);
			};
			base.CastRole.StateController.OnRageUpdate += (Scp096RageState newState) =>
			{
				switch (newState)
				{
				case Scp096RageState.Calming:
					_timeToChangeState = 5f;
					break;
				case Scp096RageState.Distressed:
					_timeToChangeState = 6.1f;
					break;
				}
			};
		}

		protected override void Update()
		{
			base.Update();
			if (_wantsToToggle)
			{
				UpdateKeyHeld();
			}
			if (NetworkServer.active)
			{
				UpdateServerside();
			}
		}

		private void UpdateKeyHeld()
		{
			if ((!CanEndCycle && !CanStartCycle) || !IsKeyHeld)
			{
				_holdingRageCycleKey = 0f;
				_wantsToToggle = false;
				return;
			}
			_holdingRageCycleKey += Time.deltaTime;
			if (_holdingRageCycleKey >= 0.4f)
			{
				ClientSendCmd();
				_holdingRageCycleKey = 0f;
			}
		}

		private void UpdateServerside()
		{
			switch (base.CastRole.StateController.RageState)
			{
			case Scp096RageState.Enraged:
				return;
			case Scp096RageState.Distressed:
				_timeToChangeState -= Time.deltaTime;
				if (_timeToChangeState < 0f)
				{
					base.CastRole.StateController.SetRageState(Scp096RageState.Enraged);
				}
				return;
			case Scp096RageState.Calming:
				_timeToChangeState -= Time.deltaTime;
				if (_timeToChangeState < 0f)
				{
					base.CastRole.StateController.SetRageState(Scp096RageState.Docile);
				}
				return;
			}
			foreach (ReferenceHub target in _targetsTracker.Targets)
			{
				if (_targetsTracker.IsObservedBy(target))
				{
					ServerTryEnableInput();
				}
			}
			if (_activationTime.IsReady && _targetsTracker.Targets.Count > 0)
			{
				_targetsTracker.ClearAllTargets();
				ServerSendRpc(toAll: true);
			}
		}

		private void AddTarget(ReferenceHub ownerHub, ReferenceHub targetedHub)
		{
			if (NetworkServer.active && !(ownerHub != base.Owner))
			{
				ServerTryEnableInput();
			}
		}
	}
}
