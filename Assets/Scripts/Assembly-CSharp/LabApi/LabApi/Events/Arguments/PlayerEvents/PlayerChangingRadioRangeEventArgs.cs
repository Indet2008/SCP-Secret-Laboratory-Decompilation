namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangingRadioRangeEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IRadioItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.RadioItem RadioItem { get; }

		public global::InventorySystem.Items.Radio.RadioMessages.RadioRangeLevel Range { get; set; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use RadioItem instead")]
		public global::LabApi.Features.Wrappers.Item Radio => RadioItem;

		public PlayerChangingRadioRangeEventArgs(ReferenceHub hub, global::InventorySystem.Items.Radio.RadioItem radio, global::InventorySystem.Items.Radio.RadioMessages.RadioRangeLevel range)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			RadioItem = global::LabApi.Features.Wrappers.RadioItem.Get(radio);
			Range = range;
		}
	}
}
