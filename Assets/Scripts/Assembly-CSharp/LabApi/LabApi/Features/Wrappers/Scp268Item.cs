namespace LabApi.Features.Wrappers
{
	public class Scp268Item : global::LabApi.Features.Wrappers.UsableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp268, global::LabApi.Features.Wrappers.Scp268Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp268, global::LabApi.Features.Wrappers.Scp268Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp268Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp268 Base { get; }

		public bool IsWorn
		{
			get
			{
				return Base.IsWorn;
			}
			set
			{
				Base.IsWorn = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("scp268")]
		public static global::LabApi.Features.Wrappers.Scp268Item? Get(global::InventorySystem.Items.Usables.Scp268? scp268)
		{
			if (scp268 == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(scp268, out global::LabApi.Features.Wrappers.Scp268Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp268Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(scp268);
			}
			return value;
		}

		internal Scp268Item(global::InventorySystem.Items.Usables.Scp268 scp268)
			: base(scp268)
		{
			Base = scp268;
			if (base.CanCache)
			{
				Dictionary.Add(scp268, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
