namespace LabApi.Features.Wrappers
{
	public class JailbirdPickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Jailbird.JailbirdPickup, global::LabApi.Features.Wrappers.JailbirdPickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Jailbird.JailbirdPickup, global::LabApi.Features.Wrappers.JailbirdPickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.JailbirdPickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Jailbird.JailbirdPickup Base { get; }

		public float TotalDamageDealt
		{
			get
			{
				return Base.TotalMelee;
			}
			set
			{
				Base.TotalMelee = value;
			}
		}

		public int TotalChargesPerformed
		{
			get
			{
				return Base.TotalCharges;
			}
			set
			{
				Base.TotalCharges = value;
			}
		}

		public global::InventorySystem.Items.Jailbird.JailbirdWearState WearState
		{
			get
			{
				return Base.Wear;
			}
			set
			{
				Base.NetworkWear = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.JailbirdPickup? Get(global::InventorySystem.Items.Jailbird.JailbirdPickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.JailbirdPickup value))
			{
				return (global::LabApi.Features.Wrappers.JailbirdPickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal JailbirdPickup(global::InventorySystem.Items.Jailbird.JailbirdPickup baseJailbirdPickup)
			: base(baseJailbirdPickup)
		{
			Base = baseJailbirdPickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseJailbirdPickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
