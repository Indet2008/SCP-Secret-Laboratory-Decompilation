using UnityEngine;

public class CameraFocuser : MonoBehaviour
{
	public Transform lookTarget;

	public float targetFovScale = 1f;

	public float minimumAngle;

	private void OnTriggerStay(Collider other)
	{
		ReferenceHub hub = ReferenceHub.GetHub(other.transform.root.gameObject);
		if (hub != null && hub.characterClassManager.isLocalPlayer)
		{
			base.transform.LookAt(lookTarget);
			Mathf.Clamp(Quaternion.Angle(hub.PlayerCameraReference.rotation, base.transform.rotation), minimumAngle, 70f);
		}
	}
}
