namespace LabApi.Features.Wrappers
{
	public class Scp1853Item : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1853Item, global::LabApi.Features.Wrappers.Scp1853Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1853Item, global::LabApi.Features.Wrappers.Scp1853Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp1853Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp1853Item Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseScp1853Item")]
		public static global::LabApi.Features.Wrappers.Scp1853Item? Get(global::InventorySystem.Items.Usables.Scp1853Item? baseScp1853Item)
		{
			if (baseScp1853Item == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseScp1853Item, out global::LabApi.Features.Wrappers.Scp1853Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp1853Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseScp1853Item);
			}
			return value;
		}

		internal Scp1853Item(global::InventorySystem.Items.Usables.Scp1853Item baseScp1853Item)
			: base(baseScp1853Item)
		{
			Base = baseScp1853Item;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp1853Item, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
