namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUsingRadioEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRadioItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.RadioItem RadioItem { get; }

		public float Drain { get; set; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use RadioItem instead")]
		public global::InventorySystem.Items.Radio.RadioItem Radio => RadioItem.Base;

		public PlayerUsingRadioEventArgs(ReferenceHub hub, global::InventorySystem.Items.Radio.RadioItem radio, float drain)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			RadioItem = global::LabApi.Features.Wrappers.RadioItem.Get(radio);
			Drain = drain;
		}
	}
}
