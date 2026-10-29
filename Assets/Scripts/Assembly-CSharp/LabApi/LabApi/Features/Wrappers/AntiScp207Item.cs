namespace LabApi.Features.Wrappers
{
	public class AntiScp207Item : global::LabApi.Features.Wrappers.ConsumableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.AntiScp207, global::LabApi.Features.Wrappers.AntiScp207Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.AntiScp207, global::LabApi.Features.Wrappers.AntiScp207Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.AntiScp207Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.AntiScp207 Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("antiScp207")]
		public static global::LabApi.Features.Wrappers.AntiScp207Item? Get(global::InventorySystem.Items.Usables.AntiScp207? antiScp207)
		{
			if (antiScp207 == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(antiScp207, out global::LabApi.Features.Wrappers.AntiScp207Item value))
			{
				return (global::LabApi.Features.Wrappers.AntiScp207Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(antiScp207);
			}
			return value;
		}

		internal AntiScp207Item(global::InventorySystem.Items.Usables.AntiScp207 antiScp207)
			: base(antiScp207)
		{
			Base = antiScp207;
			if (base.CanCache)
			{
				Dictionary.Add(antiScp207, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
