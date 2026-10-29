namespace LabApi.Features.Wrappers
{
	public class JailbirdItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Jailbird.JailbirdItem, global::LabApi.Features.Wrappers.JailbirdItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Jailbird.JailbirdItem, global::LabApi.Features.Wrappers.JailbirdItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.JailbirdItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Jailbird.JailbirdItem Base { get; }

		public global::InventorySystem.Items.Jailbird.JailbirdWearState WearState => global::System.Collections.Generic.CollectionExtensions.GetValueOrDefault(global::InventorySystem.Items.Jailbird.JailbirdDeteriorationTracker.ReceivedStates, base.Serial, global::InventorySystem.Items.Jailbird.JailbirdWearState.Healthy);

		public int TotalChargesPerformed => Base.TotalChargesPerformed;

		public bool IsCharging => Base.MovementOverrideActive;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseJailbirdItem")]
		public static global::LabApi.Features.Wrappers.JailbirdItem? Get(global::InventorySystem.Items.Jailbird.JailbirdItem? baseJailbirdItem)
		{
			if (baseJailbirdItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseJailbirdItem, out global::LabApi.Features.Wrappers.JailbirdItem value))
			{
				return (global::LabApi.Features.Wrappers.JailbirdItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseJailbirdItem);
			}
			return value;
		}

		internal JailbirdItem(global::InventorySystem.Items.Jailbird.JailbirdItem baseJailbirdItem)
			: base(baseJailbirdItem)
		{
			Base = baseJailbirdItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseJailbirdItem, this);
			}
		}

		public void Reset()
		{
			Base.ServerReset();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
