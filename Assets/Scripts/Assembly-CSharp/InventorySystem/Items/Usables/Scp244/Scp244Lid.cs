using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244
{
	public class Scp244Lid : MonoBehaviour
	{
		[SerializeField]
		private Scp244DeployablePickup _pickup;

		[SerializeField]
		private Vector3 _offset;

		[SerializeField]
		private float _upDot;

		[SerializeField]
		private AudioSource _pressureSound;

		private void Update()
		{
			if (_pickup.State == Scp244State.Active)
			{
				if (Vector3.Dot(base.transform.up, Vector3.up) > _upDot)
				{
					base.transform.localPosition += _offset;
				}
				else
				{
					_pressureSound.enabled = true;
				}
				base.enabled = false;
				base.gameObject.AddComponent<Rigidbody>().collisionDetectionMode = CollisionDetectionMode.ContinuousSpeculative;
			}
		}
	}
}
