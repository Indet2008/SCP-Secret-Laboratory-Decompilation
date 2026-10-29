namespace LabApi.Features.Wrappers
{
	public class RadioPickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Radio.RadioPickup, global::LabApi.Features.Wrappers.RadioPickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Radio.RadioPickup, global::LabApi.Features.Wrappers.RadioPickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.RadioPickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.Radio.RadioPickup Base { get; }

		public bool IsEnabled
		{
			get
			{
				return Base.SavedEnabled;
			}
			set
			{
				Base.NetworkSavedEnabled = value;
			}
		}

		public global::InventorySystem.Items.Radio.RadioMessages.RadioRangeLevel RangeLevel
		{
			get
			{
				return (global::InventorySystem.Items.Radio.RadioMessages.RadioRangeLevel)Base.SavedRange;
			}
			set
			{
				if (value == global::InventorySystem.Items.Radio.RadioMessages.RadioRangeLevel.RadioDisabled)
				{
					IsEnabled = false;
				}
				else
				{
					Base.NetworkSavedRange = (byte)value;
				}
			}
		}

		public float Battery
		{
			get
			{
				return Base.SavedBattery;
			}
			set
			{
				Base.SavedBattery = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.RadioPickup? Get(global::InventorySystem.Items.Radio.RadioPickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.RadioPickup value))
			{
				return (global::LabApi.Features.Wrappers.RadioPickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal RadioPickup(global::InventorySystem.Items.Radio.RadioPickup baseRadioPickup)
			: base(baseRadioPickup)
		{
			Base = baseRadioPickup;
			if (base.CanCache)
			{
				Dictionary.Add(baseRadioPickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
