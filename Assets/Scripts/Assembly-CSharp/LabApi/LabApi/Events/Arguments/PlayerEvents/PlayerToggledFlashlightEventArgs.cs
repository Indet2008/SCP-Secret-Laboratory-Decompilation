namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerToggledFlashlightEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ILightItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.LightItem LightItem { get; }

		public bool NewState { get; }

		[global::System.Obsolete("Use LightItem instead")]
		public global::LabApi.Features.Wrappers.Item Item => LightItem;

		public PlayerToggledFlashlightEventArgs(ReferenceHub hub, global::InventorySystem.Items.ToggleableLights.ToggleableLightItemBase item, bool newState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			LightItem = global::LabApi.Features.Wrappers.LightItem.Get(item);
			NewState = newState;
		}
	}
}
