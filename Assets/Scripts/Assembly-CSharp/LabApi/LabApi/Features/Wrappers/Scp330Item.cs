namespace LabApi.Features.Wrappers
{
	public class Scp330Item : global::LabApi.Features.Wrappers.UsableItem
	{
		public const int MaxCandies = 6;

		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp330.Scp330Bag, global::LabApi.Features.Wrappers.Scp330Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp330.Scp330Bag, global::LabApi.Features.Wrappers.Scp330Item>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp330Item> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp330.Scp330Bag Base { get; }

		public global::System.Collections.Generic.IReadOnlyList<global::InventorySystem.Items.Usables.Scp330.CandyKindID> Candies => Base.Candies;

		public int SelectedCandyIndex => Base.SelectedCandyId;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseScp330Item")]
		public static global::LabApi.Features.Wrappers.Scp330Item? Get(global::InventorySystem.Items.Usables.Scp330.Scp330Bag? baseScp330Item)
		{
			if (baseScp330Item == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseScp330Item, out global::LabApi.Features.Wrappers.Scp330Item value))
			{
				return (global::LabApi.Features.Wrappers.Scp330Item)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseScp330Item);
			}
			return value;
		}

		internal Scp330Item(global::InventorySystem.Items.Usables.Scp330.Scp330Bag baseScp330Item)
			: base(baseScp330Item)
		{
			Base = baseScp330Item;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp330Item, this);
			}
		}

		public void AddCandies(global::System.Collections.Generic.IEnumerable<global::InventorySystem.Items.Usables.Scp330.CandyKindID> candies, bool sync = true)
		{
			global::System.Collections.Generic.IEnumerator<global::InventorySystem.Items.Usables.Scp330.CandyKindID> enumerator = candies.GetEnumerator();
			while (enumerator.MoveNext() && Base.Candies.Count < 6)
			{
				Base.Candies.Add(enumerator.Current);
			}
			if (sync)
			{
				SyncCandies();
			}
		}

		public void RemoveCandies(global::System.Collections.Generic.IEnumerable<global::InventorySystem.Items.Usables.Scp330.CandyKindID> candies, bool sync = true)
		{
			global::System.Collections.Generic.IEnumerator<global::InventorySystem.Items.Usables.Scp330.CandyKindID> enumerator = candies.GetEnumerator();
			while (enumerator.MoveNext() && !Base.Candies.IsEmpty())
			{
				Base.Candies.Remove(enumerator.Current);
			}
			if (sync)
			{
				SyncCandies();
			}
		}

		public void SetCandies(global::System.Collections.Generic.IEnumerable<global::InventorySystem.Items.Usables.Scp330.CandyKindID> candies, bool sync = true)
		{
			Base.Candies.Clear();
			AddCandies(candies, sync);
		}

		public void SyncCandies()
		{
			Base.ServerRefreshBag();
		}

		public bool TryDrop(global::InventorySystem.Items.Usables.Scp330.CandyKindID kind, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Pickup? dropped)
		{
			dropped = null;
			if (!global::System.Linq.Enumerable.Contains(Candies, kind))
			{
				return false;
			}
			if (base.CurrentOwner == null)
			{
				return false;
			}
			dropped = global::LabApi.Features.Wrappers.Pickup.Create(base.Type, base.CurrentOwner.Position);
			if (dropped == null)
			{
				return false;
			}
			((global::LabApi.Features.Wrappers.Scp330Pickup)dropped).ExposedCandy = kind;
			RemoveCandies(new _003C_003Ez__ReadOnlySingleElementList<global::InventorySystem.Items.Usables.Scp330.CandyKindID>(kind));
			return true;
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
