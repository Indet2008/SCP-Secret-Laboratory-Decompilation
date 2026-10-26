using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096CharacterModel : AnimatedCharacterModel
	{
		private static readonly int AnimatorEnragingHash = Animator.StringToHash("Enraging");

		private static readonly int AnimatorEnragedHash = Animator.StringToHash("Enraged");

		private static readonly int AnimatorChargingHash = Animator.StringToHash("Charging");

		private static readonly int AnimatorTryNotToCryHash = Animator.StringToHash("TryNotToCry");

		private static readonly int AnimatorLeftAttackHash = Animator.StringToHash("LeftAttack");

		private static readonly int AnimatorPryGateHash = Animator.StringToHash("PryGate");

		private static readonly int AnimatorCalmingHash = Animator.StringToHash("Calming");

		private static readonly int AnimatorAttackHash = Animator.StringToHash("Attack");

		private static readonly int GroundedHash = Animator.StringToHash("IsGrounded");

		[SerializeField]
		private Animator _thirdPersonAnimator;

		private Scp096Role _role;

		private Scp096AttackAbility _attackAbility;

		private Scp096RageManager _rageAbility;

		[field: SerializeField]
		public Transform Head { get; private set; }

		protected override void Update()
		{
			base.Update();
			if (!(_rageAbility == null))
			{
				bool value = _role.IsAbilityState(Scp096AbilityState.TryingNotToCry);
				_thirdPersonAnimator.SetBool(AnimatorEnragedHash, _rageAbility.IsEnraged);
				_thirdPersonAnimator.SetBool(AnimatorEnragingHash, _rageAbility.IsDistressed);
				_thirdPersonAnimator.SetBool(AnimatorChargingHash, _role.IsAbilityState(Scp096AbilityState.Charging));
				_thirdPersonAnimator.SetBool(AnimatorTryNotToCryHash, value);
				_thirdPersonAnimator.SetBool(AnimatorAttackHash, _role.IsAbilityState(Scp096AbilityState.Attacking));
				_thirdPersonAnimator.SetBool(AnimatorLeftAttackHash, _attackAbility.LeftAttack);
				_thirdPersonAnimator.SetBool(AnimatorPryGateHash, _role.IsAbilityState(Scp096AbilityState.PryingGate));
				_thirdPersonAnimator.SetBool(AnimatorCalmingHash, _role.IsRageState(Scp096RageState.Calming));
				_thirdPersonAnimator.SetBool(GroundedHash, base.FpcModule.IsGrounded);
			}
		}

		public override void Setup(ReferenceHub owner, IFpcRole role, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, role, localPos, localRot);
			_role = base.OwnerHub.roleManager.CurrentRole as Scp096Role;
			_role.SubroutineModule.TryGetSubroutine<Scp096AttackAbility>(out _attackAbility);
			_role.SubroutineModule.TryGetSubroutine<Scp096RageManager>(out _rageAbility);
		}
	}
}
