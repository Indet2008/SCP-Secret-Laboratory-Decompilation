namespace LabApi.Features.Wrappers
{
	public class BodyArmorPickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Armor.BodyArmorPickup, global::LabApi.Features.Wrappers.BodyArmorPickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Armor.BodyArmorPickup, global::LabApi.Features.Wrappers.BodyArmorPickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.BodyArmorPickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Armor.BodyArmorPickup Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.BodyArmorPickup? Get(global::InventorySystem.Items.Armor.BodyArmorPickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.BodyArmorPickup value))
			{
				return (global::LabApi.Features.Wrappers.BodyArmorPickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal BodyArmorPickup(global::InventorySystem.Items.Armor.BodyArmorPickup baseBodyArmorPickup)
			: base(baseBodyArmorPickup)
		{
			Base = baseBodyArmorPickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseBodyArmorPickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
