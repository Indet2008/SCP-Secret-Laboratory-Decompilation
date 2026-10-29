using Interactables;
using Interactables.Interobjects;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Pinging
{
	public class ElevatorPingProcessor : IPingProcessor
	{
		public float Range => 60f;

		public LayerMask Mask => InteractionCoordinator.RaycastMask.Mask;

		public int IconId => 2;

		public bool TryProcess(RaycastHit hit)
		{
			if (hit.collider.GetComponentInParent<ElevatorDoor>() != null)
			{
				return true;
			}
			return hit.collider.GetComponentInParent<ElevatorChamber>() != null;
		}
	}
}
