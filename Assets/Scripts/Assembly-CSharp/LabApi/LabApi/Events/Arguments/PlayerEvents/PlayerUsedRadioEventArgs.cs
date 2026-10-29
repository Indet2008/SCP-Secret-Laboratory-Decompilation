namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUsedRadioEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IRadioItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.RadioItem RadioItem { get; }

		public float Drain { get; }

		[global::System.Obsolete("Use RadioItem instead")]
		public global::InventorySystem.Items.Radio.RadioItem Radio => RadioItem.Base;

		public PlayerUsedRadioEventArgs(ReferenceHub hub, global::InventorySystem.Items.Radio.RadioItem radio, float drain)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			RadioItem = global::LabApi.Features.Wrappers.RadioItem.Get(radio);
			Drain = drain;
		}
	}
}
