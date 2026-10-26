using UnityEngine;

public class RagdollInspector : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	[global::UnityEngine.SerializeField]
	private global::UnityEngine.LayerMask _raycastMask;

	[global::UnityEngine.SerializeField]
	private float _raycastDistance;

	[global::UnityEngine.SerializeField]
	private global::TMPro.TextMeshProUGUI _ragdollInspectText;


}
