using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.Extensions;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class MovementInaccuracyModule : ModuleBase, IDisplayableInaccuracyProviderModule, IInaccuracyProviderModule
	{
		private const float JumpingPenalty = 3f;

		private const float VariableMovementOffset = 1f;

		private const float SneakSpeedMultiplier = 1.1f;

		[field: SerializeField]
		public float MinPenalty { get; private set; }

		[field: SerializeField]
		public float MaxPenalty { get; private set; }

		public DisplayInaccuracyValues DisplayInaccuracy => new DisplayInaccuracyValues(0f, 0f, TargetRunningInaccuracy);

		public float Inaccuracy
		{
			get
			{
				float targetRunningInaccuracy = TargetRunningInaccuracy;
				if (!(base.Firearm.Owner.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					return 0f;
				}
				if (!fpcRole.FpcModule.IsGrounded)
				{
					return targetRunningInaccuracy + 3f;
				}
				float num = fpcRole.FpcModule.Motor.Velocity.MagnitudeIgnoreY();
				float num2 = fpcRole.FpcModule.SneakSpeed * 1.1f;
				float sprintSpeed = fpcRole.FpcModule.SprintSpeed;
				if (num < sprintSpeed - 1f && num2 < num)
				{
					num = num2;
				}
				float num3 = EaseInUtils.EaseInOutCubic(num / sprintSpeed);
				return targetRunningInaccuracy * num3;
			}
		}

		private float TargetRunningInaccuracy
		{
			get
			{
				FirearmParameterLimitDefinition firearmParameterLimitDefinition = FirearmParameterLimitDefinition.Get(base.Firearm.ItemTypeId);
				float num = base.Firearm.AttachmentsValue(AttachmentParam.RunningInaccuracyMultiplier);
				float num2 = Mathf.InverseLerp(firearmParameterLimitDefinition.Shortest, firearmParameterLimitDefinition.Longest, base.Firearm.Length);
				float num3 = Mathf.InverseLerp(firearmParameterLimitDefinition.Lightest, firearmParameterLimitDefinition.Heaviest, base.Firearm.Weight);
				float t = (num2 + num3) / 2f;
				return Mathf.Lerp(MinPenalty, MaxPenalty, t) * num;
			}
		}
	}
}
