using Mirror;

namespace Interactables
{
	public interface IClientInteractable : IInteractable
	{
		[Client]
		void ClientInteract(InteractableCollider collider);
	}
}
