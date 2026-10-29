namespace LabApi.Features.Wrappers
{
	public class MedkitItem : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Medkit, global::LabApi.Features.Wrappers.MedkitItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Medkit, global::LabApi.Features.Wrappers.MedkitItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.MedkitItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Medkit Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("medkit")]
		public static global::LabApi.Features.Wrappers.MedkitItem? Get(global::InventorySystem.Items.Usables.Medkit? medkit)
		{
			if (medkit == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(medkit, out global::LabApi.Features.Wrappers.MedkitItem value))
			{
				return (global::LabApi.Features.Wrappers.MedkitItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(medkit);
			}
			return value;
		}

		internal MedkitItem(global::InventorySystem.Items.Usables.Medkit medkit)
			: base(medkit)
		{
			Base = medkit;
			if (base.CanCache)
			{
				Dictionary.Add(medkit, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
