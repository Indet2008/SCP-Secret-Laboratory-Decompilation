namespace LabApi.Features.Wrappers
{
	public class BodyArmorItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Armor.BodyArmor, global::LabApi.Features.Wrappers.BodyArmorItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Armor.BodyArmor, global::LabApi.Features.Wrappers.BodyArmorItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.BodyArmorItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Armor.BodyArmor Base { get; }

		[global::System.Obsolete("No longer usable", true)]
		public bool RemoveExcessOnDrop
		{
			get
			{
				return false;
			}
			set
			{
				value = false;
			}
		}

		public bool IsMovementModifierActive => Base.MovementModifierActive;

		public float ActualMovementSpeedMultiplier => Base.MovementSpeedMultiplier;

		public bool IsStaminaModifierActive => Base.StaminaModifierActive;

		public float ActualStaminaUsageMultiplier => Base.StaminaUsageMultiplier;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("bodyArmor")]
		public static global::LabApi.Features.Wrappers.BodyArmorItem? Get(global::InventorySystem.Items.Armor.BodyArmor? bodyArmor)
		{
			if (bodyArmor == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(bodyArmor, out global::LabApi.Features.Wrappers.BodyArmorItem value))
			{
				return (global::LabApi.Features.Wrappers.BodyArmorItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(bodyArmor);
			}
			return value;
		}

		internal BodyArmorItem(global::InventorySystem.Items.Armor.BodyArmor bodyArmor)
			: base(bodyArmor)
		{
			Base = bodyArmor;
			if (base.CanCache)
			{
				Dictionary.Add(bodyArmor, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
