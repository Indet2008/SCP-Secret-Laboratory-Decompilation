namespace LabApi.Features.Wrappers
{
	public class AdrenalineItem : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Adrenaline, global::LabApi.Features.Wrappers.AdrenalineItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Adrenaline, global::LabApi.Features.Wrappers.AdrenalineItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.AdrenalineItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Adrenaline Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("adrenaline")]
		public static global::LabApi.Features.Wrappers.AdrenalineItem? Get(global::InventorySystem.Items.Usables.Adrenaline? adrenaline)
		{
			if (adrenaline == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(adrenaline, out global::LabApi.Features.Wrappers.AdrenalineItem value))
			{
				return (global::LabApi.Features.Wrappers.AdrenalineItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(adrenaline);
			}
			return value;
		}

		internal AdrenalineItem(global::InventorySystem.Items.Usables.Adrenaline adrenaline)
			: base(adrenaline)
		{
			Base = adrenaline;
			if (base.CanCache)
			{
				Dictionary.Add(adrenaline, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
