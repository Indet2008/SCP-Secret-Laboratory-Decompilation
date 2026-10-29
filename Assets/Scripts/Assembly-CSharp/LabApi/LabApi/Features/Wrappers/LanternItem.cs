namespace LabApi.Features.Wrappers
{
	public class LanternItem : global::LabApi.Features.Wrappers.LightItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ToggleableLights.Lantern.LanternItem, global::LabApi.Features.Wrappers.LanternItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ToggleableLights.Lantern.LanternItem, global::LabApi.Features.Wrappers.LanternItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.LanternItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.ToggleableLights.Lantern.LanternItem Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseLanternItem")]
		public static global::LabApi.Features.Wrappers.LanternItem? Get(global::InventorySystem.Items.ToggleableLights.Lantern.LanternItem? baseLanternItem)
		{
			if (baseLanternItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseLanternItem, out global::LabApi.Features.Wrappers.LanternItem value))
			{
				return (global::LabApi.Features.Wrappers.LanternItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseLanternItem);
			}
			return value;
		}

		internal LanternItem(global::InventorySystem.Items.ToggleableLights.Lantern.LanternItem baseLanternItem)
			: base(baseLanternItem)
		{
			Base = baseLanternItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseLanternItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
