namespace LabApi.Features.Wrappers
{
	public class Scp244Item : global::LabApi.Features.Wrappers.UsableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp244.Scp244Item, global::LabApi.Features.Wrappers.Scp244Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp244.Scp244Item, global::LabApi.Features.Wrappers.Scp244Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp244Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp244.Scp244Item Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseScp244Item")]
		public static global::LabApi.Features.Wrappers.Scp244Item? Get(global::InventorySystem.Items.Usables.Scp244.Scp244Item? baseScp244Item)
		{
			if (baseScp244Item == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseScp244Item, out global::LabApi.Features.Wrappers.Scp244Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp244Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseScp244Item);
			}
			return value;
		}

		internal Scp244Item(global::InventorySystem.Items.Usables.Scp244.Scp244Item baseScp244Item)
			: base(baseScp244Item)
		{
			Base = baseScp244Item;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp244Item, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
