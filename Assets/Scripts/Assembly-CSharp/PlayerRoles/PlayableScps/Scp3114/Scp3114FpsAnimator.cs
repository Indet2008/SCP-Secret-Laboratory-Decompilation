using InventorySystem.Items;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.PlayableScps.HUDs;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114FpsAnimator : ScpViewmodelBase
	{
		[SerializeField]
		private float _defaultFov;

		[SerializeField]
		private Vector2 _attackVariantMinMax;

		[SerializeField]
		private int _hideHandsLayer;

		[SerializeField]
		private float _animDampTime;

		[SerializeField]
		private GameObject _handsGraphics;

		private Scp3114Slap _slap;

		private Scp3114Role _scpRole;

		private Scp3114Strangle _strangle;

		private Scp3114Dance _dance;

		private int _prevRand;

		private static readonly int AttackHash = Animator.StringToHash("Attack");

		private static readonly int VariantHash = Animator.StringToHash("AttackVariant");

		private static readonly int StatusHash = Animator.StringToHash("IdentityStatus");

		private static readonly int WalkCycleHash = Animator.StringToHash("WalkCycle");

		private static readonly int WalkBlendHash = Animator.StringToHash("WalkBlend");

		private static readonly int GroundedHash = Animator.StringToHash("IsGrounded");

		private static readonly int StrangleHash = Animator.StringToHash("Strangling");

		public override float CamFOV
		{
			get
			{
				ItemBase curInstance = base.Owner.inventory.CurInstance;
				if (!(curInstance != null) || !(curInstance.ViewModel != null))
				{
					return _defaultFov;
				}
				return curInstance.ViewModel.ViewmodelCameraFOV;
			}
		}

		protected override void Start()
		{
			base.Start();
			_scpRole = base.Role as Scp3114Role;
			_scpRole.SubroutineModule.TryGetSubroutine<Scp3114Slap>(out _slap);
			_scpRole.SubroutineModule.TryGetSubroutine<Scp3114Dance>(out _dance);
			_scpRole.SubroutineModule.TryGetSubroutine<Scp3114Strangle>(out _strangle);
			_slap.OnTriggered += PlayAttackAnim;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_slap != null)
			{
				_slap.OnTriggered -= PlayAttackAnim;
			}
		}

		protected override void UpdateAnimations()
		{
			FirstPersonMovementModule fpcModule = _scpRole.FpcModule;
			bool isGrounded = fpcModule.IsGrounded;
			float num = fpcModule.Motor.Velocity.MagnitudeIgnoreY();
			float walkCycle = (fpcModule.CharacterModelInstance as AnimatedCharacterModel).WalkCycle;
			base.Anim.SetInteger(StatusHash, (int)_scpRole.CurIdentity.Status);
			base.Anim.SetBool(GroundedHash, isGrounded);
			base.Anim.SetFloat(WalkBlendHash, isGrounded ? num : 0f, _animDampTime, Time.deltaTime);
			base.Anim.SetFloat(WalkCycleHash, walkCycle);
			base.Anim.SetBool(StrangleHash, _strangle.SyncTarget.HasValue);
			bool flag = _scpRole.Disguised || _dance.ThirdpersonMode;
			_handsGraphics.SetActive(!flag);
		}

		private void PlayAttackAnim()
		{
			int num;
			do
			{
				num = Mathf.FloorToInt(Random.Range(_attackVariantMinMax.x, _attackVariantMinMax.y));
			}
			while (num == _prevRand);
			base.Anim.SetFloat(VariantHash, Mathf.Floor(num));
			base.Anim.SetTrigger(AttackHash);
			_prevRand = num;
		}
	}
}
