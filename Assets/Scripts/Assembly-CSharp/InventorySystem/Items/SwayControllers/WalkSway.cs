using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.SwayControllers
{
	public class WalkSway : GoopSway
	{
		private const float LayerAdjustSpeed = 6f;

		private const float ParamAdjustLerp = 4f;

		private const string WalkSwayLayerName = "Sway Walk";

		private const string JumpSwayLayerName = "Sway Jump";

		public static readonly int SwayWalkHash = Animator.StringToHash("SwayWalk");

		public static readonly int SwayJumpingHash = Animator.StringToHash("SwayJumping");

		private readonly bool _supportsAnimSway;

		private readonly int _walkStateHash;

		private readonly int _walkLayer;

		private readonly float _walkSwayWeightMultiplier;

		private readonly float _walkSwayCycleScale;

		private readonly int _jumpLayer;

		private readonly float _jumpSwayWeightMultiplier;

		private readonly AnimatedViewmodelBase _viewmodel;

		private float _prevWalkWeight;

		private float _prevWalkParam;

		private float ScaledWalkCycle
		{
			get
			{
				if (!(Owner.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					return 0f;
				}
				if (!(fpcRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel))
				{
					return 0f;
				}
				float num = _walkSwayCycleScale * animatedCharacterModel.WalkCycleRaw;
				if (!float.IsNaN(num))
				{
					return num - (float)(int)num;
				}
				return 0f;
			}
		}

		private float NormalizedRunningSpeed
		{
			get
			{
				if (!(Owner.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					return 0f;
				}
				FirstPersonMovementModule fpcModule = fpcRole.FpcModule;
				float num = fpcModule.VelocityForState(PlayerMovementState.Sprinting, applyCrouch: false);
				float num2 = fpcModule.Motor.Velocity.MagnitudeIgnoreY();
				if (num <= 0f)
				{
					return 0f;
				}
				return Mathf.Clamp01(num2 / num);
			}
		}

		private bool IsJumping => !Owner.IsGrounded();

		protected virtual float JumpSwayWeightMultiplier => _jumpSwayWeightMultiplier;

		protected virtual float WalkSwayWeightMultiplier => _walkSwayWeightMultiplier;

		public WalkSway(GoopSwaySettings hipSettings, AnimatedViewmodelBase vm)
			: base(hipSettings, vm.Hub)
		{
			_viewmodel = vm;
			_supportsAnimSway = TryInitAnimSway(out _walkLayer, out _walkSwayWeightMultiplier, out _walkStateHash, out _jumpLayer, out _jumpSwayWeightMultiplier, out _walkSwayCycleScale);
		}

		private bool TryInitAnimSway(out int walkLayer, out float walkWeight, out int walkStateHash, out int jumpLayer, out float jumpWeight, out float cycleScale)
		{
			walkLayer = 0;
			walkWeight = 0f;
			walkStateHash = 0;
			jumpLayer = 0;
			jumpWeight = 0f;
			cycleScale = 0f;
			int num = _viewmodel.AnimatorGetLayerCount();
			bool flag = false;
			bool flag2 = false;
			for (int num2 = num - 1; num2 >= 0; num2--)
			{
				string text = _viewmodel.AnimatorGetLayerName(num2);
				if (!(text == "Sway Walk"))
				{
					if (text == "Sway Jump")
					{
						flag2 = true;
						jumpLayer = num2;
						jumpWeight = _viewmodel.AnimatorGetLayerWeight(num2);
					}
				}
				else
				{
					flag = true;
					walkLayer = num2;
					walkWeight = _viewmodel.AnimatorGetLayerWeight(num2);
					AnimatorStateInfo animatorStateInfo = _viewmodel.AnimatorStateInfo(num2);
					walkStateHash = animatorStateInfo.shortNameHash;
					cycleScale = animatorStateInfo.speed;
				}
				if (flag & flag2)
				{
					return true;
				}
			}
			return false;
		}

		public override void UpdateSway()
		{
			base.UpdateSway();
			if (_supportsAnimSway)
			{
				float num = Mathf.Clamp01(NormalizedRunningSpeed);
				float num2 = Mathf.MoveTowards(_prevWalkWeight, num, Time.deltaTime * 6f);
				float num3 = Mathf.Lerp(_prevWalkParam, num, Time.deltaTime * 4f);
				_prevWalkWeight = num2;
				_prevWalkParam = num3;
				_viewmodel.AnimatorSetLayerWeight(_walkLayer, num2 * WalkSwayWeightMultiplier);
				_viewmodel.AnimatorSetLayerWeight(_jumpLayer, JumpSwayWeightMultiplier);
				_viewmodel.AnimatorSetBool(SwayJumpingHash, IsJumping);
				_viewmodel.AnimatorSetFloat(SwayWalkHash, num3);
				_viewmodel.AnimatorPlay(_walkStateHash, _walkLayer, ScaledWalkCycle);
			}
		}
	}
}
