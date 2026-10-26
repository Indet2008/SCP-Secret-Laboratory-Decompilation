using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace InventorySystem.Items.MarshmallowMan
{
	public class MarshmallowViewmodel : StandardAnimatedViemodel
	{
		[SerializeField]
		private int _attackVariants;

		private int _curAttackVariant;

		private float _prevVel;

		private static readonly int AttackVariantHash = Animator.StringToHash("AttackVariant");

		private static readonly int AttackTriggerHash = Animator.StringToHash("Attack");

		private static readonly int HolsterTriggerHash = Animator.StringToHash("Holster");

		private static readonly int WalkCycleHash = Animator.StringToHash("WalkCycle");

		private const float VelAdjustSpeed = 28.5f;

		private const int WalkLayer = 2;

		private void Awake()
		{
			_curAttackVariant = Random.Range(0, _attackVariants);
			MarshmallowItem.OnSwing += OnSwing;
			MarshmallowItem.OnHolsterRequested += OnHolsterRequested;
		}

		private void OnDestroy()
		{
			MarshmallowItem.OnSwing -= OnSwing;
			MarshmallowItem.OnHolsterRequested -= OnHolsterRequested;
		}

		private void Update()
		{
			if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole && fpcRole.FpcModule.CharacterModelInstance is AnimatedCharacterModel animatedCharacterModel)
			{
				float target = (base.Hub.IsGrounded() ? base.Hub.GetVelocity().MagnitudeIgnoreY() : 0f);
				_prevVel = Mathf.MoveTowards(_prevVel, target, Time.deltaTime * 28.5f);
				AnimatorSetFloat(WalkCycleHash, animatedCharacterModel.WalkCycle);
				AnimatorSetLayerWeight(2, animatedCharacterModel.WalkLayerWeight);
			}
		}

		private void OnHolsterRequested(ushort serial)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				AnimatorSetTrigger(HolsterTriggerHash);
			}
		}

		private void OnSwing(ushort serial)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				_curAttackVariant++;
				AnimatorSetFloat(AttackVariantHash, _curAttackVariant % _attackVariants);
				AnimatorSetTrigger(AttackTriggerHash);
			}
		}

		public override void InitLocal(ItemBase ib)
		{
			base.InitLocal(ib);
			GetComponent<MarshmallowAudio>().Setup(ib.ItemSerial, ib.Owner.transform);
		}
	}
}
