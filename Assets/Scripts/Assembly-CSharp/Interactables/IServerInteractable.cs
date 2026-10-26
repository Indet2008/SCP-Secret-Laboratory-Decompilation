using Mirror;

namespace Interactables
{
	public interface IServerInteractable : IInteractable
	{
		[Server]
		void ServerInteract(ReferenceHub ply, byte colliderId);
	}
}
