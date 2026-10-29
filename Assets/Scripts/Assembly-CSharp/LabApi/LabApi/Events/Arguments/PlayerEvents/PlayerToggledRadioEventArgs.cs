namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerToggledRadioEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRadioItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.RadioItem RadioItem { get; }

		public bool NewState { get; }

		[global::System.Obsolete("Use RadioItem instead")]
		public global::InventorySystem.Items.Radio.RadioItem Radio => RadioItem.Base;

		public PlayerToggledRadioEventArgs(ReferenceHub hub, global::InventorySystem.Items.Radio.RadioItem radio, bool newState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			RadioItem = global::LabApi.Features.Wrappers.RadioItem.Get(radio);
			NewState = newState;
		}
	}
}
