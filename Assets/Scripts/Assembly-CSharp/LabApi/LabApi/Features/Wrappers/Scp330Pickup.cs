namespace LabApi.Features.Wrappers
{
	public class Scp330Pickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp330.Scp330Pickup, global::LabApi.Features.Wrappers.Scp330Pickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp330.Scp330Pickup, global::LabApi.Features.Wrappers.Scp330Pickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp330Pickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp330.Scp330Pickup Base { get; }

		public global::System.Collections.Generic.List<global::InventorySystem.Items.Usables.Scp330.CandyKindID> Candies => Base.StoredCandies;

		public global::InventorySystem.Items.Usables.Scp330.CandyKindID ExposedCandy
		{
			get
			{
				return Base.ExposedCandy;
			}
			set
			{
				Base.NetworkExposedCandy = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.Scp330Pickup? Get(global::InventorySystem.Items.Usables.Scp330.Scp330Pickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.Scp330Pickup value))
			{
				return (global::LabApi.Features.Wrappers.Scp330Pickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal Scp330Pickup(global::InventorySystem.Items.Usables.Scp330.Scp330Pickup baseScp330Pickup)
			: base(baseScp330Pickup)
		{
			Base = baseScp330Pickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp330Pickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
