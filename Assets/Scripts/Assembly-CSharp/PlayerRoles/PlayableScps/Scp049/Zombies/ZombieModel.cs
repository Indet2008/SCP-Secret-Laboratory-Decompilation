using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieModel : AnimatedCharacterModel
	{
		private const int StrafeLayer = 6;

		private const int ConsumeLayer = 8;

		private const float ConsumeTransitionSpeed = 10f;

		private static readonly int StrafeHash = Animator.StringToHash("Strafe");

		private static readonly int AttackHash = Animator.StringToHash("Attack");

		private static readonly int ConsumeHash = Animator.StringToHash("Eat");

		private ZombieAttackAbility _attackAbility;

		private ZombieConsumeAbility _consumeAbility;

		private float _prevConsume;

		[field: SerializeField]
		public Transform HeadObject { get; private set; }

		private void OnAttack()
		{
			base.Animator.SetTrigger(AttackHash);
		}

		protected override void Update()
		{
			base.Update();
			float value = Mathf.Abs(base.Animator.GetFloat(StrafeHash));
			base.Animator.SetLayerWeight(6, Mathf.Clamp01(value));
			if (!base.HasOwner)
			{
				return;
			}
			float num = Mathf.Clamp01(_prevConsume + Time.deltaTime * 10f * (float)(_consumeAbility.IsInProgress ? 1 : (-1)));
			if (_prevConsume != num)
			{
				if (_prevConsume == 0f)
				{
					base.Animator.SetTrigger(ConsumeHash);
				}
				base.Animator.SetLayerWeight(8, num);
				_prevConsume = num;
			}
		}

		public override void Setup(ReferenceHub owner, IFpcRole fpc, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, fpc, localPos, localRot);
			ZombieRole obj = base.OwnerHub.roleManager.CurrentRole as ZombieRole;
			obj.SubroutineModule.TryGetSubroutine<ZombieConsumeAbility>(out _consumeAbility);
			obj.SubroutineModule.TryGetSubroutine<ZombieAttackAbility>(out _attackAbility);
			_attackAbility.OnTriggered += OnAttack;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_attackAbility.OnTriggered -= OnAttack;
			_prevConsume = 0f;
		}
	}
}
