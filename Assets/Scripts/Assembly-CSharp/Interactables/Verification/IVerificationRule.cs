using UnityEngine;

namespace Interactables.Verification
{
	public interface IVerificationRule
	{
		bool ClientCanInteract(InteractableCollider collider, RaycastHit hit);

		bool ServerCanInteract(ReferenceHub hub, InteractableCollider collider);
	}
}
