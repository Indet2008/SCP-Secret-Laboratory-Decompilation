namespace LabApi.Features.Wrappers
{
	public class FlashlightItem : global::LabApi.Features.Wrappers.LightItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ToggleableLights.Flashlight.FlashlightItem, global::LabApi.Features.Wrappers.FlashlightItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ToggleableLights.Flashlight.FlashlightItem, global::LabApi.Features.Wrappers.FlashlightItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.FlashlightItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.ToggleableLights.Flashlight.FlashlightItem Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseFlashlightItem")]
		public static global::LabApi.Features.Wrappers.FlashlightItem? Get(global::InventorySystem.Items.ToggleableLights.Flashlight.FlashlightItem? baseFlashlightItem)
		{
			if (baseFlashlightItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseFlashlightItem, out global::LabApi.Features.Wrappers.FlashlightItem value))
			{
				return (global::LabApi.Features.Wrappers.FlashlightItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseFlashlightItem);
			}
			return value;
		}

		internal FlashlightItem(global::InventorySystem.Items.ToggleableLights.Flashlight.FlashlightItem baseFlashlightItem)
			: base(baseFlashlightItem)
		{
			Base = baseFlashlightItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseFlashlightItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
