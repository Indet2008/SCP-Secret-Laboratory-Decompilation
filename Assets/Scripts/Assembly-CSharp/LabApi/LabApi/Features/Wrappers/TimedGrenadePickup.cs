namespace LabApi.Features.Wrappers
{
	public class TimedGrenadePickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.TimedGrenadePickup, global::LabApi.Features.Wrappers.TimedGrenadePickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ThrowableProjectiles.TimedGrenadePickup, global::LabApi.Features.Wrappers.TimedGrenadePickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.TimedGrenadePickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.ThrowableProjectiles.TimedGrenadePickup Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.TimedGrenadePickup? Get(global::InventorySystem.Items.ThrowableProjectiles.TimedGrenadePickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.TimedGrenadePickup value))
			{
				return (global::LabApi.Features.Wrappers.TimedGrenadePickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal TimedGrenadePickup(global::InventorySystem.Items.ThrowableProjectiles.TimedGrenadePickup baseTimedGrenadePickup)
			: base(baseTimedGrenadePickup)
		{
			Base = baseTimedGrenadePickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseTimedGrenadePickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
