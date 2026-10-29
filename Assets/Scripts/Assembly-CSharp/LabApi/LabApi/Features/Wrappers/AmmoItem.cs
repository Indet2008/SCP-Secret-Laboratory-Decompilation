namespace LabApi.Features.Wrappers
{
	public class AmmoItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.Ammo.AmmoItem, global::LabApi.Features.Wrappers.AmmoItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.Ammo.AmmoItem, global::LabApi.Features.Wrappers.AmmoItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.AmmoItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Firearms.Ammo.AmmoItem Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseAmmoItem")]
		public static global::LabApi.Features.Wrappers.AmmoItem? Get(global::InventorySystem.Items.Firearms.Ammo.AmmoItem? baseAmmoItem)
		{
			if (baseAmmoItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseAmmoItem, out global::LabApi.Features.Wrappers.AmmoItem value))
			{
				return (global::LabApi.Features.Wrappers.AmmoItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseAmmoItem);
			}
			return value;
		}

		internal AmmoItem(global::InventorySystem.Items.Firearms.Ammo.AmmoItem baseAmmoItem)
			: base(baseAmmoItem)
		{
			Base = baseAmmoItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseAmmoItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
