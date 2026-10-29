namespace LabApi.Features.Wrappers
{
	public class Scp244Pickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp244.Scp244DeployablePickup, global::LabApi.Features.Wrappers.Scp244Pickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Usables.Scp244.Scp244DeployablePickup, global::LabApi.Features.Wrappers.Scp244Pickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp244Pickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Usables.Scp244.Scp244DeployablePickup Base { get; }

		public global::InventorySystem.Items.Usables.Scp244.Scp244State State
		{
			get
			{
				return Base.State;
			}
			set
			{
				Base.State = value;
			}
		}

		public float SizePercent => Base.CurrentSizePercent;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.Scp244Pickup? Get(global::InventorySystem.Items.Usables.Scp244.Scp244DeployablePickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.Scp244Pickup value))
			{
				return (global::LabApi.Features.Wrappers.Scp244Pickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal Scp244Pickup(global::InventorySystem.Items.Usables.Scp244.Scp244DeployablePickup scp244DeployablePickup)
			: base(scp244DeployablePickup)
		{
			Base = scp244DeployablePickup;
			if (base.CanCache)
			{
				Dictionary.Add(scp244DeployablePickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
