namespace LabApi.Features.Wrappers
{
	public class PainkillersItem : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Painkillers, global::LabApi.Features.Wrappers.PainkillersItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Painkillers, global::LabApi.Features.Wrappers.PainkillersItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.PainkillersItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Painkillers Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("painkillers")]
		public static global::LabApi.Features.Wrappers.PainkillersItem? Get(global::InventorySystem.Items.Usables.Painkillers? painkillers)
		{
			if (painkillers == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(painkillers, out global::LabApi.Features.Wrappers.PainkillersItem value))
			{
				return (global::LabApi.Features.Wrappers.PainkillersItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(painkillers);
			}
			return value;
		}

		internal PainkillersItem(global::InventorySystem.Items.Usables.Painkillers painkillers)
			: base(painkillers)
		{
			Base = painkillers;
			if (base.CanCache)
			{
				Dictionary.Add(painkillers, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
