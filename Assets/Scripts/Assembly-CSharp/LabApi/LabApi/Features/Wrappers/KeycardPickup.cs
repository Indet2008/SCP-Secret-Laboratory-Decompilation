namespace LabApi.Features.Wrappers
{
	public class KeycardPickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Keycards.KeycardPickup, global::LabApi.Features.Wrappers.KeycardPickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Keycards.KeycardPickup, global::LabApi.Features.Wrappers.KeycardPickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.KeycardPickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Keycards.KeycardPickup Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.KeycardPickup? Get(global::InventorySystem.Items.Keycards.KeycardPickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.KeycardPickup value))
			{
				return (global::LabApi.Features.Wrappers.KeycardPickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal KeycardPickup(global::InventorySystem.Items.Keycards.KeycardPickup baseKeycardPickup)
			: base(baseKeycardPickup)
		{
			Base = baseKeycardPickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseKeycardPickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
