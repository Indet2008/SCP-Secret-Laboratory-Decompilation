namespace LabApi.Features.Wrappers
{
	public class Scp1344Item : global::LabApi.Features.Wrappers.UsableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1344.Scp1344Item, global::LabApi.Features.Wrappers.Scp1344Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1344.Scp1344Item, global::LabApi.Features.Wrappers.Scp1344Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp1344Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp1344.Scp1344Item Base { get; }

		public bool IsWorn => Base.IsWorn;

		public global::InventorySystem.Items.Usables.Scp1344.Scp1344Status Status
		{
			get
			{
				return Base.Status;
			}
			set
			{
				Base.Status = value;
			}
		}

		public global::CustomPlayerEffects.Scp1344 Scp1344Effect => Base.Scp1344Effect;

		public global::CustomPlayerEffects.Blindness BlindnessEffect => Base.BlindnessEffect;

		public global::CustomPlayerEffects.SeveredEyes SeveredEyesEffect => Base.SeveredEyesEffect;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseItem")]
		public static global::LabApi.Features.Wrappers.Scp1344Item? Get(global::InventorySystem.Items.Usables.Scp1344.Scp1344Item? baseItem)
		{
			if (baseItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseItem, out global::LabApi.Features.Wrappers.Scp1344Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp1344Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseItem);
			}
			return value;
		}

		internal Scp1344Item(global::InventorySystem.Items.Usables.Scp1344.Scp1344Item baseItem)
			: base(baseItem)
		{
			Base = baseItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
