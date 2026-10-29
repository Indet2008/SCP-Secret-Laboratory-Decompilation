namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSearchToyAbortedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IInteractableEvent, global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.InteractableToy Interactable { get; }

		public PlayerSearchToyAbortedEventArgs(ReferenceHub hub, global::AdminToys.InvisibleInteractableToy toy)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Interactable = global::LabApi.Features.Wrappers.InteractableToy.Get(toy);
		}
	}
}
