using InventorySystem.Items.Firearms.Extensions;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class MovementPenaltyModule : ModuleBase, ISprintSpeedModifier, IStaminaModifier
	{
		[field: SerializeField]
		public float MinSprintPenaltyPercent { get; private set; }

		[field: SerializeField]
		public float MaxSprintPenaltyPercent { get; private set; }

		[field: SerializeField]
		public float MinStaminaPenaltyPercent { get; private set; }

		[field: SerializeField]
		public float MaxStaminaPenaltyPercent { get; private set; }

		public bool SprintModifierActive => true;

		public float SprintSpeedMultiplier => Mathf.Min(1f - Mathf.Lerp(MinSprintPenaltyPercent, MaxSprintPenaltyPercent, WeightPercentage) / 100f, 1f);

		public bool StaminaModifierActive => true;

		public float StaminaUsageMultiplier => Mathf.Max(1f + Mathf.Lerp(MinStaminaPenaltyPercent, MaxStaminaPenaltyPercent, WeightPercentage) / 100f, 1f);

		private float WeightPercentage
		{
			get
			{
				if ((object)base.Firearm == null)
				{
					return 0f;
				}
				FirearmParameterLimitDefinition firearmParameterLimitDefinition = FirearmParameterLimitDefinition.Get(base.Firearm.ItemTypeId);
				return Mathf.InverseLerp(firearmParameterLimitDefinition.Lightest, firearmParameterLimitDefinition.Heaviest, base.Firearm.Weight);
			}
		}
	}
}
