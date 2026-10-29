namespace LabApi.Features.Wrappers
{
	public class ConsumableItem : global::LabApi.Features.Wrappers.UsableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Consumable, global::LabApi.Features.Wrappers.ConsumableItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Consumable, global::LabApi.Features.Wrappers.ConsumableItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.ConsumableItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Consumable Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("consumable")]
		public static global::LabApi.Features.Wrappers.ConsumableItem? Get(global::InventorySystem.Items.Usables.Consumable? consumable)
		{
			if (consumable == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(consumable, out global::LabApi.Features.Wrappers.ConsumableItem value))
			{
				return (global::LabApi.Features.Wrappers.ConsumableItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(consumable);
			}
			return value;
		}

		internal ConsumableItem(global::InventorySystem.Items.Usables.Consumable consumable)
			: base(consumable)
		{
			Base = consumable;
			if (base.CanCache)
			{
				Dictionary.Add(consumable, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
