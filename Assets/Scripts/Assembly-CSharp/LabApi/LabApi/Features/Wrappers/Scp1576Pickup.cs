namespace LabApi.Features.Wrappers
{
	public class Scp1576Pickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1576.Scp1576Pickup, global::LabApi.Features.Wrappers.Scp1576Pickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp1576.Scp1576Pickup, global::LabApi.Features.Wrappers.Scp1576Pickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp1576Pickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp1576.Scp1576Pickup Base { get; }

		public float HornPosition
		{
			get
			{
				return Base.HornPos;
			}
			set
			{
				Base.HornPos = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.Scp1576Pickup? Get(global::InventorySystem.Items.Usables.Scp1576.Scp1576Pickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.Scp1576Pickup value))
			{
				return (global::LabApi.Features.Wrappers.Scp1576Pickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal Scp1576Pickup(global::InventorySystem.Items.Usables.Scp1576.Scp1576Pickup baseScp1576Pickup)
			: base(baseScp1576Pickup)
		{
			Base = baseScp1576Pickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp1576Pickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
