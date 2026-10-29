using Interactables;
using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class DoorPingProcessor : IPingProcessor
	{
		public float Range => 60f;

		public LayerMask Mask => InteractionCoordinator.RaycastMask.Mask;

		public int IconId => 1;

		public bool TryProcess(RaycastHit hit)
		{
			if (hit.collider.gameObject.TryGetComponent<InteractableCollider>(out var component))
			{
				return component.Target is DoorVariant;
			}
			return false;
		}
	}
}
