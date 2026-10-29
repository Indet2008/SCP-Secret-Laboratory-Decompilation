namespace LabApi.Features.Wrappers
{
	public class Scp1509Pickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Scp1509.Scp1509Pickup, global::LabApi.Features.Wrappers.Scp1509Pickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Scp1509.Scp1509Pickup, global::LabApi.Features.Wrappers.Scp1509Pickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Scp1509Pickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Scp1509.Scp1509Pickup Base { get; }

		public double NextReviveTime
		{
			get
			{
				return Base.NextReviveTime;
			}
			set
			{
				Base.NextReviveTime = value;
				Base.ResurrectDirty = true;
			}
		}

		public double NextReviveTimeDelta
		{
			get
			{
				return Base.NextReviveTime - global::Mirror.NetworkTime.time;
			}
			set
			{
				Base.NextReviveTime = global::Mirror.NetworkTime.time + value;
				Base.ResurrectDirty = true;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.Scp1509Pickup? Get(global::InventorySystem.Items.Scp1509.Scp1509Pickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.Scp1509Pickup value))
			{
				return (global::LabApi.Features.Wrappers.Scp1509Pickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal Scp1509Pickup(global::InventorySystem.Items.Scp1509.Scp1509Pickup baseScp1509)
			: base(baseScp1509)
		{
			Base = baseScp1509;
			if (base.CanCache)
			{
				Dictionary.Add(baseScp1509, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
