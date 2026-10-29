namespace LabApi.Features.Wrappers
{
	public class Scp207Item : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp207, global::LabApi.Features.Wrappers.Scp207Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp207, global::LabApi.Features.Wrappers.Scp207Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp207Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp207 Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("scp207")]
		public static global::LabApi.Features.Wrappers.Scp207Item? Get(global::InventorySystem.Items.Usables.Scp207? scp207)
		{
			if (scp207 == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(scp207, out global::LabApi.Features.Wrappers.Scp207Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp207Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(scp207);
			}
			return value;
		}

		internal Scp207Item(global::InventorySystem.Items.Usables.Scp207 scp207)
			: base(scp207)
		{
			Base = scp207;
			if (base.CanCache)
			{
				Dictionary.Add(scp207, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
