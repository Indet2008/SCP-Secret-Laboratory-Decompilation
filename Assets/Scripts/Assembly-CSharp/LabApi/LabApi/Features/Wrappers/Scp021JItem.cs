namespace LabApi.Features.Wrappers
{
	public class Scp021JItem : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp021J, global::LabApi.Features.Wrappers.Scp021JItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp021J, global::LabApi.Features.Wrappers.Scp021JItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp021JItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp021J Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseScp021JItem")]
		public static global::LabApi.Features.Wrappers.Scp021JItem? Get(global::InventorySystem.Items.Usables.Scp021J? baseScp021JItem)
		{
			if (baseScp021JItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseScp021JItem, out global::LabApi.Features.Wrappers.Scp021JItem value))
			{
				return (global::LabApi.Features.Wrappers.Scp021JItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseScp021JItem);
			}
			return value;
		}

		internal Scp021JItem(global::InventorySystem.Items.Usables.Scp021J baseScp021JItem)
			: base(baseScp021JItem)
		{
			Base = baseScp021JItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp021JItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
