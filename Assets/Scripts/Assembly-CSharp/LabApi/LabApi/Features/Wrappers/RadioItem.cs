namespace LabApi.Features.Wrappers
{
	public class RadioItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Radio.RadioItem, global::LabApi.Features.Wrappers.RadioItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Radio.RadioItem, global::LabApi.Features.Wrappers.RadioItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.RadioItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Radio.RadioItem Base { get; }

		public bool IsUsable => Base.IsUsable;

		public bool IsTransmitting => global::VoiceChat.Playbacks.PersonalRadioPlayback.IsTransmitting(Base.Owner);

		public byte BatteryPercent
		{
			get
			{
				return Base.BatteryPercent;
			}
			set
			{
				Base.BatteryPercent = value;
			}
		}

		public global::InventorySystem.Items.Radio.RadioMessages.RadioRangeLevel RangeLevel => Base.RangeLevel;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseRadioItem")]
		public static global::LabApi.Features.Wrappers.RadioItem? Get(global::InventorySystem.Items.Radio.RadioItem? baseRadioItem)
		{
			if (baseRadioItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseRadioItem, out global::LabApi.Features.Wrappers.RadioItem value))
			{
				return (global::LabApi.Features.Wrappers.RadioItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseRadioItem);
			}
			return value;
		}

		internal RadioItem(global::InventorySystem.Items.Radio.RadioItem baseRadioItem)
			: base(baseRadioItem)
		{
			Base = baseRadioItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseRadioItem, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
