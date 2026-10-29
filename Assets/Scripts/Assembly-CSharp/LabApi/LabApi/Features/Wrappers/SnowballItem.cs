namespace LabApi.Features.Wrappers
{
	public class SnowballItem : global::LabApi.Features.Wrappers.ThrowableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.SnowballItem, global::LabApi.Features.Wrappers.SnowballItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.SnowballItem, global::LabApi.Features.Wrappers.SnowballItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.SnowballItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.SnowballItem Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseSnowballItem")]
		public static global::LabApi.Features.Wrappers.SnowballItem? Get(global::InventorySystem.Items.ThrowableProjectiles.SnowballItem? baseSnowballItem)
		{
			if (baseSnowballItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseSnowballItem, out global::LabApi.Features.Wrappers.SnowballItem value))
			{
				return (global::LabApi.Features.Wrappers.SnowballItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseSnowballItem);
			}
			return value;
		}

		internal SnowballItem(global::InventorySystem.Items.ThrowableProjectiles.SnowballItem baseThrowableItem)
			: base(baseThrowableItem)
		{
			Base = baseThrowableItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseThrowableItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
