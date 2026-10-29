namespace LabApi.Events.Arguments.Interfaces
{
	public interface IInteractableEvent : global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent
	{
		global::LabApi.Features.Wrappers.AdminToy? global::LabApi.Events.Arguments.Interfaces.IAdminToyEvent.AdminToy => Interactable;

		global::LabApi.Features.Wrappers.InteractableToy? Interactable { get; }
	}
}
