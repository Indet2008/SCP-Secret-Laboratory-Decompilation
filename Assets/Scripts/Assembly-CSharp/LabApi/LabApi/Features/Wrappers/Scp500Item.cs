namespace LabApi.Features.Wrappers
{
	public class Scp500Item : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp500, global::LabApi.Features.Wrappers.Scp500Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp500, global::LabApi.Features.Wrappers.Scp500Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp500Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp500 Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("scp500")]
		public static global::LabApi.Features.Wrappers.Scp500Item? Get(global::InventorySystem.Items.Usables.Scp500? scp500)
		{
			if (scp500 == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(scp500, out global::LabApi.Features.Wrappers.Scp500Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp500Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(scp500);
			}
			return value;
		}

		internal Scp500Item(global::InventorySystem.Items.Usables.Scp500 scp500)
			: base(scp500)
		{
			Base = scp500;
			if (base.CanCache)
			{
				Dictionary.Add(scp500, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
