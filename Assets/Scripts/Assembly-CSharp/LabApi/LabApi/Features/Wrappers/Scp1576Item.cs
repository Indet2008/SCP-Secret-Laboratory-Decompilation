namespace LabApi.Features.Wrappers
{
	public class Scp1576Item : global::LabApi.Features.Wrappers.UsableItem
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1576.Scp1576Item, global::LabApi.Features.Wrappers.Scp1576Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1576.Scp1576Item, global::LabApi.Features.Wrappers.Scp1576Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp1576Item> List => Dictionary.Values;

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> TransmitterList => global::System.Linq.Enumerable.Where(global::LabApi.Features.Wrappers.Player.List, (global::LabApi.Features.Wrappers.Player player) => player.HasEffect<global::CustomPlayerEffects.Scp1576>());

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> ReceiverList => global::System.Linq.Enumerable.Select(global::InventorySystem.Items.Usables.Scp1576.Scp1576Item.ValidatedReceivers, (ReferenceHub x) => global::LabApi.Features.Wrappers.Player.Get(x));

		public new global::InventorySystem.Items.Usables.Scp1576.Scp1576Item Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseScp1576Item")]
		public static global::LabApi.Features.Wrappers.Scp1576Item? Get(global::InventorySystem.Items.Usables.Scp1576.Scp1576Item? baseScp1576Item)
		{
			if (baseScp1576Item == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseScp1576Item, out global::LabApi.Features.Wrappers.Scp1576Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp1576Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseScp1576Item);
			}
			return value;
		}

		internal Scp1576Item(global::InventorySystem.Items.Usables.Scp1576.Scp1576Item baseScp1576Item)
			: base(baseScp1576Item)
		{
			Base = baseScp1576Item;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp1576Item, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
