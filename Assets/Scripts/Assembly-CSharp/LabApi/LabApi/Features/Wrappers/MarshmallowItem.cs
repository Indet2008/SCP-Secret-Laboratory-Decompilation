namespace LabApi.Features.Wrappers
{
	public class MarshmallowItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MarshmallowMan.MarshmallowItem, global::LabApi.Features.Wrappers.MarshmallowItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MarshmallowMan.MarshmallowItem, global::LabApi.Features.Wrappers.MarshmallowItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.MarshmallowItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.MarshmallowMan.MarshmallowItem Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseMarshmallowItem")]
		public static global::LabApi.Features.Wrappers.MarshmallowItem? Get(global::InventorySystem.Items.MarshmallowMan.MarshmallowItem? baseMarshmallowItem)
		{
			if (baseMarshmallowItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseMarshmallowItem, out global::LabApi.Features.Wrappers.MarshmallowItem value))
			{
				return (global::LabApi.Features.Wrappers.MarshmallowItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseMarshmallowItem);
			}
			return value;
		}

		internal MarshmallowItem(global::InventorySystem.Items.MarshmallowMan.MarshmallowItem baseMarshmallowItem)
			: base(baseMarshmallowItem)
		{
			Base = baseMarshmallowItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseMarshmallowItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
