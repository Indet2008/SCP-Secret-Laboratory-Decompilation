using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HUDs;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096HandsViewmodel : ScpViewmodelBase
	{
		[SerializeField]
		private float _fieldOfView;

		[SerializeField]
		private float _dampTime;

		[SerializeField]
		private float _weightAdjustSpeed;

		private bool _useEnragedLayer;

		private FirstPersonMovementModule _fpc;

		private Scp096AttackAbility _attackAbility;

		private Scp096StateController _stateController;

		private const int EnrageLayer = 1;

		private static readonly int HashWalk = Animator.StringToHash("Walk");

		private static readonly int HashExitRage = Animator.StringToHash("RageExit");

		private static readonly int HashEnterRage = Animator.StringToHash("RageEnter");

		private static readonly int HashPryGate = Animator.StringToHash("PryGate");

		private static readonly int HashLeftAttack = Animator.StringToHash("LeftAttack");

		private static readonly int HashAttackTrigger = Animator.StringToHash("Attack");

		private static readonly int HashTryNotToCry = Animator.StringToHash("TryNotToCry");

		public override float CamFOV => _fieldOfView;

		protected override void Start()
		{
			base.Start();
			Scp096Role scp096Role = base.Role as Scp096Role;
			_fpc = scp096Role.FpcModule;
			_stateController = scp096Role.StateController;
			scp096Role.SubroutineModule.TryGetSubroutine<Scp096AttackAbility>(out _attackAbility);
			_stateController.OnRageUpdate += OnRageUpdate;
			_stateController.OnAbilityUpdate += OnAbilityUpdate;
			_attackAbility.OnHitReceived += OnHitReceived;
			_attackAbility.OnAttackTriggered += OnAttackTriggered;
			OnRageUpdate(_stateController.RageState);
			UpdateLayerWeight(1f);
			UpdateAnimations();
			if (!base.Owner.isLocalPlayer)
			{
				if (_stateController.RageState == Scp096RageState.Enraged)
				{
					SkipAnimations(15f, 5);
				}
				else
				{
					SkipAnimations(_stateController.LastRageUpdate);
				}
				UpdateWalk(instant: true);
				if (_stateController.AbilityState != Scp096AbilityState.None)
				{
					OnAbilityUpdate(_stateController.AbilityState);
					SkipAnimations(_stateController.LastAbilityUpdate);
				}
			}
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			_stateController.OnRageUpdate -= OnRageUpdate;
			_stateController.OnAbilityUpdate -= OnAbilityUpdate;
			_attackAbility.OnHitReceived -= OnHitReceived;
			_attackAbility.OnAttackTriggered -= OnAttackTriggered;
		}

		private void OnAbilityUpdate(Scp096AbilityState newState)
		{
			if (newState == Scp096AbilityState.PryingGate)
			{
				base.Anim.SetTrigger(HashPryGate);
			}
		}

		private void OnRageUpdate(Scp096RageState newState)
		{
			switch (newState)
			{
			case Scp096RageState.Calming:
				base.Anim.SetTrigger(HashExitRage);
				_useEnragedLayer = false;
				break;
			case Scp096RageState.Distressed:
				base.Anim.SetTrigger(HashEnterRage);
				_useEnragedLayer = true;
				break;
			case Scp096RageState.Docile:
				_useEnragedLayer = false;
				break;
			case Scp096RageState.Enraged:
				_useEnragedLayer = true;
				break;
			}
		}

		private void OnAttackTriggered()
		{
			if (base.Owner.isLocalPlayer)
			{
				base.Anim.SetBool(HashLeftAttack, !_attackAbility.LeftAttack);
				base.Anim.SetTrigger(HashAttackTrigger);
			}
		}

		private void OnHitReceived(Scp096HitResult hit)
		{
			if (!base.Owner.isLocalPlayer)
			{
				base.Anim.SetBool(HashLeftAttack, _attackAbility.LeftAttack);
				base.Anim.SetTrigger(HashAttackTrigger);
			}
		}

		private void UpdateLayerWeight(float maxDelta)
		{
			float layerWeight = base.Anim.GetLayerWeight(1);
			base.Anim.SetLayerWeight(1, Mathf.MoveTowards(layerWeight, _useEnragedLayer ? 1 : 0, maxDelta));
		}

		private void UpdateWalk(bool instant)
		{
			float value = ((_stateController.RageState != Scp096RageState.Enraged) ? (base.Owner.GetVelocity().magnitude / _fpc.WalkSpeed) : ((float)((_stateController.AbilityState == Scp096AbilityState.Charging) ? 1 : 0)));
			if (instant)
			{
				base.Anim.SetFloat(HashWalk, value);
			}
			else
			{
				base.Anim.SetFloat(HashWalk, value, _dampTime, Time.deltaTime);
			}
		}

		protected override void UpdateAnimations()
		{
			UpdateLayerWeight(Time.deltaTime * _weightAdjustSpeed);
			base.Anim.SetBool(HashTryNotToCry, _stateController.AbilityState == Scp096AbilityState.TryingNotToCry);
			UpdateWalk(instant: false);
		}
	}
}
