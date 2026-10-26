using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

public class PitItemDestroyer : MonoBehaviour
{
	private void OnTriggerEnter(Collider other)
	{
		if (NetworkServer.active)
		{
			ItemPickupBase componentInParent = other.transform.GetComponentInParent<ItemPickupBase>();
			if (!(componentInParent == null))
			{
				NetworkServer.Destroy(componentInParent.gameObject);
			}
		}
	}
}
