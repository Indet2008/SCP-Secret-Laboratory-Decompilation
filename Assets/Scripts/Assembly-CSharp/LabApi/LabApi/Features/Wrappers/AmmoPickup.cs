namespace LabApi.Features.Wrappers
{
	public class AmmoPickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.Ammo.AmmoPickup, global::LabApi.Features.Wrappers.AmmoPickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Firearms.Ammo.AmmoPickup, global::LabApi.Features.Wrappers.AmmoPickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.AmmoPickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Firearms.Ammo.AmmoPickup Base { get; }

		public ushort Ammo
		{
			get
			{
				return Base.SavedAmmo;
			}
			set
			{
				Base.NetworkSavedAmmo = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.AmmoPickup? Get(global::InventorySystem.Items.Firearms.Ammo.AmmoPickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.AmmoPickup value))
			{
				return (global::LabApi.Features.Wrappers.AmmoPickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal AmmoPickup(global::InventorySystem.Items.Firearms.Ammo.AmmoPickup baseAmmoPickup)
			: base(baseAmmoPickup)
		{
			Base = baseAmmoPickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseAmmoPickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
