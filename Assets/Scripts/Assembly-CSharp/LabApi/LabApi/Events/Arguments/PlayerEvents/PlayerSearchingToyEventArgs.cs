namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSearchingToyEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IInteractableEvent, global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.InteractableToy Interactable { get; }

		public bool IsAllowed { get; set; }

		public PlayerSearchingToyEventArgs(ReferenceHub hub, global::AdminToys.InvisibleInteractableToy toy)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Interactable = global::LabApi.Features.Wrappers.InteractableToy.Get(toy);
		}
	}
}
